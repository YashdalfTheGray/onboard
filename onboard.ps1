# TODO
#   - ASK EVERYTHING FIRST!
#   - install chocolatey (have to use 'choco -y' to install stuff)
#   - install WinRAR
#   - install browsers
#   - install everything else

# declare some variables
$appsToInstall = @('winrar', 'adobereader')

$purpose = @{
    "dev" = $false; 
    "media" = $false;
    "productivity" = $false;
    "gaming" = $false;
}
$appString = "";

# intro
Write-Output "`nComputer Onboarding Utility v0.0.1`n"
Write-Output "This Utility will automatically install apps after asking the user for options!"
Write-Output "It also installs WinRAR, Adobe Reader and either Firefox or Chrome.`n"

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

if ($host.ui.PromptForChoice('Purpose', "Will this computer be used for productivity?", $purposeChoices, (1)) -eq 0) 
{
    $purpose["productivity"] = $true
}

if ($host.ui.PromptForChoice('Purpose', "Will this computer be used for gaming?", $purposeChoices, (1)) -eq 0) 
{
    $purpose["gaming"] = $true
}

# Set up some browser choices
$browserChoices = [System.Management.Automation.Host.ChoiceDescription[]](
    (New-Object System.Management.Automation.Host.ChoiceDescription "&Chrome","Install Google Chrome"),
    (New-Object System.Management.Automation.Host.ChoiceDescription "&Firefox","Install Mozilla Firefox"),
    (New-Object System.Management.Automation.Host.ChoiceDescription "&None","Don't install another browser")
)

# Asking for which browser to install
$choice = $host.ui.PromptForChoice('Browser', "What browser should be installed?", $browserChoices, (0))
if ($choice -eq 0) 
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
elseif ($choice -eq 1)
{
    $appsToInstall += @('firefox')
}

# Set up an app choices object
$appChoices = [System.Management.Automation.Host.ChoiceDescription[]](
        (New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","Install the app"),
        (New-Object System.Management.Automation.Host.ChoiceDescription "&No","Don't install the app")
    )

# Get into asking the development related questions
if ($purpose["dev"] -eq $true) 
{
    # Set up a choice object for text editors
    $EditorChoices = [System.Management.Automation.Host.ChoiceDescription[]](
        (New-Object System.Management.Automation.Host.ChoiceDescription "&Sublime Text 3","Install Sublime Text 3"),
        (New-Object System.Management.Automation.Host.ChoiceDescription "&Notepad++","Install Notepad++"),
        (New-Object System.Management.Automation.Host.ChoiceDescription "&Atom","Install Atom"),
        (New-Object System.Management.Automation.Host.ChoiceDescription "&Brackets","Install Brackets")
    )

    # Ask for which text editor to install first
    $choice = $host.ui.PromptForChoice('Text Editor', "What text editor should be installed?", $EditorChoices, (0))

    if ($choice -eq 0)
    {
        $appsToInstall += @('sublimetext3')
    }
    elseif ($choice -eq 1)
    {
        $appsToInstall += @('notepadplusplus')
    }
    elseif ($choice -eq 2)
    {
        $appsToInstall += @('atom')
    }
    elseif ($choice -eq 3)
    {
        $appsToInstall += @('brackets')
    }

    # Set up a dictionary to relate app names to chocolatey package names
    $devApps = @{
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
    ForEach ($item in $devApps.KEYS.GetEnumerator()) 
    {
        $choice = $host.ui.PromptForChoice('Development Apps', "Should $item be installed?", $appChoices, (0))

        if ($choice -eq 0)
        {
            $appsToInstall += @($devApps[$item])
        }
    }
}

# Get into asking the media related questions
if ($purpose["media"] -eq $true) 
{
    # Set up a dictionary to relate apps names to chocolatey package names
    $mediaApps = @{
        "VLC Player" = 'vlc';
        "iTunes" = 'itunes';
        "Spotify" = 'spotify';
        "GIMP" = 'gimp';
        "Calibre" = 'calibre';
        "Audacity" = 'audacity';
        "Plex Media Server" = 'plexmediaserver';
    }

    # Ask for each app and store the accepted ones
    ForEach ($item in $mediaApps.KEYS.GetEnumerator()) 
    {
        $choice = $host.ui.PromptForChoice('Media Apps', "Should $item be installed?", $appChoices, (0))

        if ($choice -eq 0)
        {
            $appsToInstall += @($mediaApps[$item])
        }
    }
}

# Get into asking the productivity related questions
if ($purpose["productivity"] -eq $true) 
{
    # Set up a dictionary to relate apps names to chocolatey package names
    $productivityApps = @{
        "Evernote" = 'evernote';
        "CutePDF Writer" = 'cutepdf';
    }

    # Ask for each app and store the accepted ones
    ForEach ($item in $productivityApps.KEYS.GetEnumerator()) 
    {
        $choice = $host.ui.PromptForChoice('Productivity Apps', "Should $item be installed?", $appChoices, (0))

        if ($choice -eq 0)
        {
            $appsToInstall += @($productivityApps[$item])
        }
    }
}

# Get into asking the gaming related questions
if ($purpose["gaming"] -eq $true) 
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
        $choice = $host.ui.PromptForChoice('Gaming Apps', "Should $item be installed?", $appChoices, (0))

        if ($choice -eq 0)
        {
            $appsToInstall += @($GamingApps[$item])
        }
    }
}

# Check if Chocolatey is installed, otherwise install it
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

# Compose a string of apps that were selected to be installed
ForEach ($App in $appsToInstall)
{
    $appString += $App + ' '
}

# INSTALL!
choco install -y $appString