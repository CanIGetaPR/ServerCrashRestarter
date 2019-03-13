@echo off
REM Version 0.1 Includes Check for existance of WerFault.exe
REM And the ability to end WerFault.exe so that the server
REM Is able to crash fully.
REM
REM Check for loop 30 seconds using ping delay
REM Taskkill WerFault
REM 
title EOSource Restarter
ECHO EoSource Server Restarter Version 0.0.1.3
ECHO
ECHO Current time: %time% %date%
ECHO To exit, type Control-C
set wf=WerFault.exe
set eo=EOSource
set currtime=%time%
set /a rcount=0
set /a errcount=0

goto start

:loop
IF EXIST eosource.exe START /min eosource.exe
tasklist /FI "IMAGENAME eq WerFault.exe" | find /I "WerFault.exe" >nul >nul
IF %ERRORLEVEL% neq 1 TASKKILL /F /IM WerFault.exe && ECHO. && ECHO !!!!! %eo% has been unlocked !!!!! && set /a rcount=%rcount%+1 && ECHO Time of Crash: %time% %date% >> RestartLog.txt && ECHO. && ECHO Time of Crash: %time% %date% && goto start
IF %ERRORLEVEL% == 1 goto delay
goto error

:delay
ping 2 -n 10 >nul
goto loop

:start
ECHO.
ECHO.
ECHO.
ECHO Error Count: %errcount%
ECHO Restart Count: %rcount%
IF EXIST eosource.exe (START /min eosource.exe && ECHO Start Control Sent to %eo%.exe) else (ECHO. && ECHO Failed to start %eo%, target could not be found.)
ECHO. 
ECHO Searching for WerFault.exe
ECHO.
ECHO.
ECHO.
goto loop

REM 0xA
:error
ECHO.
ECHO An unknown error has occured during CHECK INITIALIZATION 0x0A !
ECHO Restarting application...
ping 2 -n 5 >nul
set /a errcount=%errcount%+1
goto start

REM 0xB
ECHO.
ECHO A Fatal Has Occurred!
ECHO Restarting Script!!!!
ECHO Error Code 0xB >> C:\ServerRestarterFatalError.txt
ping 2 -n 5 >nul
set /a errcount=%errcount%+1000
goto start

