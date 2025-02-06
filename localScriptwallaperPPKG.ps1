# Create Registry Key for PersonalizationCSP
New-Item -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP -Force | Out-Null

# Variables
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
$ImageDestinationFolder = "C:\intune"
$BackgroundFile = "background.jpg"
$LockscreenFile = "lockscreen.jpg"
$BackgroundImage = "$ImageDestinationFolder\$BackgroundFile"
$LockScreenImage = "$ImageDestinationFolder\$LockscreenFile"

# Background Wallpaper Registry Keys
New-ItemProperty -Path $RegPath -Name DesktopImagePath -Value $BackgroundImage -PropertyType String -Force | Out-Null
New-ItemProperty -Path $RegPath -Name DesktopImageUrl -Value $BackgroundImage -PropertyType String -Force | Out-Null
New-ItemProperty -Path $RegPath -Name DesktopImageStatus -Value 1 -PropertyType DWORD -Force | Out-Null

# Lock Screen Wallpaper Registry Keys
New-ItemProperty -Path $RegPath -Name LockScreenImagePath -Value $LockScreenImage -PropertyType String -Force | Out-Null
New-ItemProperty -Path $RegPath -Name LockScreenImageUrl -Value $LockScreenImage -PropertyType String -Force | Out-Null
New-ItemProperty -Path $RegPath -Name LockScreenImageStatus -Value 1 -PropertyType DWORD -Force | Out-Null
