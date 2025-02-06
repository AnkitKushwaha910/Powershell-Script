# Create Directory
New-Item -Path "C:\BgInfo" -ItemType "directory" -Force

# Copy files into the BgInfo folder on the destination devices
Copy-Item Bginfo64.exe -Destination "C:\BgInfo" -Force
Copy-Item TestingBGInfo.bgi -Destination "C:\BgInfo" -Force
    
$WshShell = New-Object -comObject WScript.Shell
$strCommonStartup = $WshShell.SpecialFolders("AllUsersStartup")
$Shortcut = $WshShell.CreateShortcut($strCommonStartup + "\BgInfo.lnk")
$Shortcut.TargetPath = "C:\BgInfo\Bginfo64.exe"
$Shortcut.Arguments = "C:\BgInfo\TestingBGInfo.bgi /SILENT /TIMER:0 /NOLICPROMPT"
$Shortcut.Save()

# Return optional a status code if installation was successfully
# Determine if BgInfo is successfully installed
$BgInfoIsInstalled = Test-Path -Path "C:\BgInfo\Bginfo64.exe"

if($BgInfoIsInstalled)
{
    Write-Output "BgInfo successfully installed"
    exit 0
}
else
{
    Write-Output "Some issues occurred when installing BgInfo"
    exit 1
}
