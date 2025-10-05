@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
title Truth or Dare - Shamlan
color 0F

:main_menu
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║           TRUTH OR DARE              ║
echo  ╚══════════════════════════════════════╝
echo.
echo  Choose your intensity level:
echo  [1] Mild Mode (Safe for everyone)
echo  [2] Spicy Mode (A bit more daring)
echo  [3] Wild Mode (Only for the brave!)
echo  [4] Custom Spinner (Pick your own adventure)
echo  [5] Group Mode (Multiple players)
echo  [6] Exit
echo.
set /p choice="Enter your choice (1-6): "

if "%choice%"=="1" goto mild_mode
if "%choice%"=="2" goto spicy_mode
if "%choice%"=="3" goto wild_mode
if "%choice%"=="4" goto custom_mode
if "%choice%"=="5" goto group_mode
if "%choice%"=="6" goto exit_game
goto main_menu

:mild_mode
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║              MILD MODE               ║
echo  ╚══════════════════════════════════════╝
echo.
echo  [T] Truth  [D] Dare  [S] Spin Again  [M] Main Menu
set /p choice="Your choice: "

if /i "%choice%"=="t" (
    call :mild_truth
    timeout /t 2 >nul
    goto mild_mode
)
if /i "%choice%"=="d" (
    call :mild_dare
    timeout /t 2 >nul
    goto mild_mode
)
if /i "%choice%"=="s" goto mild_mode
if /i "%choice%"=="m" goto main_menu

echo.
echo  [1] Spin again  [2] Main menu
set /p again="Your choice: "
if "%again%"=="1" goto mild_mode
goto main_menu

:spicy_mode
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║              SPICY MODE              ║
echo  ╚══════════════════════════════════════╝
echo.
call :spinner_animation
echo.
echo  🌶️ Things are getting spicy!
echo.
echo  [T] Truth  [D] Dare  [S] Spin Again  [M] Main Menu
set /p choice="Your choice: "

if /i "%choice%"=="t" call :spicy_truth
if /i "%choice%"=="d" call :spicy_dare
if /i "%choice%"=="s" goto spicy_mode
if /i "%choice%"=="m" goto main_menu

echo.
echo  [1] Spin again  [2] Main menu
set /p again="Your choice: "
if "%again%"=="1" goto spicy_mode
goto main_menu

:wild_mode
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║              WILD MODE               ║
echo  ╚══════════════════════════════════════╝
echo.
call :spinner_animation
echo.
echo  🔥 ONLY FOR THE BRAVE!
echo.
echo  [T] Truth  [D] Dare  [S] Spin Again  [M] Main Menu
set /p choice="Your choice: "

if /i "%choice%"=="t" call :wild_truth
if /i "%choice%"=="d" call :wild_dare
if /i "%choice%"=="s" goto wild_mode
if /i "%choice%"=="m" goto main_menu

echo.
echo  [1] Spin again  [2] Main menu
set /p again="Your choice: "
if "%again%"=="1" goto wild_mode
goto main_menu

:custom_mode
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║             CUSTOM MODE              ║
echo  ╚══════════════════════════════════════╝
echo.
echo  🎯 Create your own Truth or Dare!
echo.
echo  [1] Create a Truth question
echo  [2] Create a Dare challenge
echo  [3] Random mix from all modes
echo  [4] Main menu
echo.
set /p custom_choice="Your choice: "

if "%custom_choice%"=="1" (
    echo.
    echo  📝 Type your custom truth question:
    set /p custom_truth=" Your question: "
    echo.
    echo  🤔 Truth: !custom_truth!
)
if "%custom_choice%"=="2" (
    echo.
    echo  📝 Type your custom dare challenge:
    set /p custom_dare=" Your dare: "
    echo.
    echo  💀 Dare: !custom_dare!
)
if "%custom_choice%"=="3" call :random_mix
if "%custom_choice%"=="4" goto main_menu

if "%custom_choice%"=="1" goto custom_continue
if "%custom_choice%"=="2" goto custom_continue
if "%custom_choice%"=="3" goto custom_continue
goto custom_mode

:custom_continue
echo.
echo  [1] Create another  [2] Main menu
set /p again="Your choice: "
if "%again%"=="1" goto custom_mode
goto main_menu

:group_mode
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║             GROUP MODE               ║
echo  ╚══════════════════════════════════════╝
echo.
echo  👥 How many players? (2-10)
set /p players="Number of players: "

if %players% lss 2 goto group_mode
if %players% gtr 10 goto group_mode

