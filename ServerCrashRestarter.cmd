@echo off
REM to do, add counter for failing to restart, send admin alert when such happens
REM Version 0.1 Includes Check for existance of WerFault.exe
REM And the ability to end WerFault.exe so that the server
REM Is able to crash fully.
REM
REM Check for loop 10 seconds using ping delay
REM Taskkill WerFault
REM 
title Server Crash Restarter
ECHO Server Crash Restarter Version 0.0.1.6c
ECHO
ECHO Current time: %time% %date%
ECHO To exit, type Control-C
ECHO.
ECHO Restart Codes: 
ECHO r1 - EOSource was not found to be running.  
ECHO r2 - A WerFault instance was detected and EOSource was restarted.

set wf=WerFault.exe
set server=eoserv.exe
set currtime=%time%
set /a rcount=0
set /a errcount=0

goto start

REM 0xA
:loop
tasklist /FI "IMAGENAME eq WerFault.exe" 2>NUL | find /I "WerFault.exe" 2>NUL
IF %ERRORLEVEL% neq 1 TASKKILL /F /IM WerFault.exe && ECHO. && ECHO !!!!! %server% has been unlocked !!!!! && set /a rcount=%rcount%+1 && ECHO Time of Crash: %time% %date% (r2) >> RestartLog.txt && ECHO. && ECHO Time of Crash: %time% %date% && goto start
IF %ERRORLEVEL% == 1 goto delay
goto error

:delay
tasklist /FI "IMAGENAME eq %server%" | find /I "%server%" 2>nul >nul
IF %ERRORLEVEL% == 1 START /min %server% && ECHO *Warning* %server% was not found in the process list and has now been restarted. %time% %date% && ECHO %server% may have crashed around this time (r1). %time% %date% >> RestartLog.txt
ping 127.0.0.1 -n 10 >nul
goto loop

:start
ECHO.
ECHO.
ECHO.
ECHO Error Count: %errcount%
ECHO Restart Count: %rcount%
IF EXIST %server% (START /min %server% && ECHO Start Control Sent to %server%) else (ECHO. && ECHO Failed to start %server%, target could not be found. && pause >nul && exit)
ECHO.
ECHO Waiting for a WerFault.exe instance.
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

REM 0xB EoF
ECHO.
ECHO A Fatal Has Occurred!
ECHO Restarting Script!!!!
ECHO Error Code 0xB >> C:\ServerRestarterFatalError.txt
ping 2 -n 5 >nul
set /a errcount=%errcount%+1000
goto start

