# Prompt for app name
$App = Read-Host "Enter the application name to search for"

# Find the app
$appObject = Get-WmiObject -Class Win32_Product |
Where-Object { $_.Name -like "*$App*" }

# Show result
$appObject | Select-Object Name, IdentifyingNumber | Format-List

# Uninstall if found
if ($appObject) {
    $guid = $appObject.IdentifyingNumber
    Write-Host "Uninstalling $($appObject.Name)..."

    Start-Process msiexec.exe `
        -ArgumentList "/x $guid /qn /norestart" `
        -Wait
}
else {
    Write-Host "Application not found."
}