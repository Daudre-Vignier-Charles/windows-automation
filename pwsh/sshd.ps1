New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force

# %programdata%\ssh\sshd_config => config file

function Set-OpenSSHServerDefaultShell
{
    param (
        [string]$DefaultShell
    )
    if ($string)
    {
        if ($string -eq "powershell")
        {
            New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name "DefaultShell" -Value "C:\Windows\System32\cmd.exe" -PropertyType "String" -Force $true
        }
        elseif ($string -eq "cmd")
        {
            New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name "DefaultShell" -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType "String" -Force $true
        }
        else
        {
            Write-Host "ERROR: Invalid argument for -DefaultShell parameter, allowed values are `"powershell`" or `"cmd`""
        }
    }
}

function Install-OpenSSHServer
{
    Add-WindowsCapability -Online -Name (Get-WindowsCapability -Online -Name "OpenSSH.Server*").Name
    Start-Service sshd
    Set-Service -Name "sshd" -StartupType "Automatic"
    Start-Service "ssh-agent"
    Set-Service -Name "ssh-agent" -StartupType "Automatic"

    # Check firewall rule
    if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue)) {
        Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
        New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
    } else {
        Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
    }
}