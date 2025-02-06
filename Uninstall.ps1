# Remove Directory along with Files
Remove-Item -LiteralPath "C:\BgInfo" -Force -Recurse

# Determine Shortcut (symbolic link) path using Windows Script Host (WSH)
$WshShell = New-Object -comObject WScript.Shell
$strCommonStartup = $WshShell.SpecialFolders("AllUsersStartup")
$strShortcut = $strCommonStartup + "\BgInfo.lnk"

# Remove Shortcut using PowerShell's Remove-Item cmdlet
Remove-Item -Path $strShortcut -Force

# Return optional a status code if uninstalling was successful
# Determine if BgInfo is still installed
$BgInfoIsInstalled = Test-Path -Path "C:\BgInfo\Bginfo64.exe"

if ($BgInfoIsInstalled) {
    Write-Output "BgInfo not successfully uninstalled"
    exit 1
} else {
    Write-Output "BgInfo successfully uninstalled"
    exit 0
}
