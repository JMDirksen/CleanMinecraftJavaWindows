@echo off
title Minecraft Java Server
mkdir server 2>nul
cd server
:loop
echo eula=true>eula.txt
xcopy ..\server.jar . /m /y
xcopy ..\server-icon.png . /m /y
xcopy ..\server.properties . /m /y
xcopy ..\ops.json . /m /y
xcopy ..\datapacks world\datapacks /s /i /m /y
start /abovenormal /b /wait ..\java\bin\java.exe -Xmx8G -Xms8G -jar server.jar nogui
timeout /t 5
goto loop
