@echo off
setlocal EnableDelayedExpansion

:: Setup
if not exist logs mkdir logs
set "logfile=logs\mission.log"
echo [%date% %time%] Launcher initialized. >> "%logfile%"

:: Boot Sequence
cls
echo [SYSTEM] Initializing Starship Systems...
timeout /t 2 >nul
set /a fail_total=0

:: Subsystem Checks
call :check_subsystem Diagnostics 5
call :check_subsystem ProtocolSync 6
call :check_subsystem Uplink 4

:: Final Status
echo [OK] System Ready.
echo [%date% %time%] Boot sequence completed. >> "%logfile%"

:: Lockdown Trigger
if !fail_total! GEQ 3 (
    echo [CRITICAL] Too many subsystems failed. Lockdown triggered.
    echo [%date% %time%] Lockdown triggered. >> "%logfile%"
    set "lockdown=true"
)

:: Recovery Mode
if !fail_total! EQU 2 (
    echo [RECOVERY] Entering System Recovery Mode...
    echo [%date% %time%] Recovery mode activated. >> "%logfile%"
    timeout /t 2 >nul
)

goto main_menu

:: Subsystem Check Logic
:check_subsystem
set "name=%~1"
set /a threshold=%~2
set /a fail=%random%%%threshold
if !fail!==0 (
    echo [ERROR] %name% failed.
    echo [%date% %time%] %name% failed. >> "%logfile%"
    set /a fail_total+=1
    timeout /t 2 >nul
    echo [RETRY] Retrying %name%...
    timeout /t 2 >nul
    echo [OK] %name% restored.
    echo [%date% %time%] %name% restored. >> "%logfile%"
) else (
    echo [OK] %name% complete.
    echo [%date% %time%] %name% complete. >> "%logfile%"
)
timeout /t 1 >nul
exit /b

:: Main Menu
:main_menu
cls
if "%lockdown%"=="true" goto lockdown_menu
echo ========================================
echo         STARSHIP COMMAND INTERFACE
echo ========================================
echo.
echo  [1] Launch Game
echo  [2] Build Override Code Manually
echo  [3] Generate Override Code Automatically
echo  [4] Eject Warp Core
echo  [5] Exit
echo  [6] Encode Log Entry (Blackout-12 Cipher)
echo.
set /p choice=Select an option: 

if "%choice%"=="1" goto launch_game
if "%choice%"=="2" goto build_code
if "%choice%"=="3" goto generate_code
if "%choice%"=="4" goto eject_warp_core
if "%choice%"=="5" goto shutdown_sequence
if "%choice%"=="6" goto encode_log
goto main_menu

:: Launch Game
:launch_game
echo [SYSTEM] Launching game...
timeout /t 2 >nul
goto main_menu

:: Manual Code Builder
:build_code
cls
echo ========================================
echo         BUILD OVERRIDE CODE
echo ========================================
echo.

:: Prefix Selection
echo Select Prefix:
echo  [1] Orion
echo  [2] Alpha
echo  [3] Delta
echo  [4] Echo
set /p prefix_choice=Enter number: 
if "%prefix_choice%"=="1" set "code_1=Orion"
if "%prefix_choice%"=="2" set "code_1=Alpha"
if "%prefix_choice%"=="3" set "code_1=Delta"
if "%prefix_choice%"=="4" set "code_1=Echo"

:: Number Selection
echo.
echo Select Number:
for /L %%N in (1,1,9) do echo  [%%N] %%N
set /p number_choice=Enter number: 
set "code_3=%number_choice%"

:: Suffix Selection
echo.
echo Select Suffix:
echo  [1] Zulu
echo  [2] Omega
echo  [3] Theta
echo  [4] Beta
set /p suffix_choice=Enter number: 
if "%suffix_choice%"=="1" set "code_2=Zulu"
if "%suffix_choice%"=="2" set "code_2=Omega"
if "%suffix_choice%"=="3" set "code_2=Theta"
if "%suffix_choice%"=="4" set "code_2=Beta"

