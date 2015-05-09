# Onboard

A simple command line utility to spin up a newly formatted Windows computer. This utility depends on Windows PowerShell and Chocolatey. 

# Running

The first step to take is to make sure that Windows PowerShell is installed. If opening the start menu and typing "powershell" doesn't yield results, Windows Powershell is not installed. 

Once PowerShell is installed, the execution policy is going to have to be set. This can be done using the command `Set-ExecutionPolicy RemoteSigned`. This tells PowerShell to execute scripts written on the computer. 

Running `onbaord` will require right clicking on `onboard.ps1`, clicking on Properties, and then unblocking the script.

Once the computer has been onboarded, Powershell can be told to block all execution again using the command `Set-ExecutionPolicy Restricted`. 

The value of the PowerShell execution policy can be checked at any time using the command `Get-ExecutionPolicy`. 