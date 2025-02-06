# Helper function to set registry values
function Set-RegistryValue {
  param (
      [string]$Path,
      [string]$Name,
      [object]$Value,
      [string]$Type = "String" # Default to String, use "DWORD" for numeric values
  )
  
  # Create registry key if it doesn't exist
  if (-not (Test-Path $Path)) {
      New-Item -Path $Path -Force | Out-Null
  }
  
  # Set the registry value
  Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -Force
}

# Managed Bookmarks JSON for Google Chrome
$chromeBookmarksJson = @'
[
{
  "toplevel_name": "Developer Resources"
},
{
  "name": "DuckDuckGo",
  "url": "https://www.duckduckgo.com"
},
{
  "name": "Online Java Compiler",
  "url": "https://www.online-java.com/"
},
{
  "name": "Programiz Compiler",
  "url": "https://www.programiz.com/java-programming/online-compiler/"
},
{
  "name": "OnlineGDB Compiler",
  "url": "https://www.onlinegdb.com/online_java_compiler"
},
{
  "name": "JDoodle Compiler",
  "url": "https://www.jdoodle.com/online-java-compiler"
},
{
  "name": "OneCompiler",
  "url": "https://onecompiler.com/java"
},
{
  "name": "CodeChef Compiler",
  "url": "https://www.codechef.com/java-online-compiler"
}
]
'@

# Set managed bookmarks for Google Chrome
$chromePath = "HKCU:\SOFTWARE\Policies\Google\Chrome"
Set-RegistryValue -Path $chromePath -Name "ManagedBookmarks" -Value $chromeBookmarksJson
Set-RegistryValue -Path $chromePath -Name "HomepageLocation" -Value "https://www.online-java.com/"
Set-RegistryValue -Path $chromePath -Name "HomepageIsNewTabPage" -Value 0 -Type "DWORD"

# Managed Favorites JSON for Microsoft Edge
$edgeBookmarksJson = @'
[
{
  "toplevel_name": "Developer Resources"
},
{
  "name": "DuckDuckGo",
  "url": "https://www.duckduckgo.com"
},
{
  "name": "Online Java Compiler",
  "url": "https://www.online-java.com/"
},
{
  "name": "Programiz Compiler",
  "url": "https://www.programiz.com/java-programming/online-compiler/"
},
{
  "name": "OnlineGDB Compiler",
  "url": "https://www.onlinegdb.com/online_java_compiler"
},
{
  "name": "JDoodle Compiler",
  "url": "https://www.jdoodle.com/online-java-compiler"
},
{
  "name": "OneCompiler",
  "url": "https://onecompiler.com/java"
},
{
  "name": "CodeChef Compiler",
  "url": "https://www.codechef.com/java-online-compiler"
}
]
'@

# Set managed favorites for Microsoft Edge
$edgePath = "HKCU:\SOFTWARE\Policies\Microsoft\Edge"
Set-RegistryValue -Path $edgePath -Name "ManagedFavorites" -Value $edgeBookmarksJson
Set-RegistryValue -Path $edgePath -Name "HomepageLocation" -Value "https://www.online-java.com/"
Set-RegistryValue -Path $edgePath -Name "HomepageIsNewTabPage" -Value 0 -Type "DWORD"
