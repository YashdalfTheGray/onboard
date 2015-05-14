# TODO
#   - ASK EVERYTHING FIRST!
#   - install chocolatey (have to use 'choco -y' to install stuff)
#   - install WinRAR
#   - install browsers
#   - install everything else

# declare some variables
$AppsToInstall = @('winrar', 'adobereader')

$Purpose = @{
    "dev" = $false; 
    "media" = $false;
    "productivity" = $false;
    "gaming" = $false;
}

# intro
Write-Output "`nComputer Onboarding Utility v0.0.1`n"
Write-Output "This Utility will automatically install apps after asking the user for options!"
Write-Output "It also installs WinRAR, Adobe Reader and either Firefox or Chrome.`n"

# basic choice structure
$PurposeChoices = [System.Management.Automation.Host.ChoiceDescription[]](
    (New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","This computer will be used for this purpose."),
    (New-Object System.Management.Automation.Host.ChoiceDescription "&No","This computer won't be used for this purpose.")
)

# Asking for the purpose of this computer
if ($host.ui.PromptForChoice('Purpose', "Will this computer be used for development?", $PurposeChoices, (1)) -eq 0) 
{
    $Purpose["dev"] = $true
}

if ($host.ui.PromptForChoice('Purpose', "Will this computer be used for media?", $PurposeChoices, (1)) -eq 0) 
{
    $Purpose["media"] = $true
}

if ($host.ui.PromptForChoice('Purpose', "Will this computer be used for productivity?", $PurposeChoices, (1)) -eq 0) 
{
    $Purpose["productivity"] = $true
}

if ($host.ui.PromptForChoice('Purpose', "Will this computer be used for gaming?", $PurposeChoices, (1)) -eq 0) 
{
    $Purpose["gaming"] = $true
}
 
Write-Output $Purpose

# Asking for which browser to install
$BrowserChoices = [System.Management.Automation.Host.ChoiceDescription[]](
    (New-Object System.Management.Automation.Host.ChoiceDescription "&Chrome","Install Google Chrome"),
    (New-Object System.Management.Automation.Host.ChoiceDescription "&Firefox","Install Mozilla Firefox")
)


if ($host.ui.PromptForChoice('Browser', "What browser should be installed?", $BrowserChoices, (0)) -eq 0) 
{
    if ([System.IntPtr]::Size -eq 4) 
    {
        $AppsToInstall += @('googlechrome')
    }
    else 
    {
        $AppsToInstall += @('google-chrome-x64')
    }
}
else 
{
    $AppsToInstall += @('firefox')
}

# Set up an app choices object
$AppChoices = [System.Management.Automation.Host.ChoiceDescription[]](
        (New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","Install the app"),
        (New-Object System.Management.Automation.Host.ChoiceDescription "&No","Don't install the app")
    )

# Get into asking the development related questions
if ($Purpose["dev"] -eq $true) 
{
    # Set up a choice object for text editors
    $EditorChoices = [System.Management.Automation.Host.ChoiceDescription[]](
        (New-Object System.Management.Automation.Host.ChoiceDescription "&Sublime Text 3","Install Sublime Text 3"),
        (New-Object System.Management.Automation.Host.ChoiceDescription "&Notepad++","Install Notepad++"),
        (New-Object System.Management.Automation.Host.ChoiceDescription "&Atom","Install Atom"),
        (New-Object System.Management.Automation.Host.ChoiceDescription "&Brackets","Install Brackets")
    )

    # Ask for which text editor to install first
    $Choice = $host.ui.PromptForChoice('Text Editor', "What text editor should be installed?", $EditorChoices, (0))

    if ($choice -eq 0)
    {
        $AppsToInstall += @('sublimetext3')
    }
    elseif ($choice -eq 1)
    {
        $AppsToInstall += @('notepadplusplus')
    }
    elseif ($choice -eq 2)
    {
        $AppsToInstall += @('atom')
    }
    elseif ($choice -eq 3)
    {
        $AppsToInstall += @('brackets')
    }

    # Set up a dictionary to relate app names to chocolatey package names
    $DevApps = @{
        "git" = 'git';
        "node.js" = 'nodejs.install';
        "Yeoman" = 'yeoman';
        "Java SE 8 (JDK)" = 'jdk8';
        "Java Runtime (JRE)" = 'javaruntime';
        "Eclipse" = 'eclipse';
        "Netbeans Java SE" = 'netbeans';
        "Android Studio" = 'androidstudio';
        ".Net Framework 4.5 (Full)" = 'dotnet4.5'
        "Visual Studio Community 2013" = 'visualstudiocommunity2013';
        "Ruby" = 'ruby';
        "Python 3.x" = 'python';
        "Python 2.x" = 'python2';
        "CMake 3.x" = 'cmake';
        "Putty" = 'putty'
        "VirtualBox" = 'virtualbox';
        "FileZilla" = 'filezilla';
        "Fiddler" = 'fiddler';
        "Wireshark" = 'wireshark';
        "SourceTree" = 'sourcetree';
    }

    # Ask for each app and store the accepted ones
    ForEach ($item in $DevApps.KEYS.GetEnumerator()) 
    {
        $Choice = $host.ui.PromptForChoice('Development Apps', "Should $item be installed?", $AppChoices, (0))

        if ($choice -eq 0)
        {
            $AppsToInstall += @($DevApps[$item])
        }
    }
}

# Get into asking the media related questions
if ($Purpose["media"] -eq $true) 
{
    # Set up a dictionary to relate apps names to chocolatey package names
    $MediaApps = @{
        "VLC Player" = 'vlc';
        "iTunes" = 'itunes';
        "Spotify" = 'spotify';
        "GIMP" = 'gimp';
        "Calibre" = 'calibre';
        "Audacity" = 'audacity';
        "Plex Media Server" = 'plexmediaserver';
    }

    # Ask for each app and store the accepted ones
    ForEach ($item in $MediaApps.KEYS.GetEnumerator()) 
    {
        $Choice = $host.ui.PromptForChoice('Media Apps', "Should $item be installed?", $AppChoices, (0))

        if ($choice -eq 0)
        {
            $AppsToInstall += @($MediaApps[$item])
        }
    }
}

# Get into asking the productivity related questions
if ($Purpose["productivity"] -eq $true) 
{
    # Set up a dictionary to relate apps names to chocolatey package names
    $ProductivityApps = @{
        "Evernote" = 'evernote';
        "CutePDF Writer" = 'cutepdf';
    }

    # Ask for each app and store the accepted ones
    ForEach ($item in $ProductivityApps.KEYS.GetEnumerator()) 
    {
        $Choice = $host.ui.PromptForChoice('Productivity Apps', "Should $item be installed?", $AppChoices, (0))

        if ($choice -eq 0)
        {
            $AppsToInstall += @($ProductivityApps[$item])
        }
    }
}

# Get into asking the gaming related questions
if ($Purpose["gaming"] -eq $true) 
{
    # Set up a dictionary to relate apps names to chocolatey package names
    $GamingApps = @{
        "Steam" = 'steam';
        "Battle.net" = 'battle.net';
        "Nvidia GeForce Experience" = 'geforce-experience';
    }

    # Ask for each app and store the accepted ones
    ForEach ($item in $GamingApps.KEYS.GetEnumerator()) 
    {
        $Choice = $host.ui.PromptForChoice('Gaming Apps', "Should $item be installed?", $AppChoices, (0))

        if ($choice -eq 0)
        {
            $AppsToInstall += @($GamingApps[$item])
        }
    }
}

Write-Output "`n`n"
Write-Output $AppsToInstall


if (Get-Command choco -errorAction SilentlyContinue)
{
    Write-Output "Chocolatey already exists!"
}
else
{
    Write-Output "Installing Chocolatey..."
    #Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Write-Output "Chocolately install done!"
}

ForEach ($app in $AppsToInstall)
{
    choco -y install $app
}