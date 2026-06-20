@echo off
setlocal enabledelayedexpansion

:: History log file
set "logFile=Calculator_History.txt"

:menu
cls
echo === Batch Calculator ===
echo.
echo 1. Perform Calculation
echo 2. Clear History
echo 3. Exit
set /p "choice=Choose option (1-3): "

if "%choice%"=="1" goto calc
if "%choice%"=="2" goto clear
if "%choice%"=="3" exit
goto menu

:calc
cls
set /p "num1=Enter first number: "

echo.
echo Choose operator:
echo 1. Addition (+)
echo 2. Subtraction (-)
echo 3. Multiplication (*)
echo 4. Division (/)
set /p "opChoice=Enter choice (1-4): "

set /p "num2=Enter second number: "

:: Map choice to operator
set "op="
if "%opChoice%"=="1" set "op=+"
if "%opChoice%"=="2" set "op=-"
if "%opChoice%"=="3" set "op=*"
if "%opChoice%"=="4" set "op=/"

:: Error handling
if "%op%"=="" (
    echo Invalid operator choice.
    pause
    goto menu
)

if "%op%"=="/" if "%num2%"=="0" (
    echo Error: Division by zero is not allowed.
    pause
    goto menu
)

:: Perform calculation
set /a result=num1 %op% num2

echo.
echo Result: %result%

:: Log calculation with timestamp
for /f "tokens=1-4 delims=:. " %%a in ("%time%") do (
    set "timestamp=%date% %%a:%%b:%%c"
)
echo %timestamp% - %num1% %op% %num2% = %result% >> "%logFile%"

echo.
echo Calculation saved to %logFile%
pause
goto menu

:clear
cls
if exist "%logFile%" (
    del "%logFile%"
    echo History cleared.
) else (
    echo No history file found.
)
pause
goto menu