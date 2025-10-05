@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title Number Guessing - Shamlan
color 0F

:main_menu
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║         NUMBER GUESSING GAME         ║
echo  ╚══════════════════════════════════════╝
echo.
echo  Choose your game mode:
echo  [1] Easy Mode (1-10)
echo  [2] Medium Mode (1-50)
echo  [3] Hard Mode (1-100)
echo  [4] Nightmare Mode (1-500)
echo  [5] Reverse Mode (Computer guesses YOUR number!)
echo  [6] Hot/Cold Mode (Temperature hints)
echo  [7] Challenge Mode (Guess with consequences!)
echo  [8] Exit
echo.
set /p choice="Enter your choice (1-8): "

if "%choice%"=="1" goto easy_mode
if "%choice%"=="2" goto medium_mode
if "%choice%"=="3" goto hard_mode
if "%choice%"=="4" goto nightmare_mode
if "%choice%"=="5" goto reverse_mode
if "%choice%"=="6" goto hotcold_mode
if "%choice%"=="7" goto challenge_mode
if "%choice%"=="8" goto exit_game
goto main_menu

:easy_mode
set max_num=10
set max_attempts=4
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║              EASY MODE               ║
echo  ╚══════════════════════════════════════╝
echo.
echo  🎯 I'm thinking of a number between 1 and %max_num%
echo  🎮 You have %max_attempts% attempts to guess it!
echo.
set /a target=%random% %% %max_num% + 1
set attempts=0
goto guess_loop

:medium_mode
set max_num=50
set max_attempts=7
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║             MEDIUM MODE              ║
echo  ╚══════════════════════════════════════╝
echo.
echo  🎯 I'm thinking of a number between 1 and %max_num%
echo  🎮 You have %max_attempts% attempts to guess it!
echo.
set /a target=%random% %% %max_num% + 1
set attempts=0
goto guess_loop

:hard_mode
set max_num=100
set max_attempts=10
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║              HARD MODE               ║
echo  ╚══════════════════════════════════════╝
echo.
echo  🎯 I'm thinking of a number between 1 and %max_num%
echo  🎮 You have %max_attempts% attempts to guess it!
echo.
set /a target=%random% %% %max_num% + 1
set attempts=0
goto guess_loop

:nightmare_mode
set max_num=500
set max_attempts=15
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║            NIGHTMARE MODE            ║
echo  ╚══════════════════════════════════════╝
echo.
echo  🎯 I'm thinking of a number between 1 and %max_num%
echo  🎮 You have %max_attempts% attempts to guess it!
echo.
set /a target=%random% %% %max_num% + 1
set attempts=0
goto guess_loop

:guess_loop
set /a attempts+=1
echo  📝 Attempt %attempts% of %max_attempts%
set /p guess="Enter your guess: "

if "%guess%"=="" goto guess_loop
if %guess% lss 1 (
    echo  ❌ Please enter a number between 1 and %max_num%!
    set /a attempts-=1
    goto guess_loop
)
if %guess% gtr %max_num% (
    echo  ❌ Please enter a number between 1 and %max_num%!
    set /a attempts-=1
    goto guess_loop
)

if %guess%==%target% (
    echo.
    echo  🎉 BULLSEYE! You got it in %attempts% attempts!
    echo  🏆 The number was %target%!
    call :celebrate_win %attempts%
    goto play_again_menu
)

if %guess% lss %target% (
    echo  📈 Too LOW! The number is HIGHER than %guess%
) else (
    echo  📉 Too HIGH! The number is LOWER than %guess%
)

if %attempts% geq %max_attempts% (
    echo.
    echo  💀 GAME OVER! You've used all %max_attempts% attempts!
    echo  🎯 The number was %target%
    call :game_over_consequence
    goto play_again_menu
)

echo.
goto guess_loop

