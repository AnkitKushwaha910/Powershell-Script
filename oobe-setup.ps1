# prepare provisioning folder
$provisioning = ni "$($env:ProgramData)\provisioning" -ItemType Directory -Force

# move files from provisioning package to provisioning folder
gci -File | ? { $_.Name -notlike "oobe_*" } | % {
    cp $_.FullName "$($provisioning.FullName)\$($_.Name)" -Force
}

# Execute oobe scripts

. .\oobe-bloatware.ps1
. .\oobe-machine-registry.ps1
. .\oobe-user-registry.ps1

# Create local admin account

$local_user = @{
    Name                 = 'Monocept'
    NoPassword           = $true
}

$user = New-LocalUser @local_user 
$user | Set-LocalUser -PasswordNeverExpires $true 
$user | Add-LocalGroupMember -Group "Administrators"

# Skip privacy experiance

$settings =
[PSCustomObject]@{
    Path  = "SOFTWARE\Policies\Microsoft\Windows\OOBE"
    Name  = "DisablePrivacyExperience"
    Value = 1
} | group Path

foreach ($setting in $settings) {
    $registry = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($setting.Name, $true)
    if ($null -eq $registry) {
        $registry = [Microsoft.Win32.Registry]::LocalMachine.CreateSubKey($setting.Name, $true)
    }
    $setting.Group | % {
        $registry.SetValue($_.name, $_.value)
    }
    $registry.Dispose()
}

# Configure power settings
# Disable sleep, hibernate and monitor standby on AC
"powercfg /x -monitor-timeout-ac 0",
"powercfg /x -standby-timeout-ac 0",
"powercfg /x -hibernate-timeout-ac 0" | % {
    cmd /c $_
}
