# Onboard

A simple command line utility to spin up a newly formatted Windows computer. This utility depends on Windows PowerShell and Chocolatey. 

## Running

The first step to take is to make sure that Windows PowerShell is installed. If opening the start menu and typing "powershell" doesn't yield results, Windows Powershell is not installed. This should NOT be the case on Windows 7 or higher. 

Next, the execution policy is going to have to be set. This can be done using the command `Set-ExecutionPolicy RemoteSigned`. This tells PowerShell to execute scripts written on the computer. 

Since `onbard` is not written on the computer, running `onbaord` will require right clicking on `onboard.ps1`, clicking on Properties, and then unblocking the script. Another way to achieve this is to run `Set-ExecutionPolicy Unrestricted` which will allow all scripts after confirming execution. 

Once the computer has been onboarded, Powershell can be told to block all execution again using the command `Set-ExecutionPolicy Restricted`. 

The value of the PowerShell execution policy can be checked at any time using the command `Get-ExecutionPolicy`. 

# [Chocolatey](https://chocolatey.org/)

This wonderful utility emulates the `yum` or `apt-get` utilities from the linux world. A simple `choco install [app name]` command from the command prompt will search the chocolatey packages [repository](https://chocolatey.org/packages) and silently install the application. The chocolatey [wiki](https://github.com/chocolatey/choco/wiki) has a lot of great information about everything that this tool is capable of. 

The `onboard` script will install chocolatey on your computer. The chcolatey `install` command is used to install all the apps selected during the questioning. While it is a good idea to keep this utility around, if you wish to uninstall chocolatey, the instructions can be found [here](https://github.com/chocolatey/choco/wiki/Uninstallation). 
