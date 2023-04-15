@echo off

:: Get timestamp
set timestamp=%date:~3,2%-%date:~6,2%-%date:~-4% %time:~0,2%:%time:~3,2%

:: Get local ip address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| find "IPv4"') do set ip=%%a
set ip=%ip:~1%

:: Get Minecraft server connections
for /f %%a in ('netstat -n ^| find "%ip%:25565" ^| find /c "ESTABLISHED"') do set online=%%a

:: Write to csv (max 30 days, 4*24*30=2880)
call :addLine "C:\Data\www\cleanmc.com\stats\players_online.csv" 2880 "%timestamp%,%online%"
exit /b


:addLine
:: Usage: call :addLine "<filename>" <maxlines> "<line to add>"
(echo %~3)>>%1
:removelines
call :countlines %1
if %count% leq %2 exit /b
call :removefirstline %1
goto removelines


:countlines
:: Usage: call :countlines "<filename>"
:: Returns: the variable %count% will be set with the number of lines in the file
for /f "tokens=3" %%a in ('find /v /c "#$#" %1') do (set count=%%a)
exit /b


:removefirstline
:: Usage: call :removefirstline "<filename>"
findstr /v /n "#$#" %1 > "temp1.tmp"
findstr /v /b "1:" "temp1.tmp" > "temp2.tmp"
copy nul %1>nul
for /f "tokens=1* delims=:" %%a in ('type "temp2.tmp"') do ((echo %%b)>>%1)
del "temp1.tmp" "temp2.tmp"
exit /b
