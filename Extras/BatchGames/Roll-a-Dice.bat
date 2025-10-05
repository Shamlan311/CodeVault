@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title Roll-a-Dice - Shamlan
color 0F

:main_menu
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║          ROLL-A-DICE GAME            ║
echo  ╚══════════════════════════════════════╝
echo.
echo  Choose your game mode:
echo  [1] Single Roll
echo  [2] Best of 3 vs Computer
echo  [3] Target Number Challenge
echo  [4] Lucky 7s (Roll until you get 7)
echo  [5] Exit
echo.
set /p choice="Enter your choice (1-5): "

if "%choice%"=="1" goto single_roll
if "%choice%"=="2" goto best_of_three
if "%choice%"=="3" goto target_challenge
if "%choice%"=="4" goto lucky_sevens
if "%choice%"=="5" goto exit_game
goto main_menu

:single_roll
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║            SINGLE ROLL               ║
echo  ╚══════════════════════════════════════╝
echo.
echo  🎯 SPECIAL RULES:
echo  • Roll 6 = Roll again!
echo  • Roll 5 = Share a fun fact
echo  • Roll 4 = Tell an embarrassing story
echo  • Roll 3 = Do 10 push-ups
echo  • Roll 2 = Make a silly face
echo  • Roll 1 = You're safe!
echo.
echo Press any key to roll the dice...
pause >nul

:roll_again
call :roll_dice
echo  🎲 You rolled: %dice_result%
echo.
call :show_dice_art %dice_result%
echo.

if "%dice_result%"=="6" (
    echo  🎲 ROLL AGAIN! You got a 6 - time for another roll!
    echo  Press any key to roll again...
    pause >nul
    echo.
    goto roll_again
)
if "%dice_result%"=="5" (
    echo  🧠 FUN FACT TIME!
    echo  Share an interesting fun fact with everyone!
    echo  Type your fun fact below:
    set /p fact=" Your fun fact: "
    echo.
    echo  🤓 Cool fact: "!fact!"
    echo  Thanks for teaching us something new!
)
if "%dice_result%"=="4" (
    echo  😳 EMBARRASSING STORY TIME!
    echo  You must tell everyone an embarrassing story about yourself!
    echo  Type your embarrassing story below and press Enter:
    set /p story=" Your story: "
    echo.
    echo  😂 Thanks for sharing: "!story!"
    echo  Everyone had a good laugh!
)
if "%dice_result%"=="3" (
    echo  💪 PUSH-UP TIME!
    echo  Drop and give me 10 push-ups right now!
    echo  Type 'DONE' when you've finished your push-ups:
    set /p pushups=" Status: "
    echo  💪 Great job getting those muscles working!
)
if "%dice_result%"=="2" (
    echo  🤪 SILLY FACE TIME!
    echo  Make your silliest face right now!
    echo  Hold it for 5 seconds... 5... 4... 3... 2... 1...
    echo  😄 Perfect! That was hilarious!
)
if "%dice_result%"=="1" (
    echo  😌 YOU'RE SAFE!
    echo  Lucky you - no special challenge this time!
    echo  🍀 Rolling a 1 saved you from any embarrassment!
)

echo.
echo  Press any key to return to main menu...
pause >nul
goto main_menu

:best_of_three
cls
set player_wins=0
set computer_wins=0
set round=1

:bot_round
if %round% gtr 3 goto bot_results
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║          BEST OF 3 vs AI             ║
echo  ╚══════════════════════════════════════╝
echo.
echo  Round %round% of 3
echo  Player Wins: %player_wins% ^| Computer Wins: %computer_wins%
echo.
echo  Press any key to roll...
pause >nul

call :roll_dice
set player_roll=%dice_result%
echo  🎲 You rolled: %player_roll%
call :show_dice_art %player_roll%

call :roll_dice
set computer_roll=%dice_result%
echo  🤖 Computer rolled: %computer_roll%
call :show_dice_art %computer_roll%

