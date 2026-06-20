@echo off
Title Abort
Shutdown -a
if Not Errorlevel 1 (
goto Good
) Else ( 
goto Bad
)

:Good
Echo Success!
Pause>Nul
Exit

:Bad
Echo No Shutdown Was initiated.
Pause>Nul
Exit
}