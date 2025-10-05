@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title Hangman - Shamlan
color 0F
:: Starting the journey...

set "lowercase=abcdefghijklmnopqrstuvwxyz"
set "uppercase=ABCDEFGHIJKLMNOPQRSTUVWXYZ"
set "version=2.0"
set "author=Shamlan"
set "total_games=0"
set "wins=0"
set "losses=0"

:splash_screen
cls
echo.
echo   ██╗  ██╗ █████╗ ███╗   ██╗ ██████╗ ███╗   ███╗ █████╗ ███╗   ██╗
echo   ██║  ██║██╔══██╗████╗  ██║██╔════╝ ████╗ ████║██╔══██╗████╗  ██║
echo   ███████║███████║██╔██╗ ██║██║  ███╗██╔████╔██║███████║██╔██╗ ██║
echo   ██╔══██║██╔══██║██║╚██╗██║██║   ██║██║╚██╔╝██║██╔══██║██║╚██╗██║
echo   ██║  ██║██║  ██║██║ ╚████║╚██████╔╝██║ ╚═╝ ██║██║  ██║██║ ╚████║
echo   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
echo.
echo                           Loading game...
echo.
timeout /t 2 >nul
for /l %%i in (1,1,13) do <nul set /p "=█"
timeout /t 2 >nul
for /l %%i in (1,1,40) do <nul set /p "=█"
timeout /t 1 >nul
for /l %%i in (1,1,10) do <nul set /p "=█"
timeout /t 1 >nul
for /l %%i in (1,1,4) do <nul set /p "=█"

echo.
echo.
echo                  Press any key to start the game!
pause >nul

:main_menu
cls
call :get_current_time
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║                          🎯 HANGMAN                          ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo  📅 %current_time%
echo  📊 Session Stats: %wins%W/%losses%L
echo.
echo  🎮 Choose your adventure:
echo  ┌────────────────────────────────────────────────────────────┐
echo  │  [1] 🦄 Single Player Challenge                            │
echo  │  [2] 👥 Multiplayer Battle Arena                           │
echo  │  [3] 🏆 Tournament Mode (Coming Soon!)                      │
echo  │  [4] ⚙️ Game Settings                                      │
echo  │  [5] 📚 How to Play                                        │
echo  │  [6] 📈 View Statistics                                    │
echo  │  [7] 🎨 Customizations (Coming Soon!)                       │
echo  │  [8] 🚪 Exit Game                                          │
echo  └────────────────────────────────────────────────────────────┘
echo.
call :get_random_tip
echo 💡 Tip: !random_tip!
echo.
set "mode_choice="
set /p mode_choice="    ⭐ Enter your choice (1-8): "

if "%mode_choice%"=="1" goto single_player_menu
if "%mode_choice%"=="2" goto multiplayer_setup
if "%mode_choice%"=="3" goto tournament_coming_soon
if "%mode_choice%"=="4" goto game_settings
if "%mode_choice%"=="5" goto how_to_play
if "%mode_choice%"=="6" goto view_statistics
if "%mode_choice%"=="7" goto themes_menu
if "%mode_choice%"=="8" goto exit_game
echo     ❌ Invalid choice! Please select 1-8.
timeout /t 2 /nobreak >nul
goto main_menu

:get_current_time
for /f "tokens=1-3 delims=:." %%a in ('echo %time%') do (
    set hour=%%a
    set minute=%%b
)
set current_time=!hour:~-2!:!minute!
goto :eof

:get_random_tip
set /a tip_num=%random% %% 8 + 1
if %tip_num%==1 set "random_tip=Vowels (A,E,I,O,U) are great starting letters!"
if %tip_num%==2 set "random_tip=Common consonants like R,S,T,N appear frequently."
if %tip_num%==3 set "random_tip=Look for common word patterns and endings."
if %tip_num%==4 set "random_tip=Short words are often harder than long ones!"
if %tip_num%==5 set "random_tip=Pay attention to the category for context clues."
if %tip_num%==6 set "random_tip=Double letters are common in English words."
if %tip_num%==7 set "random_tip=Think about word structure and syllables."
if %tip_num%==8 set "random_tip=Practice makes perfect - keep playing!"
goto :eof

:tournament_coming_soon
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║                  🏆 TOURNAMENT MODE                          ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo      🚧 Coming Soon in Version 3.0!
echo.
echo      🎯 Planned Features:
echo      • 🏟️ Bracket-style tournaments
echo      • 🏆 Leaderboards and rankings  
echo      • 🏅 Achievement system
echo      • ⏱️ Timed challenges
echo      • 🌟 Special difficulty modes
echo.
echo           🔔 Stay tuned for updates!
echo.
echo      Press any key to return to main menu...
pause >nul
goto main_menu

:game_settings
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║                   ⚙️ GAME SETTINGS                           ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo      🎨 Current Theme: Classic
echo      🔊 Sound Effects: Disabled (Feature coming soon)
echo      ⏱️ Timer Mode: Disabled
echo      💀 Difficulty: Normal (6 wrong guesses allowed)
echo.
echo      [1] 🎨 Change Color Scheme
echo      [2] 🔊 Toggle Sound Effects (Coming Soon)
echo      [3] ⏱️ Enable Timer Mode (Coming Soon) 
echo      [4] 💀 Adjust Difficulty
echo      [5] 🔄 Reset All Settings
echo      [6] ⬅️ Back to Main Menu
echo.
set "settings_choice="
set /p settings_choice="    Choose setting to modify (1-6): "