:reverse_mode
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║            REVERSE MODE              ║
echo  ╚══════════════════════════════════════╝
echo.
echo  🔄 YOU pick a number, I'll try to guess it!
echo  📝 Pick a number between 1 and 100 (don't tell me!)
echo.
pause

set comp_min=1
set comp_max=100
set comp_attempts=0

:computer_guess
set /a comp_attempts+=1
set /a comp_guess=(%comp_min%+%comp_max%)/2

echo.
echo  🤖 Attempt %comp_attempts%: I guess %comp_guess%!
echo.
echo  Is your number:
echo  [1] Higher than %comp_guess%
echo  [2] Lower than %comp_guess%  
echo  [3] EXACTLY %comp_guess% (I win!)
echo.
set /p feedback="Your response (1-3): "

if "%feedback%"=="3" (
    echo.
    echo  🎉 I GOT IT! Your number was %comp_guess%!
    echo  🤖 I guessed it in %comp_attempts% attempts!
    echo  💻 Binary search for the win!
    goto play_again_menu
)

if "%feedback%"=="1" (
    set /a comp_min=%comp_guess%+1
    echo  📈 Got it, higher than %comp_guess%...
)

if "%feedback%"=="2" (
    set /a comp_max=%comp_guess%-1
    echo  📉 Got it, lower than %comp_guess%...
)

if %comp_attempts% geq 10 (
    echo.
    echo  🤔 Hmm, this is taking a while...
    echo  🕵️ Are you sure you're being honest?
    goto play_again_menu
)

goto computer_guess

:hotcold_mode
cls
set /a target=%random% %% 50 + 1
set attempts=0
set last_distance=999

echo.
echo  ╔══════════════════════════════════════╗
echo  ║            HOT/COLD MODE             ║
echo  ╚══════════════════════════════════════╝
echo.
echo  🌡️ I'll give you temperature hints!
echo  🎯 Number is between 1 and 50
echo.

:hotcold_loop
set /a attempts+=1
echo  🔥 Attempt %attempts%
set /p guess="Enter your guess: "

if "%guess%"=="" goto hotcold_loop
if %guess% lss 1 goto hotcold_loop
if %guess% gtr 50 goto hotcold_loop

if %guess%==%target% (
    echo.
    echo  🔥 SCORCHING HOT! You got it! 🔥
    echo  🎯 The number was %target%!
    goto play_again_menu
)

set /a distance=%guess%-%target%
if %distance% lss 0 set /a distance=-%distance%

if %distance% leq 2 (
    echo  🔥 SCORCHING HOT! So close!
) else if %distance% leq 5 (
    echo  ♨️ HOT! You're getting there!
) else if %distance% leq 10 (
    echo  🌡️ WARM! On the right track!
) else if %distance% leq 15 (
    echo  🧊 COOL! Not quite there yet!
) else (
    echo  ❄️ FREEZING COLD! Way off!
)

if %last_distance% lss 999 (
    if %distance% lss %last_distance% (
        echo  🎯 Getting WARMER!
    ) else (
        echo  🥶 Getting COLDER!
    )
)

set last_distance=%distance%
echo.
goto hotcold_loop

:challenge_mode
cls
set /a target=%random% %% 20 + 1
set attempts=0

echo.
echo  ╔══════════════════════════════════════╗
echo  ║           CHALLENGE MODE             ║
echo  ╚══════════════════════════════════════╝
echo.
echo  💀 DANGER ZONE: Every wrong guess = a dare!
echo  🎯 Number is between 1 and 20
echo  ⚡ Guess wisely!
echo.

:challenge_loop
set /a attempts+=1
echo  ⚔️ Attempt %attempts%
set /p guess="Enter your guess: "

if "%guess%"=="" goto challenge_loop
if %guess% lss 1 goto challenge_loop
if %guess% gtr 20 goto challenge_loop

if %guess%==%target% (
    echo.
    echo  🏆 CHAMPION! You avoided all the dares!
    echo  🎯 The number was %target%!
    goto play_again_menu
)

echo  ❌ WRONG! Time for your dare!
call :challenge_dare %attempts%

if %guess% lss %target% (
    echo  📈 The number is HIGHER than %guess%
) else (
    echo  📉 The number is LOWER than %guess%
)

echo.
goto challenge_loop

:challenge_dare
set /a dare=%random% %% 8 + 1
echo.
echo  💀 DARE #%1:
if %dare%==1 (
    echo  🗣️ Yell "I'M TERRIBLE AT GUESSING!" as loud as you can!
    echo  Type 'DONE' when you've yelled:
    set /p done=" Status: "
)
if %dare%==2 (
    echo  🤡 Do 10 silly poses in a row!
    echo  Type 'DONE' when you've finished posing:
    set /p done=" Status: "
)
if %dare%==3 (
    echo  📱 Text someone "I lost a guessing game" right now!
    echo  Type 'SENT' when you've sent the text:
    set /p done=" Status: "
)
if %dare%==4 (
    echo  🎵 Sing "Twinkle Twinkle Little Star" in a funny voice!
    echo  Type 'SUNG' when you've performed:
    set /p done=" Status: "
)
if %dare%==5 (
    echo  🏃 Do jumping jacks for 30 seconds!
    echo  Type 'EXERCISED' when you're done:
    set /p done=" Status: "
)
if %dare%==6 (
    echo  😂 Tell everyone your most embarrassing moment!
    echo  Type a short version of your story:
    set /p story=" Your story: "
    echo  😅 Thanks for sharing!
)
if %dare%==7 (
    echo  🤪 Make the weirdest face you can for 10 seconds!
    echo  Type 'WEIRD' when you've made the face:
    set /p done=" Status: "
)
if %dare%==8 (
    echo  🍕 Confess your weirdest food combination!
    echo  Type your weird food combo:
    set /p food=" Weird combo: "
    echo  🤢 That sounds... interesting!
)
goto :eof

:celebrate_win
if %1 leq 3 (
    echo  🏆 LEGENDARY PERFORMANCE! Under 3 attempts!
) else if %1 leq 5 (
    echo  🥇 EXCELLENT! Great guessing skills!
) else if %1 leq 8 (
    echo  🥈 GOOD JOB! Solid performance!
) else (
    echo  🥉 NOT BAD! You made it in the end!
)
goto :eof

:game_over_consequence
set /a consequence=%random% %% 4 + 1
echo.
echo  💀 GAME OVER CONSEQUENCE:
if %consequence%==1 (
    echo  🤦 Do a facepalm and say "I give up!"
)
if %consequence%==2 (
    echo  😤 Admit that the computer is smarter than you!
)
if %consequence%==3 (
    echo  🎭 Do your best "dramatic defeat" performance!
)
if %consequence%==4 (
    echo  🤷 Shrug and say "Math was never my strong suit!"
)
echo  Press any key to accept your fate...
pause >nul
goto :eof

:play_again_menu
echo.
echo  [1] Play same mode again  [2] Choose different mode  [3] Main menu
set /p play_choice="Your choice: "
if "%play_choice%"=="1" (
    if "%difficulty%"=="EASY" goto easy_mode
    if "%difficulty%"=="MEDIUM" goto medium_mode
    if "%difficulty%"=="HARD" goto hard_mode
    if "%difficulty%"=="NIGHTMARE" goto nightmare_mode
)
if "%play_choice%"=="2" goto main_menu
if "%play_choice%"=="3" goto main_menu
goto play_again_menu

:exit_game
cls
echo.
echo  Thanks for playing the Number Guessing Game!
echo  🎯 Your intuition will improve with practice!
echo.
pause
exit
