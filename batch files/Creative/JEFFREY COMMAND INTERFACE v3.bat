@echo off
echo Launcher started
pause
setlocal

:: Check if the flag file exists
if exist "%temp%\launcher_maximized.flag" goto launcher

:: Create the flag file
echo. > "%temp%\launcher_maximized.flag"

:: Relaunch in maximized window
powershell -command "Start-Process cmd -ArgumentList '/k call \"%~f0\"' -WindowStyle Maximized"
exit

:launcher
:: Delete the flag so it doesn't persist
del "%temp%\launcher_maximized.flag" >nul 2>&1

:: Set sci-fi theme
color 0B
title JEFFREY COMMAND INTERFACE v3.0

:: Define paths
set steam=C:\Steam\steam.exe
set stormworks=C:\Steam\steamapps\common\Stormworks\stormworks64.exe
set modsFolder=C:\Steam\steamapps\workshop\content\573090
set logFile=%~dp0launcher_log.txt

:: Log function
:log
echo [%date% %time%] %1 >> "%logFile%"
goto :eof

:: Log startup
call :log Launcher Initialized

:: Boot sequence
cls
echo.
echo  ╔════════════════════════════════════════════════╗
echo  ║   SYSTEM BOOT: JEFFREY COMMAND INTERFACE v3.0 ║
echo  ╚════════════════════════════════════════════════╝
echo  [✓] Core Systems Online
ping localhost -n 1 >nul
echo  [✓] Launcher Modules Loaded
ping localhost -n 1 >nul
echo  [✓] Visual Interface Activated
ping localhost -n 1 >nul
echo.
echo  █
ping localhost -n 1 >nul
echo  ██
ping localhost -n 1 >nul
echo  ███
ping localhost -n 1 >nul
echo  ████
ping localhost -n 1 >nul
echo  █████ SYSTEM READY
ping localhost -n 1 >nul

:menu
cls
echo ╔════════════════════════════════════════════════╗
echo ║         COMMAND MODULE: MAIN INTERFACE         ║
echo ╠════════════════════════════════════════════════╣
echo ║  1 - Launch Steam                               ║
echo ║  2 - Stormworks Submenu                         ║
echo ║  3 - Diagnostics Panel                          ║
echo ║  4 - Open Command Prompt                        ║
echo ║  5 - Exit                                       ║
echo ╚════════════════════════════════════════════════╝
set /p choice=Enter command code (1-5): 

:: Handle choices
if "%choice%"=="1" (
    call :log Launching Steam
    echo [SYSTEM] Executing Steam launch protocol...
    start "" "%steam%"
    ping localhost -n 2 >nul
    goto menu
) else if "%choice%"=="2" (
    goto stormworks_menu
) else if "%choice%"=="3" (
    goto diagnostics
) else if "%choice%"=="4" (
    call :log Opening Command Prompt
    echo [SYSTEM] Opening command terminal...
    start cmd
    ping localhost -n 2 >nul
    goto menu
) else if "%choice%"=="5" (
    call :log Exiting Launcher
    echo [SYSTEM] Shutting down interface. Goodbye, Commander.
    echo [SYSTEM] Terminating in 3...
    ping localhost -n 2 >nul
    echo [SYSTEM] Terminating in 2...
    ping localhost -n 2 >nul
    echo [SYSTEM] Terminating in 1...
    ping localhost -n 2 >nul
    echo [SYSTEM] Session Logged.
    exit
) else (
    echo [ERROR] Invalid command. Please try again.
    pause
    goto menu
)

:stormworks_menu
cls
echo ╔════════════════════════════════════════════════╗
echo ║       STORMWORKS MODULE: OPERATIONS PANEL      ║
echo ╠════════════════════════════════════════════════╣
echo ║  1 - Launch Stormworks                          ║
echo ║  2 - Open Mods Folder                           ║
echo ║  3 - Return to Main Menu                        ║
echo ╚════════════════════════════════════════════════╝
set /p swchoice=Enter command code (1-3): 

if "%swchoice%"=="1" (
    call :log Launching Stormworks
    echo [SYSTEM] Launching Stormworks simulation...
    start "" "%stormworks%"
    ping localhost -n 2 >nul
    goto stormworks_menu
) else if "%swchoice%"=="2" (
    call :log Opening Stormworks Mods Folder
    echo [SYSTEM] Opening mod archive...
    start "" "%modsFolder%"
    ping localhost -n 2 >nul
    goto stormworks_menu
) else if "%swchoice%"=="3" (
    goto menu
) else (
    echo [ERROR] Invalid command. Please try again.
    pause
    goto stormworks_menu
)

:diagnostics
cls
echo ╔════════════════════════════════════════════════╗
echo ║         SYSTEM DIAGNOSTICS PANEL               ║
echo ╠════════════════════════════════════════════════╣
echo ║  Date:        %date%                           ║
echo ║  Time:        %time%                           ║
echo ║  User:        %username%                       ║
echo ║  Computer:    %computername%                   ║
echo ╚════════════════════════════════════════════════╝
call :log Viewed Diagnostics Panel
pause
goto menu