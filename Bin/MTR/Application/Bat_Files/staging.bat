REM Batch script created by Caleb Brendel


REM Make directories to store all of MTR applications.


@echo off


mkdir C:\Bin
mkdir C:\Bin\MTR
mkdir C:\Bin\MTR\Application
mkdir C:\Bin\MTR\Logs
mkdir C:\Bin\MTR\Logs\Archive
mkdir C:\Bin\MTR\Application\Bat_Files
mkdir C:\Bin\MTR\Application\MTR
mkdir C:\Bin\MTR\Application\Task_Scheduler


REM The commands below adds an admin MTR local user onto the client device. This user is used to authenticate and properly import all of the .xml tasks!


net user MTR q2B@*Q!el#8kio /add
net localgroup administrators MTR /add
net localgroup "Users" "MTR" /delete


REM Curl commands below to download all the neccessary files!


curl -L https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/MTR/mtr.exe > C:\Bin\MTR\Application\MTR\mtr.exe

curl -L https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/Bat_Files/run_mtr_every_hour.bat > C:\Bin\MTR\Application\Bat_Files\run_mtr_every_hour.bat

curl -L https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/Bat_Files/archive.bat > C:\Bin\MTR\Application\Bat_Files\archive.bat

curl -L https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/Bat_Files/archive_dump.bat > C:\Bin\MTR\Application\Bat_Files\archive_dump.bat

curl -L https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/Bat_Files/create_archive_dirs.bat > C:\Bin\MTR\Application\Bat_Files\create_archive_dirs.bat

curl -L https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/Bat_Files/staging.bat > C:\Bin\MTR\Application\Bat_Files\staging.bat

curl -L https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/Task_Scheduler/Run_Archive_Dir_Creation.xml > C:\Bin\MTR\Application\Task_Scheduler\Run_Archive_Dir_Creation.xml

curl -L https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/Task_Scheduler/Run_Archive_Dump_Script.xml > C:\Bin\MTR\Application\Task_Scheduler\Run_Archive_Dump_Script.xml

curl -L https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/Task_Scheduler/Run_Archive_Script.xml > C:\Bin\MTR\Application\Task_Scheduler\Run_Archive_Script.xml

curl -L https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/Task_Scheduler/Run_MTR_Every_Hour.xml > C:\Bin\MTR\Application\Task_Scheduler\Run_MTR_Every_Hour.xml


REM Import .xml Task Scheduler tasks below!

schtasks /create /xml "C:\Bin\MTR\Application\Task_Scheduler\Run_MTR_Every_Hour.xml" /tn "\MTR\RunMTREveryHour" /ru "%computername%\MTR" /rp "q2B@*Q!el#8kio"

schtasks /create /xml "C:\Bin\MTR\Application\Task_Scheduler\Run_Archive_Script.xml" /tn "\MTR\RunArchiveScript" /ru "%computername%\MTR" /rp "q2B@*Q!el#8kio"

schtasks /create /xml "C:\Bin\MTR\Application\Task_Scheduler\Run_Archive_Dump_Script.xml" /tn "\MTR\RunArchiveDumpScript" /ru "%computername%\MTR" /rp "q2B@*Q!el#8kio"

schtasks /create /xml "C:\Bin\MTR\Application\Task_Scheduler\Run_Archive_Dir_Creation.xml" /tn "\MTR\RunArchiveDirCreation" /ru "%computername%\MTR" /rp "q2B@*Q!el#8kio"
