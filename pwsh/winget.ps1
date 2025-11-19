function Install-WingetApps
{
    param (
        [string[]]$Applications
    )

    foreach ($Application in $Applications)
    {
        winget install --id="$($Application)" -e --silent --disable-interactivity --accept-source-agreements --accept-package-agreements
    }
}

function Remove-WingetApps
{
    param (
        [string[]]$Applications
    )

    foreach ($app in $Applications)
    {
        winget uninstall --id="$($app)" -e --silent --disable-interactivity --accept-source-agreements
    }
}

enum UpdatesInterval
{
    Daily
    BiDaily
    Weekly
    BiWeekly
    Monthly
    Never
}

enum NotificationLevel
{
    Full
    SuccessOnly
    ErrorsOnly
    None
}

function Configure-Winget
{
    param (
        [UpdatesInterval]$UpdatesInterval,
        [NotificationLevel]$NotificationLevel,
        [string]$InstallDir,
        [string]$UpdateTimeDelay,
        [string]$UpdatesAtTime,
        [nullable[bool]]$UpdatesAtLogon,
        [nullable[bool]]$UserContext,
        [nullable[bool]]$BypassListForUsers,
        [nullable[bool]]$DesktopShortcut,
        [nullable[bool]]$StartMenuShortcut,
        [nullable[bool]]$DoNotRunOnMetered,
        [Int32]$MaxLogFiles,
        [Int32]$MaxLogSize
    )
    function CreateOrUpdate
    {
        param (
            [string]$Name,
            [string]$PropertyType,
            [string]$Value
        )
        New-ItemProperty -Path "HKLM:\SOFTWARE\Romanitho\Winget-AutoUpdate" -Name $Name -PropertyType $PropertyType -Value $Value -Force $true
    }
    if 
}


function Setup-Winget
{
    winget update winget
    winget install --id="Romanitho.Winget-AutoUpdate" -e --silent --disable-interactivity --accept-source-agreements --accept-package-agreements
    New-ItemProperty -Path "HKLM:\SOFTWARE\Romanitho\Winget-AutoUpdate" -Name "WAU_UpdatesInterval" -PropertyType "String" -Value "BiDaily" -Force $true
    New-ItemProperty -Path "HKLM:\SOFTWARE\Romanitho\Winget-AutoUpdate" -Name "WAU_UpdatesAtTime" -PropertyType "String" -Value "11:00:00" -Force $true
}