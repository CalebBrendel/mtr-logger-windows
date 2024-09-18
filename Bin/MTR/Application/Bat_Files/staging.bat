@echo on
mkdir C:\Bin
mkdir C:\Bin\MTR
mkdir C:\Bin\MTR\Application
mkdir C:\Bin\MTR\Logs
mkdir C:\Bin\MTR\Application\Bat_Files
mkdir C:\Bin\MTR\Application\MTR

timeout /t 5

curl -L https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/MTR/mtr.exe > C:\Bin\MTR\Application\MTR1\mtr.exe

curl -L https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/Bat_Files/run_mtr_every_hour.bat > C:\Bin\MTR\Application\MTR1\run_mtr_every_hour.bat

