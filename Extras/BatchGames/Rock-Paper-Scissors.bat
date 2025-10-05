@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title Rock-Paper-Scissors - Shamlan
color 0F

:main_menu
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║          ROCK-PAPER-SCISSORS         ║
echo  ╚══════════════════════════════════════╝
echo.
echo  Choose your game mode:
echo  [1] Classic Mode (Best of 5)
echo  [2] Twist Mode (Loser Gets Challenged!)
echo  [3] Streak Challenge
echo  [4] Chaos Mode (Random Events)
echo  [5] Exit
echo.
set /p choice="Enter your choice (1-5): "

if "%choice%"=="1" goto classic_mode
if "%choice%"=="2" goto twist_mode
if "%choice%"=="3" goto streak_mode
if "%choice%"=="4" goto chaos_mode
if "%choice%"=="5" goto exit_game
goto main_menu

:classic_mode
cls
set player_wins=0
set computer_wins=0
set round=1

:classic_round
if %round% gtr 5 goto classic_results
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║            CLASSIC MODE              ║
echo  ╚══════════════════════════════════════╝
echo.
echo  Round %round% of 5
echo  You: %player_wins% ^| Computer: %computer_wins%
echo.
echo  Choose your weapon:
echo  [1] 🗿 Rock     [2] 📄 Paper     [3] ✂️ Scissors
echo.
set /p player_choice="Your choice (1-3): "

if "%player_choice%"=="1" set player_move=Rock
if "%player_choice%"=="2" set player_move=Paper
if "%player_choice%"=="3" set player_move=Scissors
if "%player_choice%" lss "1" goto classic_round
if "%player_choice%" gtr "3" goto classic_round

set /a comp_choice=%random% %% 3 + 1
if "%comp_choice%"=="1" set computer_move=Rock
if "%comp_choice%"=="2" set computer_move=Paper
if "%comp_choice%"=="3" set computer_move=Scissors

echo.
echo  🥊 SHOWDOWN! 🥊
call :show_moves %player_choice% %comp_choice%
echo  You: %player_move% vs Computer: %computer_move%
echo.

call :determine_winner %player_choice% %comp_choice%

set /a round+=1
echo.
echo  Press any key for next round...
pause >nul
goto classic_round

:classic_results
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║            FINAL RESULTS             ║
echo  ╚══════════════════════════════════════╝
echo.
echo  Final Score: You %player_wins% - %computer_wins% Computer
echo.
if %player_wins% gtr %computer_wins% (
    echo  🏆 VICTORY! You dominated the computer!
) else if %computer_wins% gtr %player_wins% (
    echo  💻 Computer wins! Time to practice more!
) else (
    echo  🤝 It's a tie! What are the odds?
)
echo.
echo  Press any key to return to main menu...
pause >nul
goto main_menu

:twist_mode
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║             TWIST MODE               ║
echo  ╚══════════════════════════════════════╝
echo.
echo  🎯 SPECIAL RULES:
echo  • Winner gets bragging rights!
echo  • Loser faces a random challenge!
echo  • Ties = both players safe
echo.
echo  Choose your weapon:
echo  [1] 🗿 Rock     [2] 📄 Paper     [3] ✂️ Scissors
echo.
set /p player_choice="Your choice (1-3): "

if "%player_choice%"=="1" set player_move=Rock
if "%player_choice%"=="2" set player_move=Paper
if "%player_choice%"=="3" set player_move=Scissors
if "%player_choice%" lss "1" goto twist_mode
if "%player_choice%" gtr "3" goto twist_mode

set /a comp_choice=%random% %% 3 + 1
if "%comp_choice%"=="1" set computer_move=Rock
if "%comp_choice%"=="2" set computer_move=Paper
if "%comp_choice%"=="3" set computer_move=Scissors

echo.
echo  🥊 SHOWDOWN! 🥊
call :show_moves %player_choice% %comp_choice%
echo  You: %player_move% vs Computer: %computer_move%
echo.

if %player_choice%==%comp_choice% (
    echo  🤝 TIE! Both players are safe!
    goto twist_continue
)

call :determine_winner %player_choice% %comp_choice%

if "%result%"=="win" (
    echo  🎉 You win! Computer faces the challenge!
    call :computer_challenge
) else (
    echo  😅 You lose! Time for your challenge!
    call :player_challenge
)