if "%settings_choice%"=="1" goto color_scheme
if "%settings_choice%"=="4" goto difficulty_settings
if "%settings_choice%"=="6" goto main_menu
echo     ⚠️ Feature coming in future update!
timeout /t 2 /nobreak >nul
goto game_settings

:color_scheme
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║                    🎨 COLOR THEMES                           ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo      [1] 🎞️ Black / White (Default)
echo      [2] 🌿 Matrix Green
echo      [3] 🔥 Inferno Red  
echo      [4] 🌊 Ocean Blue
echo      [5] 🌌 Purple Night
echo      [6] ☀️  Golden Yellow
echo      [7] ❄️  Ice White
echo      [8] ⬅️  Back
echo.
set "color_choice="
set /p color_choice="    Select theme (1-7): "

if "%color_choice%"=="1" color 0F
if "%color_choice%"=="2" color 0A
if "%color_choice%"=="3" color 0C
if "%color_choice%"=="4" color 01
if "%color_choice%"=="5" color 05
if "%color_choice%"=="6" color 0E
if "%color_choice%"=="7" color 0B
if "%color_choice%"=="8" goto game_settings

if "%color_choice%" geq "1" if "%color_choice%" leq "6" (
    echo     ✅ Theme applied! Colors changed.
    timeout /t 2 /nobreak >nul
)
goto game_settings

:difficulty_settings
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║                 💀 DIFFICULTY SETTINGS                       ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo      [1] 😊 Easy Mode (8 wrong guesses allowed)
echo      [2] 😐 Normal Mode (6 wrong guesses allowed) [Current]
echo      [3] 😈 Hard Mode (4 wrong guesses allowed)  
echo      [4] 💀 Nightmare Mode (3 wrong guesses allowed)
echo      [5] ⬅️  Back
echo.
set "diff_choice="
set /p diff_choice="    Select difficulty (1-5): "

if "%diff_choice%"=="1" set max_wrong=8
if "%diff_choice%"=="2" set max_wrong=6
if "%diff_choice%"=="3" set max_wrong=4
if "%diff_choice%"=="4" set max_wrong=3
if "%diff_choice%"=="5" goto game_settings

if defined max_wrong (
    echo     ✅ Difficulty updated! Max wrong guesses: %max_wrong%
    timeout /t 2 /nobreak >nul
) else (
    set max_wrong=6
)
goto game_settings

:themes_menu
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║                      🎨 CUSTOMIZATIONS                       ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo      🚧 Coming Soon in Version 3.0!
echo.
echo      🎯 Planned Features:
echo      • 🖼️ Classic ASCII Hangman
echo      • 🖥️ Modern Unicode Hangman
echo      • 😵 Emoji Hangman
echo      • 🎵 Retro 8-bit Sounds
echo      • 🔊 Modern UI Sounds
echo      • 🌳 Nature Sounds
echo.
echo           🔔 Stay tuned for updates!
echo.
echo      Press any key to return to main menu...
pause >nul
goto main_menu

:view_statistics
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║                   📈 GAME STATISTICS                         ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
if %total_games% equ 0 (
    echo      📊 No games played yet in this session.
    echo      🎮 Start playing to see your stats here!
) else (
    set /a win_percentage=%wins%*100/%total_games%
    echo      📊 Session Statistics:
    echo      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    echo      🎯 Games Played: %total_games%
    echo      🏆 Wins: %wins%
    echo      💀 Losses: %losses%  
    echo      📈 Win Rate: !win_percentage!%%
    echo.
    if !win_percentage! gtr 75 (
        echo      🌟 Excellent performance! You're a Hangman master!
    ) else if !win_percentage! gtr 50 (
        echo      👍 Good job! Keep practicing to improve further.
    ) else (
        echo      💪 Keep playing - practice makes perfect!
    )
)
echo.
echo      Press any key to return to main menu...
pause >nul
goto main_menu

:how_to_play
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║                   📚 HOW TO PLAY                             ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  🎯 OBJECTIVE:
echo     Guess the word before the hangman is complete!
echo.
echo  🎮 HOW TO PLAY:
echo     • Guess letters or the whole word
echo     • Correct guesses reveal letters
echo     • Wrong guesses add hangman parts
echo     • 6 wrong guesses = lose (adjustable)
echo.
echo  🏆 TIPS:
echo     • Start with vowels: A, E, I, O, U
echo     • Common consonants: R, S, T, L, N
echo     • Watch word patterns/endings
echo     • Use hints when available
echo.
echo  👥 MULTIPLAYER:
echo     • Player 1 sets word/hints
echo     • Others guess in turns
echo     • Wrong = next turn
echo     • Correct = continue
echo.
echo  Press any key to return to main menu...
pause >nul
goto main_menu

