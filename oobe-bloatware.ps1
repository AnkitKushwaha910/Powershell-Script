# Remove Windows store apps

$app_packages = 
#"Microsoft.WindowsCamera",
"Clipchamp.Clipchamp",
"Microsoft.WindowsAlarms",
"Microsoft.549981C3F5F10", # Cortana
"Microsoft.WindowsFeedbackHub",
"microsoft.windowscommunicationsapps",
"Microsoft.WindowsMaps",
"Microsoft.ZuneMusic",
"Microsoft.BingNews",
"Microsoft.Todos",
"Microsoft.ZuneVideo",
"Microsoft.MicrosoftOfficeHub",
"Microsoft.OutlookForWindows",
"Microsoft.People",
"Microsoft.PowerAutomateDesktop",
"MicrosoftCorporationII.QuickAssist",
"Microsoft.ScreenSketch",
"Microsoft.MicrosoftSolitaireCollection",
"Microsoft.BingWeather",
"Microsoft.Xbox.TCUI",
"Microsoft.GamingApp",
"Microsoft.WindowsAlarms",
"Microsoft.GetHelp",
"Microsoft.Getstarted",
"Microsoft.NetworkSpeedTest",
"Microsoft.News",
"Microsoft.Office.Lens",
"Microsoft.Office.OneNote",
"Microsoft.Office.Sway",
"Microsoft.OneConnect",
"Microsoft.SkypeApp",
"Microsoft.StorePurchaseApp",
"Microsoft.WindowsAlarms",
"Microsoft.Xbox.TCUI",
"Microsoft.XboxApp",
"Microsoft.XboxGameOverlay",
"Microsoft.XboxIdentityProvider",
"Microsoft.XboxSpeechToTextOverlay",
"Microsoft.XboxGamingOverlay",
"Microsoft.Windows.Ai.Copilot.Provider"

Get-AppxProvisionedPackage -Online | ?{$_.DisplayName -in $app_packages} | Remove-AppxProvisionedPackage -Online -AllUser


# Prevent OneDrive from installing

ni "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\DisableOneDrive" | New-ItemProperty -Name "StubPath" -Value 'REG DELETE "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDriveSetup /f'

# Prevent Outlook (new) and Dev Home from installing

"HKLM:\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\DevHomeUpdate",
"HKLM:\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\OutlookUpdate",
"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\UScheduler\OutlookUpdate",
"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\UScheduler\DevHomeUpdate" | %{
    ri $_ -force
}