:twist_continue
echo.
echo  [1] Play again  [2] Return to menu
set /p twist_choice="Your choice: "
if "%twist_choice%"=="1" goto twist_mode
if "%twist_choice%"=="2" goto main_menu
goto twist_continue

:streak_mode
cls
set streak=0
set best_streak=0

:streak_round
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║           STREAK CHALLENGE           ║
echo  ╚══════════════════════════════════════╝
echo.
echo  Current Streak: %streak% 🔥
echo  Best Streak: %best_streak% ⭐
echo.
echo  🎯 Win 5 in a row for LEGENDARY STATUS!
echo.
echo  Choose your weapon:
echo  [1] 🗿 Rock     [2] 📄 Paper     [3] ✂️ Scissors
echo.
set /p player_choice="Your choice (1-3): "

if "%player_choice%"=="1" set player_move=Rock
if "%player_choice%"=="2" set player_move=Paper
if "%player_choice%"=="3" set player_move=Scissors
if "%player_choice%" lss "1" goto streak_round
if "%player_choice%" gtr "3" goto streak_round

set /a comp_choice=%random% %% 3 + 1
if "%comp_choice%"=="1" set computer_move=Rock
if "%comp_choice%"=="2" set computer_move=Paper
if "%comp_choice%"=="3" set computer_move=Scissors

echo.
echo  🥊 SHOWDOWN! 🥊
call :show_moves %player_choice% %comp_choice%
echo  You: %player_move% vs Computer: %computer_move%
echo.

if %player_choice%==%comp_choice% (
    echo  🤝 TIE! Streak continues!
    goto streak_continue
)

call :determine_winner %player_choice% %comp_choice%

if "%result%"=="win" (
    set /a streak+=1
    echo  🔥 STREAK: %streak%!
    if %streak% geq 5 (
        echo  🏆 LEGENDARY STATUS ACHIEVED!
        if %streak% gtr %best_streak% set best_streak=%streak%
    )
) else (
    echo  💔 Streak broken at %streak%!
    if %streak% gtr %best_streak% set best_streak=%streak%
    set streak=0
)

:streak_continue
echo.
echo  [1] Continue streak  [2] Return to menu
set /p streak_choice="Your choice: "
if "%streak_choice%"=="1" goto streak_round
if "%streak_choice%"=="2" goto main_menu
goto streak_continue

:chaos_mode
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║             CHAOS MODE               ║
echo  ╚══════════════════════════════════════╝
echo.
echo  ⚡ CHAOS RULES: Random events can happen!
echo.

set /a chaos_event=%random% %% 4
if %chaos_event%==0 (
    echo  🌟 LUCKY ROUND: You get to see computer's choice first!
    set /a comp_choice=%random% %% 3 + 1
    if "%comp_choice%"=="1" echo  Computer will play: 🗿 Rock
    if "%comp_choice%"=="2" echo  Computer will play: 📄 Paper
    if "%comp_choice%"=="3" echo  Computer will play: ✂️ Scissors
    echo.
)

echo  Choose your weapon:
echo  [1] 🗿 Rock     [2] 📄 Paper     [3] ✂️ Scissors
echo.
set /p player_choice="Your choice (1-3): "

if "%player_choice%"=="1" set player_move=Rock
if "%player_choice%"=="2" set player_move=Paper
if "%player_choice%"=="3" set player_move=Scissors
if "%player_choice%" lss "1" goto chaos_mode
if "%player_choice%" gtr "3" goto chaos_mode

if %chaos_event% neq 0 (
    set /a comp_choice=%random% %% 3 + 1
)
if "%comp_choice%"=="1" set computer_move=Rock
if "%comp_choice%"=="2" set computer_move=Paper
if "%comp_choice%"=="3" set computer_move=Scissors

echo.
echo  🥊 CHAOS SHOWDOWN!

if %chaos_event%==1 (
    echo  ⚡ CHAOS EVENT: Double or nothing! Winner gets 2 points!
)
if %chaos_event%==2 (
    echo  ⚡ CHAOS EVENT: Reverse psychology! Loser actually wins!
)
if %chaos_event%==3 (
    echo  ⚡ CHAOS EVENT: Mirror match! You both chose the same thing!
    set comp_choice=%player_choice%
    set computer_move=%player_move%
)

