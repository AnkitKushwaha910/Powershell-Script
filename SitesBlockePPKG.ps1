# Path to the hosts file
$hostsFilePath = "C:\Windows\System32\drivers\etc\hosts"

# List of websites to block
$websitesToBlock = @(
    "www.google.com",
    "google.com",
    "www.bing.com",
    "bing.com",
    "www.yahoo.com",
    "yahoo.com",
    "stackoverflow.com",
    "serverfault.com",
    "superuser.com",
    "askubuntu.com",
    "github.com",
    "gitlab.com",
    "medium.com",
    "dev.to",
    "chat.openai.com",
    "chatgpt.openai.com",
    "learn.microsoft.com",
    "developer.mozilla.org",
    "quora.com"
    "www.geeksforgeeks.org"
    "geeksforgeeks.org"
    "https://www.javatpoint.com"
    "docs.oracle.com"
    "www.tutorialspoint.com"
)

# Function to block websites
function Block-Websites {
    # Read the current contents of the hosts file
    $currentHostsContent = Get-Content -Path $hostsFilePath -ErrorAction Stop

    foreach ($site in $websitesToBlock) {
        # Prepare the entry for the hosts file
        $entry = "127.0.0.1 $site"

        # Check if the entry already exists
        if ($currentHostsContent -notcontains $entry) {
            Add-Content -Path $hostsFilePath -Value $entry
        }
    }
}

# Function to reload DNS cache
function Reload-DNSCache {
    try {
        ipconfig /flushdns | Out-Null
    } catch {
        # Log failure, if any
    }
}

# Main execution
try {
    Block-Websites
    Reload-DNSCache
} catch {
    # Log errors, if any
}
