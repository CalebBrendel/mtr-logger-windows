@echo off
move "C:\Bin\MTR\Logs\*.txt" C:\Bin\MTR\Logs\Archive\%DATE:~4,2%-%DATE:~7,2%-%DATE:~-4%