call :show_moves %player_choice% %comp_choice%
echo  You: %player_move% vs Computer: %computer_move%
echo.

if %player_choice%==%comp_choice% (
    echo  🌀 CHAOS TIE! The universe is confused!
) else (
    call :determine_winner %player_choice% %comp_choice%
    if %chaos_event%==2 (
        if "%result%"=="win" (
            echo  🔄 REVERSED! You actually lose due to chaos!
        ) else (
            echo  🔄 REVERSED! You actually win due to chaos!
        )
    )
)

echo.
echo  [1] More chaos  [2] Return to menu
set /p chaos_choice="Your choice: "
if "%chaos_choice%"=="1" goto chaos_mode
if "%chaos_choice%"=="2" goto main_menu
goto chaos_mode

:show_moves
if "%1"=="1" (
    echo        🗿
    echo     YOU: ROCK
)
if "%1"=="2" (
    echo        📄
    echo     YOU: PAPER
)
if "%1"=="3" (
    echo        ✂️
    echo    YOU: SCISSORS
)
echo.
echo         VS
echo.
if "%2"=="1" (
    echo        🗿
    echo    AI: ROCK
)
if "%2"=="2" (
    echo        📄
    echo    AI: PAPER
)
if "%2"=="3" (
    echo        ✂️
    echo   AI: SCISSORS
)
goto :eof

:determine_winner
set result=
if %1==1 if %2==3 set result=win
if %1==2 if %2==1 set result=win
if %1==3 if %2==2 set result=win
if %1==1 if %2==2 set result=lose
if %1==2 if %2==3 set result=lose
if %1==3 if %2==1 set result=lose

if "%result%"=="win" (
    echo  🎉 You WIN this round!
    if defined player_wins set /a player_wins+=1
)
if "%result%"=="lose" (
    echo  💻 Computer WINS this round!
    if defined computer_wins set /a computer_wins+=1
)
goto :eof

:player_challenge
set /a challenge=%random% %% 6 + 1
echo.
echo  💀 YOUR CHALLENGE:
if %challenge%==1 (
    echo  🎭 Do your best impression of a famous person!
    echo  Type who you're impersonating:
    set /p impression=" Impersonating: "
    echo  😂 Nice impression of !impression!!
)
if %challenge%==2 (
    echo  💪 Do 15 jumping jacks right now!
    echo  Type 'DONE' when finished:
    set /p exercise=" Status: "
    echo  🏃 Great workout!
)
if %challenge%==3 (
    echo  🎵 Sing the first line of your favorite song!
    echo  Type the line you just sang:
    set /p song=" Song line: "
    echo  🎤 Beautiful performance!
)
if %challenge%==4 (
    echo  🤡 Tell a dad joke that will make everyone groan!
    echo  Type your dad joke:
    set /p joke=" Your joke: "
    echo  🙄 That was beautifully terrible!
)
if %challenge%==5 (
    echo  😳 Share an unpopular opinion you have!
    echo  Type your unpopular opinion:
    set /p opinion=" Your opinion: "
    echo  🤔 That's definitely controversial!
)
if %challenge%==6 (
    echo  🕺 Do a victory dance for the computer!
    echo  Describe your dance moves:
    set /p dance=" Dance moves: "
    echo  💃 The computer appreciates your moves!
)
goto :eof

:computer_challenge
set /a challenge=%random% %% 6 + 1
echo.
echo  🤖 COMPUTER'S CHALLENGE:
if %challenge%==1 echo  💻 Computer tried to do push-ups but just beeped sadly
if %challenge%==2 echo  🔌 Computer attempted to sing but only made dial-up noises
if %challenge%==3 echo  💾 Computer shared its most embarrassing bug from 1999
if %challenge%==4 echo  ⌨️ Computer tried to dance but just flashed its screen
if %challenge%==5 echo  🖥️ Computer told a joke: "Why don't computers ever get cold? They have Windows!"
if %challenge%==6 echo  🎮 Computer attempted to cry but just leaked some coolant
goto :eof

:exit_game
cls
echo.
echo  Thanks for playing Rock Paper Scissors!
echo  🗿📄✂️ May the best hand win!
echo.
pause
exit
