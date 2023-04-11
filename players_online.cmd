@echo off
set timestamp=%date:~3,2%-%date:~6,2%-%date:~-4%,%time:~0,2%:%time:~3,2%
for /f %%a in ('netstat -n ^| find "192.168.88.4:25565" ^| find /c "ESTABLISHED"') do set online=%%a
echo %timestamp%,%online% >> players_online.csv