:single_player_menu
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║                🦄 SINGLE PLAYER CHALLENGE                    ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  🎲 Choose your category adventure:
echo  ┌────────────────────────────────────────────────────────────┐
echo  │  [1] 🐾 Animals Kingdom (Easy)                             │
echo  │  [2] 🌍 World Countries (Medium)                           │ 
echo  │  [3] 🎬 Movie Magic (Hard)                                 │
echo  │  [4] 📚 School Subjects (Easy)                             │
echo  │  [5] 🍕 Delicious Food (Medium)                            │
echo  │  [6] 🏆 Sports/Games (Medium)                              │
echo  │  [7] 🚀 Technology (Hard)                                  │
echo  │  [8] 🎭 Random Mystery (All)                               │
echo  │  [9] ⬅️  Back to Main Menu                                 │
echo  └────────────────────────────────────────────────────────────┘
echo.
set "choice="
set /p choice="    🌟 Select your challenge (1-9): "

if "%choice%"=="1" goto animals_category
if "%choice%"=="2" goto countries_category  
if "%choice%"=="3" goto movies_category
if "%choice%"=="4" goto school_category
if "%choice%"=="5" goto food_category
if "%choice%"=="6" goto sports_category
if "%choice%"=="7" goto tech_category
if "%choice%"=="8" goto random_category
if "%choice%"=="9" goto main_menu
echo     ❌ Invalid choice! Please select 1-9.
timeout /t 2 /nobreak >nul
goto single_player_menu

:multiplayer_setup
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║                👥 MULTIPLAYER BATTLE ARENA                   ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  🎪 Welcome to the ultimate word guessing battle!
echo.
echo  👥 How many brave warriors will join? (2-6 players)
set /p players="    ⚔️  Number of players: "

if %players% lss 2 (
    echo     ❌ Need at least 2 players for multiplayer!
    timeout /t 2 /nobreak >nul
    goto multiplayer_setup
)
if %players% gtr 6 (
    echo     ❌ Maximum 6 players allowed!
    timeout /t 2 /nobreak >nul  
    goto multiplayer_setup
)

echo.
echo  📝 Enter the names of your word warriors:
for /l %%i in (1,1,%players%) do (
    set /p player%%i="    🏷️  Player %%i name: "
    if "!player%%i!"=="" set player%%i=Player%%i
)

echo.
echo  🎉 Player roster complete!
for /l %%i in (1,1,%players%) do (
    echo      %%i. !player%%i!
)
echo.
echo      Press any key to continue to word creation...
pause >nul

:multiplayer_word_input
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║                  📝 WORD CREATION CHAMBER                    ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo      🧙 Word Master: %player1%
echo      👀 Other players - Please look away or close your eyes!
echo.
echo      📜 Rules for creating the perfect word:
echo      • Only letters allowed (A-Z)
echo      • Length: 3-20 characters
echo      • No spaces, numbers, or special characters
echo      • Make it challenging but fair!
echo.
set "word="
set /p word="    ✨ Enter your secret word: "

if "%word%"=="" (
    echo     ❌ Word cannot be empty!
    timeout /t 2 /nobreak >nul
    goto multiplayer_word_input
)

call :validate_word "%word%"
if "%valid_word%"=="false" (
    echo.
    echo      ⚠️ Invalid word detected! 
    echo      📋 Requirements: Only letters, 3-20 characters long
    echo      💡 Example: BUTTERFLY, MATHEMATICS, JAVASCRIPT
    pause
    goto multiplayer_word_input
)

call :to_uppercase "%word%"
set word=!uppercase_result!

cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║                   ✅ WORD ACCEPTED                           ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo      🎯 %player1%, your word has been locked in the vault!
echo      📏 Word length: !word_length! letters
echo      🎪 Difficulty rating: !difficulty_rating!
echo.
echo      🔮 Optional: Add a helpful hint for the other players
echo      💭 Hint examples: "It's an animal", "Found in kitchen", "Movie genre"
echo.
set "hint="
set /p hint="    💡 Enter hint (or press Enter to skip): "
echo.
if not "%hint%"=="" (
    echo      🎁 Bonus hint added! This will help the players.
) else (
    echo      🔒 No hint provided - maximum challenge mode!
)
echo.
echo      🔄 Ready to pass control to the guessing players...
echo      Press any key when everyone is ready...
pause >nul

