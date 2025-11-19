function Export-Gpo
{
    param (
        [Parameter(mandatory=$true)][string]$Path
    )

    if ( -Not (Test-Path -Path $Path))
    {
        New-Item -ItemType Directory -Path $Path
    }

    foreach ($gpo in Get-Gpo -All)
    {
        New-Item -ItemType Directory -Name $gpo.DisplayName -Path $Path
        Backup-Gpo -Name $gpo.DisplayName -Path $(Join-Path -Path $Path -ChildPath $gpo.DisplayName)
    }
}