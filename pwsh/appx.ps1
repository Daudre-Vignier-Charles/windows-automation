function Remove-AppxProvisionedPackages
{
    param (
        [string[]] $Packages
    )

    foreach ($PackageName in $Packages)
    {
        foreach ($Package in Get-AppxProvisionedPackages -Online)
        {
            if ($Package.DisplayName -eq $PackageName)
            {
                Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $Package.PackageName
            }
        }
    }
}