echo.
echo  📝 Enter player names:
for /l %%i in (1,1,%players%) do (
    set /p player%%i="Player %%i name: "
)

set current_player=1

:group_round
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║             GROUP ROUND              ║
echo  ╚══════════════════════════════════════╝
echo.

call set current_name=%%player%current_player%%%
echo  🎯 !current_name!'s turn!
echo.

call :spinner_animation
echo.
echo  [T] Truth  [D] Dare  [S] Skip Turn  [M] Main Menu
set /p choice="!current_name!'s choice: "

if /i "%choice%"=="t" call :group_truth
if /i "%choice%"=="d" call :group_dare
if /i "%choice%"=="s" echo  😴 !current_name! skipped their turn!
if /i "%choice%"=="m" goto main_menu

echo.
echo  Press any key for next player...
pause >nul

set /a current_player+=1
if %current_player% gtr %players% set current_player=1

goto group_round

:spinner_animation
echo  🎰 SPINNING THE WHEEL...
echo.
echo        ╔═══════════════╗
echo        ║      [T]      ║
echo        ║   [D]   [T]   ║
echo        ║      [D]      ║
echo        ╚═══════════════╝
echo.
echo  ⚡ Spinning...
timeout /t 1 >nul
echo  🌀 Still spinning...
timeout /t 1 >nul
echo  🎯 And it lands on...
timeout /t 1 >nul
goto :eof

:mild_truth
set /a truth_num=%random% %% 15 + 1
echo  🤔 MILD TRUTH:
if %truth_num%==1 echo  What's your favorite color and why?
if %truth_num%==2 echo  What's the weirdest food you actually like?
if %truth_num%==3 echo  What's a fear you have that seems silly to others?
if %truth_num%==4 echo  What is the best dream you've ever had?
if %truth_num%==5 echo  What's your most embarrassing moment in school?
if %truth_num%==6 echo  If you could have any superpower, what would it be and why?
if %truth_num%==7 echo  What's the strangest dream you've ever had?
if %truth_num%==8 echo  What's your favorite movie or TV show and why?
if %truth_num%==9 echo  What's the worst gift you've ever received?
if %truth_num%==10 echo  If you could meet any historical figure, who would it be?
if %truth_num%==11 echo  What's your weirdest habit?
if %truth_num%==12 echo  What's a skill you'd love to learn?
if %truth_num%==13 echo  What's your biggest pet peeve?
if %truth_num%==14 echo  If you could change one thing about you, what would it be?
if %truth_num%==15 echo  What's the funniest TikTok or meme you’ve seen recently?
goto :eof

:mild_dare
set /a dare_num=%random% %% 15 + 1
echo  💀 MILD DARE:
if %dare_num%==1 echo  Do your best impression of a teacher!
if %dare_num%==2 echo  Sing "Happy Birthday" in a funny accent!
if %dare_num%==3 echo  Do 20 jumping jacks!
if %dare_num%==4 echo  Make up a short rap about your day!
if %dare_num%==5 echo  Do your best animal impression!
if %dare_num%==6 echo  Tell a dad joke and laugh at it yourself!
if %dare_num%==7 echo  Do a silly dance for 30 seconds!
if %dare_num%==8 echo  Speak in a pirate voice for the next 5 minutes!
if %dare_num%==9 echo  Do 10 push-ups!
if %dare_num%==10 echo  Make the weirdest face you can for 10 seconds!
if %dare_num%==11 echo  Pretend to be a news reporter and give a weather report!
if %dare_num%==12 echo  Pretend you’re in a video game boss fight for 1 minute!
if %dare_num%==13 echo  Sing the alphabet song backwards (Arabic or English)!
if %dare_num%==14 echo  Act like a robot for 2 minutes!
if %dare_num%==15 echo  Do a magic trick!
goto :eof

:spicy_truth
set /a truth_num=%random% %% 12 + 1
echo  🌶️ SPICY TRUTH:
if %truth_num%==1 echo  What's the funniest thing you've ever searched for online?
if %truth_num%==2 echo  What's a food you pretend to like but actually hate?
if %truth_num%==3 echo  What's the biggest lie you've ever told to get out of homework?
if %truth_num%==4 echo  What's the silliest mistake you've made that no one knows about?
if %truth_num%==5 echo  What's your most embarrassing nickname and how did you get it?
if %truth_num%==6 echo  What's the most childish thing you still do?
if %truth_num%==7 echo  Have you ever pretended to know a song you didn't?
if %truth_num%==8 echo  What's the meanest thing a character did in your favorite show?
if %truth_num%==9 echo  What's a rule at home or school you think is the most boring?
if %truth_num%==10 echo  What's the most overrated video game or movie, in your opinion?
if %truth_num%==11 echo  If you could be principal for a day, what's one silly rule you'd make?
if %truth_num%==12 echo  What's the most embarrassing thing you've ever said to a teacher by accident?
goto :eof