call :calculate_difficulty
set category=MULTIPLAYER (%player1%'s word)
set current_player=2
goto start_game

:calculate_difficulty
set difficulty_rating=⭐
if !word_length! gtr 8 set difficulty_rating=⭐⭐
if !word_length! gtr 12 set difficulty_rating=⭐⭐⭐
if !word_length! gtr 16 set difficulty_rating=⭐⭐⭐⭐
goto :eof

:validate_word
set temp_word=%~1
set valid_word=true
set word_length=0

if "%temp_word%"=="" (
    set valid_word=false
    goto :eof
)

:validate_loop
if not defined temp_word goto validate_done
set current_char=%temp_word:~0,1%
set temp_word=%temp_word:~1%
set /a word_length+=1

echo %uppercase%%lowercase% | find "%current_char%" >nul
if errorlevel 1 (
    set valid_word=false
    goto :eof
)
goto validate_loop

:validate_done
if !word_length! lss 3 set valid_word=false
if !word_length! gtr 20 set valid_word=false
goto :eof

:to_uppercase
set temp_word=%~1
set uppercase_result=
if not defined temp_word goto :eof

:upper_loop
set current_char=%temp_word:~0,1%
set temp_word=%temp_word:~1%

for /l %%i in (0,1,25) do (
    if "!current_char!"=="!lowercase:~%%i,1!" (
        set current_char=!uppercase:~%%i,1!
        goto char_found
    )
)

:char_found
set uppercase_result=!uppercase_result!!current_char!
if defined temp_word goto upper_loop
goto :eof

:sports_category
set category=SPORTS & GAMES
set /a word_num=%random% %% 25 + 1
if %word_num%==1 set word=FOOTBALL
if %word_num%==2 set word=BASKETBALL
if %word_num%==3 set word=BASEBALL
if %word_num%==4 set word=TENNIS  
if %word_num%==5 set word=VOLLEYBALL
if %word_num%==6 set word=HOCKEY
if %word_num%==7 set word=CRICKET
if %word_num%==8 set word=RUGBY
if %word_num%==9 set word=GOLF
if %word_num%==10 set word=SWIMMING
if %word_num%==11 set word=WRESTLING
if %word_num%==12 set word=BOXING
if %word_num%==13 set word=MARATHON
if %word_num%==14 set word=OLYMPICS
if %word_num%==15 set word=CHAMPIONSHIP
if %word_num%==16 set word=TOURNAMENT
if %word_num%==17 set word=SKATEBOARD
if %word_num%==18 set word=SURFING
if %word_num%==19 set word=CLIMBING
if %word_num%==20 set word=CYCLING
if %word_num%==21 set word=BADMINTON
if %word_num%==22 set word=ARCHERY
if %word_num%==23 set word=GYMNASTICS
if %word_num%==24 set word=KARATE
if %word_num%==25 set word=JUDO
goto start_game

:tech_category
set category=TECHNOLOGY  
set /a word_num=%random% %% 25 + 1
if %word_num%==1 set word=COMPUTER
if %word_num%==2 set word=INTERNET
if %word_num%==3 set word=SOFTWARE
if %word_num%==4 set word=HARDWARE
if %word_num%==5 set word=PROGRAMMING
if %word_num%==6 set word=ALGORITHM
if %word_num%==7 set word=DATABASE
if %word_num%==8 set word=ARTIFICIAL
if %word_num%==9 set word=INTELLIGENCE  
if %word_num%==10 set word=MACHINE
if %word_num%==11 set word=LEARNING
if %word_num%==12 set word=ROBOTICS
if %word_num%==13 set word=BLOCKCHAIN
if %word_num%==14 set word=CYBERSECURITY
if %word_num%==15 set word=SMARTPHONE
if %word_num%==16 set word=APPLICATION
if %word_num%==17 set word=JAVASCRIPT
if %word_num%==18 set word=PYTHON
if %word_num%==19 set word=NETWORKING
if %word_num%==20 set word=ENCRYPTION
if %word_num%==21 set word=VIRTUAL
if %word_num%==22 set word=AUGMENTED
if %word_num%==23 set word=QUANTUM
if %word_num%==24 set word=NANOTECHNOLOGY
if %word_num%==25 set word=BIOTECHNOLOGY
goto start_game

:animals_category
set category=ANIMALS KINGDOM
set /a word_num=%random% %% 30 + 1
if %word_num%==1 set word=ELEPHANT
if %word_num%==2 set word=GIRAFFE  
if %word_num%==3 set word=PENGUIN
if %word_num%==4 set word=DOLPHIN
if %word_num%==5 set word=BUTTERFLY
if %word_num%==6 set word=KANGAROO
if %word_num%==7 set word=CROCODILE
if %word_num%==8 set word=HAMSTER
if %word_num%==9 set word=RABBIT
if %word_num%==10 set word=TIGER
if %word_num%==11 set word=MONKEY
if %word_num%==12 set word=CHICKEN
if %word_num%==13 set word=TURTLE
if %word_num%==14 set word=HORSE  
if %word_num%==15 set word=SNAKE
if %word_num%==16 set word=KITTEN
if %word_num%==17 set word=PARROT
if %word_num%==18 set word=LEOPARD
if %word_num%==19 set word=OSTRICH
if %word_num%==20 set word=CRICKET
if %word_num%==21 set word=CHEETAH
if %word_num%==22 set word=RHINOCEROS
if %word_num%==23 set word=HIPPOPOTAMUS
if %word_num%==24 set word=ORANGUTAN
if %word_num%==25 set word=CHIMPANZEE
if %word_num%==26 set word=FLAMINGO
if %word_num%==27 set word=OCTOPUS
if %word_num%==28 set word=JELLYFISH
if %word_num%==29 set word=DRAGONFLY
if %word_num%==30 set word=PLATYPUS
goto start_game

:countries_category
set category=WORLD COUNTRIES
set /a word_num=%random% %% 30 + 1
if %word_num%==1 set word=CANADA
if %word_num%==2 set word=BRAZIL
if %word_num%==3 set word=FRANCE
if %word_num%==4 set word=JAPAN
if %word_num%==5 set word=GERMANY
if %word_num%==6 set word=AUSTRALIA
if %word_num%==7 set word=MEXICO
if %word_num%==8 set word=ITALY
if %word_num%==9 set word=SPAIN
if %word_num%==10 set word=EGYPT
if %word_num%==11 set word=RUSSIA
if %word_num%==12 set word=CHINA
if %word_num%==13 set word=INDIA
if %word_num%==14 set word=GREECE
if %word_num%==15 set word=SWEDEN
if %word_num%==16 set word=TURKEY
if %word_num%==17 set word=THAILAND
if %word_num%==18 set word=NIGERIA
if %word_num%==19 set word=ARGENTINA
if %word_num%==20 set word=VIETNAM
if %word_num%==21 set word=PHILIPPINES
if %word_num%==22 set word=BANGLADESH
if %word_num%==23 set word=SWITZERLAND
if %word_num%==24 set word=NETHERLANDS
if %word_num%==25 set word=PORTUGAL
if %word_num%==26 set word=SINGAPORE
if %word_num%==27 set word=MADAGASCAR
if %word_num%==28 set word=ZIMBABWE
if %word_num%==29 set word=LUXEMBOURG
if %word_num%==30 set word=MONTENEGRO
goto start_game

:movies_category  
set category=MOVIE MAGIC
set /a word_num=%random% %% 30 + 1
if %word_num%==1 set word=FROZEN
if %word_num%==2 set word=SHREK
if %word_num%==3 set word=AVATAR
if %word_num%==4 set word=TITANIC
if %word_num%==5 set word=BATMAN
if %word_num%==6 set word=SUPERMAN
if %word_num%==7 set word=SPIDERMAN
if %word_num%==8 set word=MOANA
if %word_num%==9 set word=COCO
if %word_num%==10 set word=ALADDIN
if %word_num%==11 set word=MARVEL
if %word_num%==12 set word=DISNEY
if %word_num%==13 set word=JUMANJI
if %word_num%==14 set word=TOYSTORY
if %word_num%==15 set word=GODZILLA
if %word_num%==16 set word=JOKER
if %word_num%==17 set word=INCEPTION
if %word_num%==18 set word=GLADIATOR
if %word_num%==19 set word=JURASSIC
if %word_num%==20 set word=MATRIX
if %word_num%==21 set word=TERMINATOR
if %word_num%==22 set word=TRANSFORMER
if %word_num%==23 set word=STARWARS
if %word_num%==24 set word=INDIANA
if %word_num%==25 set word=PIRATES
if %word_num%==26 set word=AVENGERS
if %word_num%==27 set word=GUARDIANS
if %word_num%==28 set word=WONDERWOMAN
if %word_num%==29 set word=BLACKPANTHER
if %word_num%==30 set word=INCREDIBLES
goto start_game

:school_category
set category=SCHOOL SUBJECTS
set /a word_num=%random% %% 20 + 1
if %word_num%==1 set word=MATHEMATICS
if %word_num%==2 set word=SCIENCE
if %word_num%==3 set word=ENGLISH
if %word_num%==4 set word=HISTORY
if %word_num%==5 set word=GEOGRAPHY
if %word_num%==6 set word=BIOLOGY
if %word_num%==7 set word=CHEMISTRY
if %word_num%==8 set word=PHYSICS
if %word_num%==9 set word=LITERATURE
if %word_num%==10 set word=ALGEBRA
if %word_num%==11 set word=COMPUTER
if %word_num%==12 set word=MUSIC
if %word_num%==13 set word=ART
if %word_num%==14 set word=DRAMA
if %word_num%==15 set word=SPANISH
if %word_num%==16 set word=PSYCHOLOGY
if %word_num%==17 set word=PHILOSOPHY
if %word_num%==18 set word=ECONOMICS
if %word_num%==19 set word=SOCIOLOGY
if %word_num%==20 set word=ANTHROPOLOGY
goto start_game

:food_category
set category=DELICIOUS FOOD
set /a word_num=%random% %% 25 + 1
if %word_num%==1 set word=PIZZA
if %word_num%==2 set word=BURGER
if %word_num%==3 set word=CHOCOLATE
if %word_num%==4 set word=SANDWICH
if %word_num%==5 set word=SPAGHETTI
if %word_num%==6 set word=PANCAKE
if %word_num%==7 set word=COOKIE
if %word_num%==8 set word=BANANA
if %word_num%==9 set word=STRAWBERRY
if %word_num%==10 set word=WATERMELON
if %word_num%==11 set word=CHICKEN
if %word_num%==12 set word=BROCCOLI
if %word_num%==13 set word=SUSHI
if %word_num%==14 set word=TACO
if %word_num%==15 set word=POPCORN
if %word_num%==16 set word=WAFFLE
if %word_num%==17 set word=MUFFIN
if %word_num%==18 set word=CHEDDAR
if %word_num%==19 set word=CUSTARD
if %word_num%==20 set word=LASAGNA
if %word_num%==21 set word=ENCHILADA
if %word_num%==22 set word=QUESADILLA
if %word_num%==23 set word=CAPPUCCINO
if %word_num%==24 set word=CHEESECAKE
if %word_num%==25 set word=CROISSANT
goto start_game

:random_category
set category=RANDOM MYSTERY
set /a cat_choice=%random% %% 6 + 1
if %cat_choice%==1 goto animals_category
if %cat_choice%==2 goto countries_category
if %cat_choice%==3 goto movies_category
if %cat_choice%==4 goto school_category
if %cat_choice%==5 goto food_category
if %cat_choice%==6 goto sports_category

:start_game
if not defined max_wrong set max_wrong=6
set wrong_guesses=0
set guessed_letters=
set display_word=
set hint_displayed=0
set start_time=%time%
call :get_word_length "%word%"

for /l %%i in (1,1,%word_length%) do (
    set display_word=!display_word!_ 
)

:game_loop
cls
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║                    🎯 HANGMAN BATTLE                         ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
if defined players (
    echo      🎮 Current Player: !player%current_player%!
    echo      👤 Word Creator: %player1%
    set remaining_players=0
    for /l %%i in (2,1,%players%) do set /a remaining_players+=1
    echo      👥 Players remaining: !remaining_players!
) else (
    echo      🦄 Single Player Challenge
)
echo      🏷️  Category: %category%
echo      ⏱️  Game Time: !elapsed_time!

if defined hint if not "%hint%"=="" (
    if %wrong_guesses% geq 3 if %hint_displayed% equ 0 (
        echo      💡 BONUS HINT: %hint%
        set hint_displayed=1
    )
)
echo.

call :draw_enhanced_hangman %wrong_guesses%
echo.
echo      🔤 Word: !display_word!
echo      📊 Progress: [!progress_bar!] !progress_percent!%%
echo.
echo      🔍 Guessed: %guessed_letters%
echo      ❌ Wrong: %wrong_guesses%/%max_wrong%
echo.

call :calculate_progress

set temp_check=!display_word!
set temp_check=!temp_check: =!
if "!temp_check!"=="%word%" (
    call :victory_celebration
    goto victory
)

if %wrong_guesses% geq %max_wrong% (
    call :game_over_scene
    goto play_again
)

if defined players (
    echo      !player%current_player%!, your move!
    set /p guess="    🎯 Enter letter or full word: "
) else (
    call :get_smart_suggestion
    echo      💭 Suggestion: Try letter "!smart_suggestion!" or common vowels
    set /p guess="    🎯 Enter letter or full word: "
)

if "%guess%"=="" goto game_loop

call :to_uppercase "%guess%"
set guess=!uppercase_result!

if "%guess%"=="%word%" (
    set display_word=%word%
    echo.
    echo      🎉 INCREDIBLE! You guessed the entire word!
    echo      🏆 WORD MASTER achievement unlocked!
    call :play_victory_sound
    pause
    goto victory
)

call :get_word_length "%guess%"
set guess_length=!word_length!
if !guess_length! gtr 1 (
    echo      ❌ Wrong word! "%guess%" is not the secret word.
    echo      💡 Try individual letters or the exact word.
    set /a wrong_guesses+=1
    call :play_wrong_sound
    pause
    
    if defined players (
        call :next_player
    )
    goto game_loop
)

echo %guessed_letters% | find "%guess%" >nul
if not errorlevel 1 (
    echo      ⚠️ Already tried "%guess%"! Choose a different letter.
    call :show_available_letters
    pause
    goto game_loop
)

set guessed_letters=%guessed_letters%%guess% 
echo %word% | find "%guess%" >nul
if errorlevel 1 (
    set /a wrong_guesses+=1
    echo      ❌ Sorry! "%guess%" is not in the word.
    call :show_encouragement
    if defined players (
        echo      🔄 Turn passes to next player!
        call :next_player
    )
    call :play_wrong_sound
    pause
) else (
    call :update_display "%word%" "%guess%"
    echo      ✅ Excellent! "%guess%" is in the word!
    call :count_letter_occurrences "%word%" "%guess%"
    if !letter_count! gtr 1 (
        echo      🌟 BONUS: Found !letter_count! instances of "%guess%"!
    )
    if defined players (
        echo      🎯 Great guess! Same player continues!
    )
    call :play_correct_sound
    pause
)

goto game_loop

:calculate_progress
set solved_letters=0
set total_letters=0
set temp_display=!display_word!

:progress_loop
if not defined temp_display goto progress_done
set current_char=!temp_display:~0,1!
set temp_display=!temp_display:~1%!
if not "!current_char!"==" " (
    set /a total_letters+=1
    if not "!current_char!"=="_" set /a solved_letters+=1
)
goto progress_loop

:progress_done
if %total_letters% gtr 0 (
    set /a progress_percent=%solved_letters%*100/%total_letters%
) else (
    set progress_percent=0
)

set progress_bar=
set /a bar_length=%progress_percent%/10
for /l %%i in (1,1,%bar_length%) do set progress_bar=!progress_bar!█
for /l %%i in (%bar_length%,1,9) do set progress_bar=!progress_bar!░

set /a letters_remaining=26
for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    echo %guessed_letters% | find "%%i" >nul
    if not errorlevel 1 set /a letters_remaining-=1
)
goto :eof

