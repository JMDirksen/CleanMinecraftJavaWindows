@echo off
for /f %%a in ('netstat -n ^| find "192.168.88.4:25565" ^| find /c "ESTABLISHED"') do set online=%%a
if %online% gtr 0 echo %date% %time% %online% >> players_online.log
