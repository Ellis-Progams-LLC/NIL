@echo off
title Quick Folder Creator
cls

echo === Quick Folder Creator ===
echo.
echo Choose an option:
echo 1. Create default folder set
echo 2. Enter custom folder names
echo 3. Exit
set /p choice=Enter choice (1-3): 

if "%choice%"=="1" goto default
if "%choice%"=="2" goto custom
if "%choice%"=="3" exit
goto :eof

:default
:: Predefined folders
set "baseDir=C:\Projects"
md "%baseDir%\Docs"
md "%baseDir%\Images"
md "%baseDir%\Scripts"
md "%baseDir%\Backups"
echo Default folders created under %baseDir%.
pause
goto :menu

:custom
set /p "baseDir=Enter base directory (e.g. C:\Projects): "
set /p "names=Enter folder names separated by spaces: "

for %%f in (%names%) do (
    md "%baseDir%\%%f"
    echo Created: %baseDir%\%%f
)
pause
goto :menu

:menu
cls
goto :main