:: Assemble and Save
set "override_code=%code_1%-%code_3%-%code_2%"
echo.
echo FINAL OVERRIDE CODE: %override_code%
echo [%date% %time%] Manual Code Built: %override_code% >> "%logfile%"
echo %override_code% > logs\lastcode.txt
timeout /t 2 >nul
goto main_menu

:: Auto Code Generator
:generate_code
cls
echo ========================================
echo     GENERATING OVERRIDE CODE...
echo ========================================
echo.

set /a prefixNum=%random%%%4 + 1
if %prefixNum%==1 set "code_1=Orion"
if %prefixNum%==2 set "code_1=Alpha"
if %prefixNum%==3 set "code_1=Delta"
if %prefixNum%==4 set "code_1=Echo"

set /a code_3=%random%%%9 + 1

set /a suffixNum=%random%%%4 + 1
if %suffixNum%==1 set "code_2=Zulu"
if %suffixNum%==2 set "code_2=Omega"
if %suffixNum%==3 set "code_2=Theta"
if %suffixNum%==4 set "code_2=Beta"

set "override_code=%code_1%-%code_3%-%code_2%"
echo [AUTO-GENERATED] Override Code: %override_code%
echo [%date% %time%] Auto Code Generated: %override_code% >> "%logfile%"
echo %override_code% > logs\lastcode.txt
timeout /t 2 >nul
goto main_menu

:: Warp Core Ejection
:eject_warp_core
cls
echo [CRITICAL] WARP CORE EJECTION INITIATED
timeout /t 2 >nul
echo Disengaging magnetic locks...
timeout /t 2 >nul
echo Charging ejection coils...
timeout /t 2 >nul
echo 3... 2... 1...
timeout /t 3 >nul
echo [SYSTEM] Warp Core Ejected! Reactor offline.
set "lockdown=true"
echo [%date% %time%] Warp core ejected. Lockdown activated. >> "%logfile%"
goto lockdown_menu

:: Shutdown
:shutdown_sequence
echo [SYSTEM] Shutting down...
echo [%date% %time%] Launcher shutdown. >> "%logfile%"
timeout /t 2 >nul
exit

:: Lockdown Menu
:lockdown_menu
cls
echo ========================================
echo         LOCKDOWN OVERRIDE REQUIRED
echo ========================================
echo Reactor offline. Warp core ejected.
echo System access restricted.
echo.

:: Prefix Selection
echo Select Prefix:
echo  [1] Orion
echo  [2] Alpha
echo  [3] Delta
echo  [4] Echo
set /p prefix_choice=Enter number: 
if "%prefix_choice%"=="1" set "code_1=Orion"
if "%prefix_choice%"=="2" set "code_1=Alpha"
if "%prefix_choice%"=="3" set "code_1=Delta"
if "%prefix_choice%"=="4" set "code_1=Echo"

:: Number Selection
echo.
echo Select Number:
for /L %%N in (1,1,9) do echo  [%%N] %%N
set /p number_choice=Enter number: 
set "code_3=%number_choice%"

:: Suffix Selection
echo.
echo Select Suffix:
echo  [1] Zulu
echo  [2] Omega
echo  [3] Theta
echo  [4] Beta
set /p suffix_choice=Enter number: 
if "%suffix_choice%"=="1" set "code_2=Zulu"
if "%suffix_choice%"=="2" set "code_2=Omega"
if "%suffix_choice%"=="3" set "code_2=Theta"
if "%suffix_choice%"=="4" set "code_2=Beta"
	 goto main_menu
:: Assemble and Compare
set "override_input=%code_1%-%code_3%-%code_2%"
echo.
echo Attempting override with code: %override_input%

if exist logs\lastcode.txt (
    set /p last_code=<logs\lastcode.txt
    if /i "%override_input%"=="%last_code%" (
        echo [✓] Override accepted. Restoring control...
        echo [%date% %time%] Override accepted: %override_input% >> "%logfile%"
        set "lockdown=false"
        timeout /t 2 >nul
        goto main_menu
    ) else (
        echo [ACCESS DENIED] Invalid override code.
        echo [%date% %time%] Override failed: %override_input% >> "%logfile%"
    )
) else (
    echo [