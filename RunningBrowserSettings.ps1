# Define the folder path where the files are stored
$folderPath = "C:\Files"

# Log file path to capture output
$logFile = "C:\Files\script_log.txt"

# Function to log progress
function Log-Message {
    param ($message)
    Add-Content -Path $logFile -Value "$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss')) - $message"
}

# Ensure log file is cleared before starting
Clear-Content -Path $logFile

# Log script start
Log-Message "Script started."

# Run EdgeChromeBookMarks.ps1 with bypassed execution policy
Log-Message "Running EdgeChromeBookMarks.ps1 script."
cmd.exe /c "powershell.exe -ExecutionPolicy Bypass -File $folderPath\EdgeChromeBookMarks.ps1 -WindowStyle Hidden"

# Check if the script ran successfully
Log-Message "Running chromeBrowsers.reg."
cmd.exe /c "regedit.exe /s $folderPath\chromeBrowsers.reg"

# Check if the registry changes applied
Log-Message "Running edgeMangedBookmarks.reg."
cmd.exe /c "regedit.exe /s $folderPath\edgeMangedBookmarks.reg"

# Log end of script
Log-Message "Script completed."
