$winget_args = @(
    "install" 
    "--id=`"Adobe.Acrobat.Reader.64-bit`""
    "-e"
    "--silent"
    "--disable-interactivity"
    "--accept-source-agreements"
    "--accept-package-agreements"
)

Out-File -FilePath C:\winget.log -Append "Starting winget"

$wingetfolder = (Get-AppxPackage -Name Microsoft.DesktopAppInstaller).InstallLocation

if ($wingetfolder)
{
    Get-Item -Path "C:\Program Files\WindowsApps\"
    Start-Process -FilePath "$($winget)" -ArgumentList $winget_args -RedirectStandardError "C:\winget.err" -RedirectStandardOutput "C:\winget.out"
}
else
{
    Out-File -FilePath C:\winget.log -Append "ERROR: Winget not found !"
}