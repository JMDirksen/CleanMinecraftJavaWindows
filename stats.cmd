@echo off
setlocal EnableDelayedExpansion

:: Load defaults
set last=0
set max=0
set maxAt=-
set dAvg=0
set mAvg=0

:: Load stored data
if exist stats.db for /f "tokens=*" %%a in (stats.db) do set %%a

:: Get local ip address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| find "IPv4"') do set ip=%%a
set ip=%ip:~1%

:: Get Minecraft server connections
for /f %%a in ('netstat -n ^| find "%ip%:25565" ^| find /c "ESTABLISHED"') do set current=%%a

:: Calculate stats
set last=%current%
if %current% gtr %max% (
  set max=%current%
  set maxAt=%date% %time%
)
set /a dAvg=( %dAvg% * 287 + %current% * 1000000 ) / 288
set /a mAvg=( %mAvg% * 8639 + %current% * 1000000 ) / 8640

:: Save data
echo last=!last!>stats.db
echo max=!max!>>stats.db
echo maxAt=!maxAt!>>stats.db
echo dAvg=!dAvg!>>stats.db
echo mAvg=!mAvg!>>stats.db

:: Output HTML
echo ^<html^>^<head^>^<title^>Stats (%current%)^</title^>^<meta http-equiv=refresh content=60^>^</head^>^<body^>^<p^> >stats.html
echo Current: %current% ^<br^> >>stats.html
echo Max: %max% @ %maxAt% ^<br^> >>stats.html
echo Daily average: ^<script^>document.write(Math.round(%dAvg%/10000)/100)^</script^> ^<br^> >>stats.html
echo Monthly average: ^<script^>document.write(Math.round(%mAvg%/10000)/100)^</script^> ^<br^> >>stats.html
echo ^</p^>^</body^>^</html^> >>stats.html

:: Copy to webserver
copy /y stats.html C:\Data\www\cleanmc.com\stats\index.html

exit /b