:show_available_letters
echo      📝 Available letters: 
set available=
for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    echo %guessed_letters% | find "%%i" >nul
    if errorlevel 1 set available=!available!%%i 
)
echo      !available!
goto :eof

:get_smart_suggestion
set common_letters=ETAOINSHRDLU
set smart_suggestion=E

:suggestion_loop
if not defined common_letters goto suggestion_done
set test_letter=!common_letters:~0,1!
set common_letters=!common_letters:~1!
echo %guessed_letters% | find "%test_letter%" >nul
if errorlevel 1 (
    set smart_suggestion=%test_letter%
    goto suggestion_done
)
goto suggestion_loop

:suggestion_done
goto :eof

:count_letter_occurrences
set test_word=%~1
set search_letter=%~2
set letter_count=0

:count_loop
if not defined test_word goto :eof
set current_char=!test_word:~0,1!
set test_word=!test_word:~1!
if /i "!current_char!"=="%search_letter%" set /a letter_count+=1
goto count_loop

:show_encouragement
set /a encouragement_num=%random% %% 5 + 1
if %encouragement_num%==1 echo      💪 Keep trying! You've got this!
if %encouragement_num%==2 echo      🎯 Good attempt! Try another letter.
if %encouragement_num%==3 echo      🤔 Think about common letter patterns.
if %encouragement_num%==4 echo      ⭐ Every guess gets you closer!
if %encouragement_num%==5 echo      🔥 Don't give up! Victory is near!
goto :eof

