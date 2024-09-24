@echo off
cd "C:\Bin\MTR\Application\MTR"
mtr.exe -c 3595 -i 0.2 -t 1 -o "LS ABW G" -f "C:\Bin\MTR\Logs\%DATE:~4,2%-%DATE:~7,2%-%DATE:~-4%-%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%.txt" -r 8.8.8.8