if %player_roll% gtr %computer_roll% (
    echo  🎉 You win this round!
    set /a player_wins+=1
) else if %computer_roll% gtr %player_roll% (
    echo  😔 Computer wins this round!
    set /a computer_wins+=1
) else (
    echo  🤝 It's a tie! No points awarded.
)

set /a round+=1
echo.
echo  Press any key for next round...
pause >nul
goto bot_round

:bot_results
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║            FINAL RESULTS             ║
echo  ╚══════════════════════════════════════╝
echo.
echo  Player Wins: %player_wins%
echo  Computer Wins: %computer_wins%
echo.
if %player_wins% gtr %computer_wins% (
    echo  🏆 CONGRATULATIONS! YOU WON THE MATCH! 🏆
) else if %computer_wins% gtr %player_wins% (
    echo  🤖 Computer wins the match! Better luck next time!
) else (
    echo  🤝 It's a tie match! Great game!
)
echo.
echo  Press any key to return to main menu...
pause >nul
goto main_menu

:target_challenge
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║        TARGET NUMBER CHALLENGE       ║
echo  ╚══════════════════════════════════════╝
echo.
set /a target=%random% %% 6 + 1
echo  🎯 Target Number: %target%
echo  Try to roll the target number!
echo.
set attempts=0

:target_loop
set /a attempts+=1
echo  Attempt #%attempts%
echo  Press any key to roll...
pause >nul

call :roll_dice
echo  🎲 You rolled: %dice_result%
call :show_dice_art %dice_result%

if %dice_result%==%target% (
    echo.
    echo  🎉 BULLSEYE! You hit the target in %attempts% attempts!
    echo.
    echo  Press any key to return to main menu...
    pause >nul
    goto main_menu
) else (
    echo  ❌ Not quite! Try again...
    echo.
    goto target_loop
)

:lucky_sevens
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║             LUCKY 7s                 ║
echo  ╚══════════════════════════════════════╝
echo.
echo  Roll two dice and try to get a total of 7!
echo.
set attempts=0

:seven_loop
set /a attempts+=1
echo  Attempt #%attempts%
echo  Press any key to roll both dice...
pause >nul

call :roll_dice
set dice1=%dice_result%
call :roll_dice
set dice2=%dice_result%
set /a total=%dice1%+%dice2%

echo  🎲 Dice 1: %dice1% ^| 🎲 Dice 2: %dice2% ^| Total: %total%
echo.

if %total%==7 (
    echo  🍀 LUCKY 7! You got it in %attempts% attempts!
    echo.
    echo  Press any key to return to main menu...
    pause >nul
    goto main_menu
) else (
    echo  Keep trying for that lucky 7...
    echo.
    goto seven_loop
)

:roll_dice
set /a dice_result=%random% %% 6 + 1
goto :eof

:show_dice_art
if "%1"=="1" (
    echo     ┌─────────┐
    echo     │         │
    echo     │    ●    │
    echo     │         │
    echo     └─────────┘
)
if "%1"=="2" (
    echo     ┌─────────┐
    echo     │ ●       │
    echo     │         │
    echo     │       ● │
    echo     └─────────┘
)
if "%1"=="3" (
    echo     ┌─────────┐
    echo     │ ●       │
    echo     │    ●    │
    echo     │       ● │
    echo     └─────────┘
)
if "%1"=="4" (
    echo     ┌─────────┐
    echo     │ ●     ● │
    echo     │         │
    echo     │ ●     ● │
    echo     └─────────┘
)
if "%1"=="5" (
    echo     ┌─────────┐
    echo     │ ●     ● │
    echo     │    ●    │
    echo     │ ●     ● │
    echo     └─────────┘
)
if "%1"=="6" (
    echo     ┌─────────┐
    echo     │ ●     ● │
    echo     │ ●     ● │
    echo     │ ●     ● │
    echo     └─────────┘
)
goto :eof

:exit_game
cls
echo.
echo  Thanks for playing Roll-a-Dice!
echo  🎲 Come back anytime! 🎲
echo.
pause
exit