:victory_celebration
cls
echo.
echo      🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉
echo      🏆              VICTORY ACHIEVED!              🏆
echo      🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉
echo.
if defined players (
    echo      🌟 CHAMPION: !player%current_player%!
    echo      👤 Word Creator: %player1%
    echo      🔤 The secret word was: %word%
    echo      ⚡ Solved with %wrong_guesses%/%max_wrong% wrong guesses!
) else (
    echo      🌟 CONGRATULATIONS WORD MASTER!
    echo      🔤 You successfully guessed: %word%
    echo      📊 Category: %category%
    echo      ⚡ Wrong guesses: %wrong_guesses%/%max_wrong%
    set /a wins+=1
)
set /a total_games+=1

call :calculate_performance_rating
echo      🏅 Performance Rating: !performance_rating!

:: Achievement system
call :check_achievements

echo.
goto :eof

:calculate_performance_rating
if %wrong_guesses% equ 0 set performance_rating=FLAWLESS ⭐⭐⭐⭐⭐
if %wrong_guesses% equ 1 set performance_rating=EXCELLENT ⭐⭐⭐⭐
if %wrong_guesses% leq 2 set performance_rating=GREAT ⭐⭐⭐
if %wrong_guesses% leq 4 set performance_rating=GOOD ⭐⭐
if %wrong_guesses% gtr 4 set performance_rating=DECENT ⭐
goto :eof

