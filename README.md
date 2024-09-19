# MTR-Logger-Windows
This logger was created for the purpose of logging client devices receiving packet loss against Google's DNS server (8.8.8.8)

If you'd like to measure it against a different address, feel free to edit the run_mtr_every_hour.bat file. Simply just change 8.8.8.8 to a different IP/dns address.

# Steps to Install on a Client Device:

# Step 1: Use Curl!

Run this curl command in an elevated cmd prompt: 

curl -L https://raw.githubusercontent.com/JumperTheHero/mtr-logger-windows/main/Bin/MTR/Application/Bat_Files/staging.bat

# Step 1a: Don't have curl? Here's how to install:

If you do not have Curl installed, likely you aren't on a later build of Windows. This is fine because we can use Chocolatey to install the curl package for us!

Here's the command: 

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

This command will install Chocolatey onto the client device. If for any reason it does not work, ensure you are running it via an admin cmd prompt. I have tested this via remoting agent tools that let you run commands against Windows devices and it successfully worked. So if you want to mass deploy this to a client site, check the manual for the remote software you use and run the command above to install Chocolately.

# Step 1b: Now that we have Chocolatey...

Now that we have Chocolatey, we will need to download curl and install it. It's fairly simple once you have installed Chocolatey. If Chocolatey asked you to reboot after install, please do reboot as you won't be able to install packages after installing Chocolatey. After reboot, run the following command:

choco install curl

Confirmed curl is installed by running the command in Step 1. If it successfully downloads the staging.bat file, you are all set! The staging.bat file will download all of the neccessary files from this repository and build out the files in the following directory:  **C:\Bin\MTR\**

The file structure in the repository mirrors the same way it will be on all client devices! :)

# Step 2: Grab a coffee and let the logs get created!

Once logs get created via the **run_mtr_every_hour.bat** file setup in Task Scheduler, they will be stored under **C:\Bin\MTR\Logs**

The logs for today's date will be moved at 12:01AM every day over to the **C:\Bin\MTR\Logs\Archives** directory.

The Archives directory also has a rule set in place to check for any folders modified with more than 30 days old. If for any reason there is a folder older than 30 days (this will happen over time), then the folders will be deleted. The archive_dump.bat file is doing all of this. It also is setup under Task Scheduler. 

If for any reason you do want to view the bat files, they will be pulled from the repo to the following directory: **C:\Bin\MTR\Application\Bat_Files**

You can also view these bat files in the repo as well without having to download them!

If you have any questions or suggestions, feel free to create an issue on the repo. Thanks! :)
