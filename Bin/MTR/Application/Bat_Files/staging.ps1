# PowerShell script by Caleb Brendel

# Create directories
$dirs = @(
    "C:\Bin",
    "C:\Bin\MTR",
    "C:\Bin\MTR\Application",
    "C:\Bin\MTR\Logs",
    "C:\Bin\MTR\Logs\Archive",
    "C:\Bin\MTR\Application\Bat_Files",
    "C:\Bin\MTR\Application\MTR",
    "C:\Bin\MTR\Application\Task_Scheduler"
)

foreach ($dir in $dirs) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
    }
}

# Create MTR local user and configure
$user = "MTR"
$password = "q2B@*Q!el#8kio"
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force

if (-not (Get-LocalUser -Name $user -ErrorAction SilentlyContinue)) {
    New-LocalUser -Name $user -Password $securePassword -FullName "MTR Admin User" -PasswordNeverExpires:$true
    Add-LocalGroupMember -Group "Administrators" -Member $user
    Remove-LocalGroupMember -Group "Users" -Member $user -ErrorAction SilentlyContinue
}

# Download files using Invoke-WebRequest
$files = @{
    "https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/MTR/mtr.exe" = "C:\Bin\MTR\Application\MTR\mtr.exe"
    "https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/Bat_Files/run_mtr_every_hour.bat" = "C:\Bin\MTR\Application\Bat_Files\run_mtr_every_hour.bat"
    "https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/Bat_Files/archive.bat" = "C:\Bin\MTR\Application\Bat_Files\archive.bat"
    "https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/Bat_Files/archive_dump.bat" = "C:\Bin\MTR\Application\Bat_Files\archive_dump.bat"
    "https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/Bat_Files/create_archive_dirs.bat" = "C:\Bin\MTR\Application\Bat_Files\create_archive_dirs.bat"
    "https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/Bat_Files/staging.bat" = "C:\Bin\MTR\Application\Bat_Files\staging.bat"
    "https://raw.githubusercontent.com/CalebBrendel/mtr-logger-windows/refs/heads/main/Bin/MTR/Application/Task_Scheduler/RunArchiveDirCreation.xml" = "C:\Bin\MTR\Application\Task_Scheduler\RunArchiveDirCreation.xml"
    "https://raw.githubusercontent.com/CalebBrendel/mtr-logger-windows/refs/heads/main/Bin/MTR/Application/Task_Scheduler/RunArchiveDumpScript.xml" = "C:\Bin\MTR\Application\Task_Scheduler\RunArchiveDumpScript.xml"
    "https://raw.githubusercontent.com/CalebBrendel/mtr-logger-windows/refs/heads/main/Bin/MTR/Application/Task_Scheduler/RunArchiveScript.xml" = "C:\Bin\MTR\Application\Task_Scheduler\RunArchiveScript.xml"
    "https://raw.githubusercontent.com/CalebBrendel/mtr-logger-windows/refs/heads/main/Bin/MTR/Application/Task_Scheduler/RunMTREveryHour.xml" = "C:\Bin\MTR\Application\Task_Scheduler\RunMTREveryHour.xml"
}

foreach ($url in $files.Keys) {
    Invoke-WebRequest -Uri $url -OutFile $files[$url]
}

# Register Task Scheduler tasks
$taskXmlFiles = @(
    @{ Path = "C:\Bin\MTR\Application\Task_Scheduler\RunMTREveryHour.xml"; Name = "\MTR\MTR Every Hour" },
    @{ Path = "C:\Bin\MTR\Application\Task_Scheduler\RunArchiveScript.xml"; Name = "\MTR\Create Daily MTR Archive" },
    @{ Path = "C:\Bin\MTR\Application\Task_Scheduler\RunArchiveDumpScript.xml"; Name = "\MTR\MTR Archive Dump" },
    @{ Path = "C:\Bin\MTR\Application\Task_Scheduler\RunArchiveDirCreation.xml"; Name = "\MTR\MTR Archive Dir Creation" }
)

foreach ($task in $taskXmlFiles) {
    schtasks /create /xml $task.Path /tn $task.Name /ru "$env:COMPUTERNAME\MTR" /rp $password
}