:check_achievements
if %wrong_guesses% equ 0 (
    echo      🥇 ACHIEVEMENT UNLOCKED: Perfect Game!
)
if %wins% equ 5 (
    echo      🏆 ACHIEVEMENT UNLOCKED: 5 Game Winner!
)
if %wins% equ 10 (
    echo      👑 ACHIEVEMENT UNLOCKED: Hangman Master!
)
goto :eof

:game_over_scene
cls
echo.
echo      💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
echo      💀                 GAME OVER!                  💀  
echo      💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
echo.
if defined players (
    echo      ⚰️ All players have been eliminated!
    echo      👤 %player1%'s word was: %word%
    echo      📚 Better strategy next time, warriors!
) else (
    echo      ⚰️ The hangman claims another victim!
    echo      🔤 The secret word was: %word%  
    echo      📊 Category: %category%
    set /a losses+=1
)
set /a total_games+=1

echo      💡 Word analysis:
call :analyze_word "%word%"
echo.
goto :eof

:analyze_word
set analyze_word=%~1
set vowel_count=0
set consonant_count=0

:analyze_loop
if not defined analyze_word goto analyze_done
set current_char=!analyze_word:~0,1!
set analyze_word=!analyze_word:~1!

echo AEIOU | find "!current_char!" >nul
if not errorlevel 1 (
    set /a vowel_count+=1
) else (
    set /a consonant_count+=1
)
goto analyze_loop

:analyze_done
echo      📈 Word had %vowel_count% vowels and %consonant_count% consonants
echo      💭 Most common letters: E, T, A, O, I, N, S, H, R
goto :eof

:play_victory_sound
echo      ♪♫♪ *Victory fanfare plays* ♪♫♪
goto :eof

:play_wrong_sound  
echo      ♪ *Sad trombone* ♪
goto :eof

:play_correct_sound
echo      ♪ *Ding!* ♪
goto :eof

:victory
echo.
echo      🎮 What's your next adventure?
echo      ┌────────────────────────────────────────────────────────┐
if defined players (
    echo      │  [1] 🔄 Rematch with same players                      │
    echo      │  [2] 👥 New multiplayer battle                         │
    echo      │  [3] 🏠 Return to main menu                            │
) else (
    echo      │  [1] 🔄 Play same category again                       │  
    echo      │  [2] 🎲 Choose different category                      │
    echo      │  [3] 👥 Try multiplayer mode                           │
    echo      │  [4] 🏠 Return to main menu                            │
)
echo      └────────────────────────────────────────────────────────┘
set "next_choice="
set /p next_choice="    🌟 Your choice: "

if "%next_choice%"=="1" (
    if defined players (
        call :reset_multiplayer_game
        goto multiplayer_word_input
    ) else (
        call :replay_same_category
    )
)
if "%next_choice%"=="2" (
    if defined players (
        call :reset_all_players
        goto multiplayer_setup
    ) else (
        goto single_player_menu
    )
)
if "%next_choice%"=="3" (
    if defined players (
        goto main_menu
    ) else (
        call :reset_all_players
        goto multiplayer_setup  
    )
)
if "%next_choice%"=="4" goto main_menu
goto victory

