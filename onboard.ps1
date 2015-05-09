# TODO
#   - ASK EVERYTHING FIRST!
#   - install chocolatey
#   - install WinRAR
#   - install browsers
#   - install everything else

# declare some variables
$appsToInstall = @('winrar')

$purpose = @{
    "dev" = $false; 
    "media" = $false
}

# intro
Write-Output "`nComputer Onboarding Utility v0.0.1`n"
Write-Output "This Utility will automatically install apps after asking the user for options!"
Write-Output "It also installs WinRAR and either Firefox or Chrome.`n"

# basic choice structure
$purposeChoices = [System.Management.Automation.Host.ChoiceDescription[]](
    (New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","This computer will be used for this purpose."),
    (New-Object System.Management.Automation.Host.ChoiceDescription "&No","This computer won't be used for this purpose.")
)

# Asking for the purpose of this computer
if ($host.ui.PromptForChoice('Purpose', "Will this computer be used for development?", $purposeChoices, (1)) -eq 0) 
{
    $purpose["dev"] = $true
}

if ($host.ui.PromptForChoice('Purpose', "Will this computer be used for media?", $purposeChoices, (1)) -eq 0) 
{
    $purpose["media"] = $true
}
 
Write-Output $purpose

# Asking for which browser to install
$BrowserChoices = [System.Management.Automation.Host.ChoiceDescription[]](
    (New-Object System.Management.Automation.Host.ChoiceDescription "&Chrome","Install Google Chrome"),
    (New-Object System.Management.Automation.Host.ChoiceDescription "&Firefox","Install Mozilla Firefox")
)


if ($host.ui.PromptForChoice('Purpose', "Will this computer be used for development?", $BrowserChoices, (0)) -eq 0) 
{
    if ([System.IntPtr]::Size -eq 4) 
    {
        $appsToInstall += @('googlechrome')
    }
    else 
    {
        $appsToInstall += @('google-chrome-x64')
    }
}
else 
{
    $appsToInstall += @('firefox')
}

Write-Output $appsToInstall