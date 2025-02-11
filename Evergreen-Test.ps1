# Trust PSGallery 

if (Get-PSRepository | Where-Object { $_.Name -eq "PSGallery" -and $_.InstallationPolicy -ne "Trusted" }) {
    Install-PackageProvider -Name "NuGet" -MinimumVersion 2.8.5.208 -Force
    Set-PSRepository -Name "PSGallery" -InstallationPolicy "Trusted"
}
write-host Test

# Install or Update Evergreen
$Installed = Get-Module -Name "Evergreen" -ListAvailable | `
    Sort-Object -Property @{ Expression = { [System.Version]$_.Version }; Descending = $true } | `
    Select-Object -First 1
$Published = Find-Module -Name "Evergreen"
if ($Null -eq $Installed) {
    Install-Module -Name "Evergreen"
}
elseif ([System.Version]$Published.Version -gt [System.Version]$Installed.Version) {
    Update-Module -Name "Evergreen"
}

# Import Module
Import-Module Evergreen


# Save specific Version
Get-EvergreenApp -Name MicrosoftOneDrive | Where-Object { $_.Ring -eq "Enterprise" -and $_.Architecture -eq "x64" -and $_.Type -eq "exe" } | Save-EvergreenApp -Path "C:\Apps\OneDrive"

# install onedrive
Start-Process -filepath "C:\Apps\OneDrive\Enterprise\24.180.0905.0002\x64\OneDriveSetup.exe" -ArgumentList "/allusers"


