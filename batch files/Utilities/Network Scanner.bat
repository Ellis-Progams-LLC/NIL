@echo off
title Network Scanner with Hostnames + Logging
cls

:: Log file
set "logFile=NetworkScan_Log.txt"

echo === Network Scanner ===
echo.
set /p "startIP=Enter starting IP (e.g. 192.168.1.1): "
set /p "endIP=Enter ending IP (e.g. 192.168.1.50): "

:: Extract base (first three octets)
for /f "tokens=1-3 delims=." %%a in ("%startIP%") do (
    set "base=%%a.%%b.%%c."
    set "start=%%d"
)
for /f "tokens=4 delims=." %%a in ("%endIP%") do set "end=%%a"

:: Timestamp header
for /f "tokens=1-4 delims=:. " %%a in ("%time%") do (
    set "timestamp=%date% %%a:%%b:%%c"
)
echo =============================== >> "%logFile%"
echo Scan started: %timestamp% >> "%logFile%"
echo Range: %base%%start% to %base%%end% >> "%logFile%"
echo =============================== >> "%logFile%"

echo.
echo Scanning %base%%start% to %base%%end% ...
echo.

for /l %%i in (%start%,1,%end%) do (
    set "ip=%base%%%i"
    for /f "tokens=2 delims=[]" %%h in ('ping -a -n 1 -w 100 !ip! ^| find "["') do (
        echo !ip! is ONLINE - Hostname: %%h
        echo !ip! is ONLINE - Hostname: %%h >> "%logFile%"
    )
    if errorlevel 1 (
        echo !ip! is offline
        echo !ip! is offline >> "%logFile%"
    )
)

echo.
echo Scan complete. Results saved to %logFile%
pause