:spicy_dare
set /a dare_num=%random% %% 12 + 1
echo  🌶️ SPICY DARE:
if %dare_num%==1 echo  Say the alphabet backwards as fast as you can (English or Arabic)!
if %dare_num%==2 echo  Do a dramatic reading of your favorite song lyrics!
if %dare_num%==3 echo  Draw something blindfolded and show it!
if %dare_num%==4 echo  Pretend you’re on a cooking show and explain how to make a sandwich!
if %dare_num%==5 echo  Let someone else style your hair however they want!
if %dare_num%==6 echo  Eat a weird food combo!
if %dare_num%==7 echo  Do your most embarrassing dance in front of everyone!
if %dare_num%==8 echo  Act out your most embarrassing school moment!
if %dare_num%==9 echo  Try to talk without moving your lips for 1 minute!
if %dare_num%==10 echo  Do 20 push-ups without stopping!
if %dare_num%==11 echo  Wear socks on your hands for the next 5 minutes!
if %dare_num%==12 echo  Do 30 squats while pretending to be a superhero!
goto :eof

:wild_truth
set /a truth_num=%random% %% 10 + 1
echo  🔥 WILD TRUTH:
if %truth_num%==1 echo  What's the most mischievous thing you've ever done?
if %truth_num%==2 echo  If you had to eat one meal for the rest of your life, what would it be?
if %truth_num%==3 echo  What's the most embarrassing thing you've done in public when you thought no one was looking?
if %truth_num%==4 echo  What's a secret talent you have that almost no one knows about?
if %truth_num%==5 echo  What's the weirdest outfit you've ever worn?
if %truth_num%==6 echo  If you could swap lives with any animal for a week, which would it be?
if %truth_num%==7 echo  What's the longest you've ever gone without showering on purpose (like on vacation)?
if %truth_num%==8 echo  What's the most ridiculous fact you know?
if %truth_num%==9 echo  If your phone was taken away forever, what's the first thing you'd do?
if %truth_num%==10 echo  What's the strangest way you've ever earned or found money?
goto :eof

:wild_dare
set /a dare_num=%random% %% 10 + 1
echo  🔥 WILD DARE:
if %dare_num%==1 echo  Pretend to be a teacher giving a boring lecture for 2 minutes!
if %dare_num%==2 echo  Announce dramatically that you’ve discovered time travel!
if %dare_num%==3 echo  Try to juggle three random objects!
if %dare_num%==4 echo  Pretend you’re in slow motion for 1 minute!
if %dare_num%==5 echo  Do 50 jumping jacks without stopping!
if %dare_num%==6 echo  Share your funniest school story with everyone here!
if %dare_num%==7 echo  Let someone else give you a new nickname for the rest of the game!
if %dare_num%==8 echo  Eat a combo of foods that everyone else picks!
if %dare_num%==9 echo  Do 50 Push-ups without stopping!
if %dare_num%==10 echo  Act like your favorite video game character for 2 minutes!
goto :eof

:group_truth
set /a mode=%random% %% 3 + 1
if %mode%==1 call :mild_truth
if %mode%==2 call :spicy_truth
if %mode%==3 call :wild_truth
goto :eof

:group_dare
set /a mode=%random% %% 3 + 1
if %mode%==1 call :mild_dare
if %mode%==2 call :spicy_dare
if %mode%==3 call :wild_dare
goto :eof

:random_mix
set /a mix_choice=%random% %% 2 + 1
if %mix_choice%==1 (
    set /a mix_mode=%random% %% 3 + 1
    echo  🎲 RANDOM TRUTH:
    if %mix_mode%==1 call :mild_truth
    if %mix_mode%==2 call :spicy_truth
    if %mix_mode%==3 call :wild_truth
) else (
    set /a mix_mode=%random% %% 3 + 1
    echo  🎲 RANDOM DARE:
    if %mix_mode%==1 call :mild_dare
    if %mix_mode%==2 call :spicy_dare
    if %mix_mode%==3 call :wild_dare
)
goto :eof

:exit_game
cls
echo.
echo  Thanks for playing Truth or Dare!
echo  🎭 Hope you learned some interesting secrets!
echo.
pause
exit
