@echo off
title Soundboard Launcher
color 0A

:: Folder where your sounds live
set "SFX=Sounds"

:: Check folder exists
if not exist "%SFX%" (
    echo The folder "%SFX%" does not exist.
    echo Create it and put your .wav or .mp3 files inside.
    pause
    exit /b
)

:menu
cls
echo ================================
echo        SOUND BOARD MENU
echo ================================
echo.
echo 1) Airhorn
echo 2) Bonk
echo 3) Vine Boom
echo 4) Bruh
echo 5) Random Sound
echo 0) Exit
echo.
set /p choice=Select a sound:

if "%choice%"=="1" call :play "airhorn.mp3"
if "%choice%"=="2" call :play "bonk.wav"
if "%choice%"=="3" call :play "vineboom.mp3"
if "%choice%"=="4" call :play "bruh.mp3"
if "%choice%"=="5" call :randomSound
if "%choice%"=="0" exit /b

goto menu

:: --- FUNCTIONS ---

:play
cls
echo Playing %~1
start "" "%SFX%\%~1"
timeout /t 1 >nul
exit /b

:randomSound
for /f "delims=" %%A in ('dir /b "%SFX%\*.wav" "%SFX%\*.mp3" 2^>nul') do (
    set "list=!list! %%A"
)
setlocal enabledelayedexpansion
set /a pick=%random% %% 10 + 1
for %%A in (%list%) do (
    if !pick! equ 1 (
        endlocal
        call :play "%%A"
        exit /b
    )
    set /a pick-=1
)
endlocal
exit /b