:reset_multiplayer_game
set hint=
set current_player=2
set hint_displayed=0
goto :eof

:reset_all_players
for /l %%i in (1,1,6) do set player%%i=
set players=
set hint=
set current_player=
goto :eof

:replay_same_category
if "%category%"=="ANIMALS KINGDOM" goto animals_category
if "%category%"=="WORLD COUNTRIES" goto countries_category
if "%category%"=="MOVIE MAGIC" goto movies_category  
if "%category%"=="SCHOOL SUBJECTS" goto school_category
if "%category%"=="DELICIOUS FOOD" goto food_category
if "%category%"=="SPORTS AND GAMES" goto sports_category
if "%category%"=="TECHNOLOGY" goto tech_category
if "%category%"=="RANDOM MYSTERY" goto random_category
goto single_player_menu

:next_player
set /a current_player=current_player + 1
if !current_player! gtr %players% set current_player=2
goto :eof

:get_word_length
set word_length=0
set temp_word=%~1
:length_loop
if not defined temp_word goto :eof
set temp_word=%temp_word:~1%
set /a word_length+=1
goto length_loop

:update_display
set temp_word=%~1
set guess_letter=%~2
set new_display=
set idx=0

:update_loop
if not defined temp_word goto update_done
set current_letter=%temp_word:~0,1%
set temp_word=%temp_word:~1%
set "current_display_char=!display_word:~%idx%,1!"

if /i "%current_letter%"=="%guess_letter%" (
    set "new_display=!new_display!%current_letter% "
) else (
    if "!current_display_char!"==" " (
        set "new_display=!new_display! "
    ) else if "!current_display_char!"=="_" (
        set "new_display=!new_display!_ "
    ) else (
        set "new_display=!new_display!!current_display_char! "
    )
)
set /a idx+=2
goto update_loop

:update_done
set new_display=!new_display:~0,-1!
set display_word=!new_display!
goto :eof

:draw_enhanced_hangman
echo      ⚰️  HANGMAN STATUS: %1/%max_wrong%
echo.
if "%1"=="0" (
    echo        ┌─────┐
    echo        │     │
    echo        │     
    echo        │     
    echo        │     
    echo        │     
    echo      ═══════════
    echo        😊 Safe!
)
if "%1"=="1" (  
    echo        ┌─────┐
    echo        │     │
    echo        │     O
    echo        │     
    echo        │     
    echo        │     
    echo      ═══════════
    echo        😟 Oh no!
)
if "%1"=="2" (
    echo        ┌─────┐
    echo        │     │
    echo        │     O
    echo        │     │
    echo        │     
    echo        │     
    echo      ═══════════
    echo        😰 Getting worse!
)
if "%1"=="3" (
    echo        ┌─────┐
    echo        │     │
    echo        │     O
    echo        │    ╱│
    echo        │     
    echo        │     
    echo      ═══════════
    echo        😨 Danger zone!
)
if "%1"=="4" (
    echo        ┌─────┐
    echo        │     │
    echo        │     O
    echo        │    ╱│╲
    echo        │     
    echo        │     
    echo      ═══════════
    echo        😱 Critical!
)
if "%1"=="5" (
    echo        ┌─────┐
    echo        │     │
    echo        │     O
    echo        │    ╱│╲
    echo        │    ╱
    echo        │     
    echo      ═══════════
    echo        💀 Final chance!
)
if "%1"=="6" (
    echo        ┌─────┐
    echo        │     │
    echo        │     O
    echo        │    ╱│╲
    echo        │    ╱ ╲
    echo        │     
    echo      ═══════════
    echo        ⚰️ HANGED!
)
goto :eof

:play_again
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║                    🎮 GAME OVER MENU                         ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo What would you like to do?
echo      ┌────────────────────────────────────────────────────────┐
echo      │  [1] 🏠 Back to main menu                              │
echo      │  [2] 🔄 Try again (same mode)                          │  
echo      │  [3] 📊 View session statistics                        │
echo      │  [4] 🚪 Exit game                                      │
echo      └────────────────────────────────────────────────────────┘

:ask_choice
set /p play_choice="🌟 Your choice (1-4): "

if "%play_choice%"=="2" (
    if defined players (
        call :reset_multiplayer_game
        goto multiplayer_word_input
    ) else (
        call :replay_same_category
    )
) else if "%play_choice%"=="1" (
    goto main_menu
) else if "%play_choice%"=="3" (
    goto view_statistics
) else if "%play_choice%"=="4" (
    goto exit_game
) else (
    echo     ❌ Invalid choice! Please select 1-4.
    timeout /t 2 /nobreak >nul
    goto ask_choice
)

:exit_game
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║                   🚪 EXIT GAME                               ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo      📊 Your current session stats:
echo      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo      🎮 Games Played: %total_games%
echo      🏆 Wins: %wins%
echo      💀 Losses: %losses%
echo.
if defined achievements (
    echo      🏅 Your Achievements:
    echo      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    for %%a in (%achievements:;= %) do echo      🌟 %%a
)
echo.
echo                 🚀 Created by Shamlan
echo      📧 Feedback welcome for future improvements!
echo.
echo      Press any key to exit...
pause >nul
exit /b 0
