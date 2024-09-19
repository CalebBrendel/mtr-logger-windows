@echo off

forfiles /P "C:\Bin\MTR\Logs\Archive" /s /D -30 /C "cmd /c if @isdir==TRUE rd /S /Q @path"
