@echo off
chcp 65001 >nul
title Tic-Tac-Toe - Shamlan
color 0F
setlocal enabledelayedexpansion

:menu
cls
echo.
echo ████████╗██╗ ██████╗              ████████╗ █████╗  ██████╗              ████████╗ ██████╗ ███████╗
echo ╚══██╔══╝██║██╔════╝              ╚══██╔══╝██╔══██╗██╔════╝              ╚══██╔══╝██╔═══██╗██╔════╝
echo    ██║   ██║██║         █████╗       ██║   ███████║██║         █████╗       ██║   ██║   ██║█████╗  
echo    ██║   ██║██║         ╚════╝       ██║   ██╔══██║██║         ╚════╝       ██║   ██║   ██║██╔══╝  
echo    ██║   ██║╚██████╗                 ██║   ██║  ██║╚██████╗                 ██║   ╚██████╔╝███████╗
echo    ╚═╝   ╚═╝ ╚═════╝                 ╚═╝   ╚═╝  ╚═╝ ╚═════╝                 ╚═╝    ╚═════╝ ╚══════╝
echo.
echo                              Press any key to start!
pause >nul

:newgame
set a1= 
set a2= 
set a3= 
set b1= 
set b2= 
set b3= 
set c1= 
set c2= 
set c3= 
set player=X
set moves=0

:game
cls
echo.
echo    Current Player: %player%
echo.
echo        │   │   
echo     !a1!  │ !a2! │ !a3! 
echo    ────┼───┼────
echo     !b1!  │ !b2! │ !b3! 
echo    ────┼───┼────
echo     !c1!  │ !c2! │ !c3! 
echo        │   │   
echo.
echo Choose position (1-9):
echo     1 │ 2 │3 
echo     ──┼───┼──
echo     4 │ 5 │ 6
echo     ──┼───┼──
echo     7 │ 8 │9
echo.
set /p pos="Enter position: "

if "!pos!"=="1" (
    if "!a1!"==" " (
        set a1=%player%
        set /a moves+=1
        goto check
    ) else (
        echo Position taken! Try again.
        timeout 2 >nul
        goto game
    )
)
if "!pos!"=="2" (
    if "!a2!"==" " (
        set a2=%player%
        set /a moves+=1
        goto check
    ) else (
        echo Position taken! Try again.
        timeout 2 >nul
        goto game
    )
)
if "!pos!"=="3" (
    if "!a3!"==" " (
        set a3=%player%
        set /a moves+=1
        goto check
    ) else (
        echo Position taken! Try again.
        timeout 2 >nul
        goto game
    )
)
if "!pos!"=="4" (
    if "!b1!"==" " (
        set b1=%player%
        set /a moves+=1
        goto check
    ) else (
        echo Position taken! Try again.
        timeout 2 >nul
        goto game
    )
)
if "!pos!"=="5" (
    if "!b2!"==" " (
        set b2=%player%
        set /a moves+=1
        goto check
    ) else (
        echo Position taken! Try again.
        timeout 2 >nul
        goto game
    )
)
if "!pos!"=="6" (
    if "!b3!"==" " (
        set b3=%player%
        set /a moves+=1
        goto check
    ) else (
        echo Position taken! Try again.
        timeout 2 >nul
        goto game
    )
)
if "!pos!"=="7" (
    if "!c1!"==" " (
        set c1=%player%
        set /a moves+=1
        goto check
    ) else (
        echo Position taken! Try again.
        timeout 2 >nul
        goto game
    )
)
if "!pos!"=="8" (
    if "!c2!"==" " (
        set c2=%player%
        set /a moves+=1
        goto check
    ) else (
        echo Position taken! Try again.
        timeout 2 >nul
        goto game
    )
)
if "!pos!"=="9" (
    if "!c3!"==" " (
        set c3=%player%
        set /a moves+=1
        goto check
    ) else (
        echo Position taken! Try again.
        timeout 2 >nul
        goto game
    )
)
echo Invalid input! Try again.
timeout 2 >nul
goto game

:check
REM Check for wins
REM Horizontal
if "!a1!"=="!a2!" if "!a2!"=="!a3!" if not "!a1!"==" " goto win
if "!b1!"=="!b2!" if "!b2!"=="!b3!" if not "!b1!"==" " goto win
if "!c1!"=="!c2!" if "!c2!"=="!c3!" if not "!c1!"==" " goto win
REM Vertical
if "!a1!"=="!b1!" if "!b1!"=="!c1!" if not "!a1!"==" " goto win
if "!a2!"=="!b2!" if "!b2!"=="!c2!" if not "!a2!"==" " goto win
if "!a3!"=="!b3!" if "!b3!"=="!c3!" if not "!a3!"==" " goto win
REM Diagonal
if "!a1!"=="!b2!" if "!b2!"=="!c3!" if not "!a1!"==" " goto win
if "!a3!"=="!b2!" if "!b2!"=="!c1!" if not "!a3!"==" " goto win

REM Check for tie
if !moves!==9 goto tie

REM Switch player
if "!player!"=="X" (
    set player=O
) else (
    set player=X
)
goto game

:win
cls
echo.
echo        │   │   
echo     !a1!  │ !a2! │ !a3! 
echo    ────┼───┼────
echo     !b1!  │ !b2! │ !b3! 
echo    ────┼───┼────
echo     !c1!  │ !c2! │ !c3! 
echo        │   │   
echo.
echo    🎉 Player %player% WINS! 🎉
echo.
echo    Play again? (y/n)
set /p again=
if /i "!again!"=="y" goto newgame
goto end

:tie
cls
echo.
echo        │   │   
echo     !a1!  │ !a2! │ !a3! 
echo    ────┼───┼────
echo     !b1!  │ !b2! │ !b3! 
echo    ────┼───┼────
echo     !c1!  │ !c2! │ !c3! 
echo        │   │   
echo.
echo    🤝 It's a TIE! 🤝
echo.
echo    Play again? (y/n)
set /p again=
if /i "!again!"=="y" goto newgame
goto end

:end
echo Thanks for playing!
pause
