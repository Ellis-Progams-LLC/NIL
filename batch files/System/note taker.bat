@echo off
title Simple Note Taker
setlocal enabledelayedexpansion

:: Create notes folder if it doesn't exist
if not exist "Notes" mkdir "Notes"

:menu
cls
echo ============================
echo        NOTE TAKER
echo ============================
echo.
echo 1) Add a new note
echo 2) View saved notes
echo 3) Open notes folder
echo 4) Exit
echo.
set /p choice=Choose an option: 

if "%choice%"=="1" goto add
if "%choice%"=="2" goto view
if "%choice%"=="3" goto openfolder
if "%choice%"=="4" exit

goto menu

:add
cls
echo Type your note below.
echo When you're done, press ENTER.
echo.
set /p note=Note: 

:: Timestamped filename
set filename=Notes\note_%date:~-4%-%date:~4,2%-%date:~7,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%.txt

:: Remove spaces from hour
set filename=!filename: =0!

echo %note% > "!filename!"
echo.
echo Note saved!
pause
goto menu

:view
cls
echo Saved notes:
echo.
dir Notes
echo.
pause
goto menu

:openfolder
start "" "Notes"
goto menu