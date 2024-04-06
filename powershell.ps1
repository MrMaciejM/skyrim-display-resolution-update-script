### Skyrim Display Parameters Update PowerShell script
### Written by Maciej Matulewicz

# Write your desired screen resolution values
$newValue1 = "iSize H=1000"  
$newValue2 = "iSize W=2000" 

# Update this path to where YOUR SkyrimPrefs.ini file is located 
$TSVDataPath = "C:\Users\Maciej\Documents\My Games\Skyrim\SkyrimPrefs.ini"

################################
# Start of the script

$timestamp = Get-Date -Format "HH:mm:ss"

# Closes Skyrim if it is running
stop-process -name "tesv" -force -ErrorAction SilentlyContinue

# Parameters to set Skyrim to Windowed Mode
$windowedMode = "bFull Screen=\d+"
$setWindowedMode = "bFull Screen=0"

# Prevents immediate write error while Skyrim is closing (assuming it was running)
Start-Sleep -Seconds 1.5

# Gets file content
$fileContent = Get-Content -Path $TSVDataPath

# Finds height and width using regular expression
$pattern1 = "iSize H=\d+"
$pattern2 = "iSize W=\d+"

# Loop through each line and replace the values
# $_ = think of this as a placeholder for each item that PS performs operations on. 

$iterationCount = $fileContent.Count
$currentIteration = 0

$newContent = $fileContent | ForEach-Object {
    $currentIteration++
    

    if ($_ -match $pattern1) {
        $_ -replace $pattern1, $newValue1
    }
    elseif ($_ -match $pattern2) {
        $_ -replace $pattern2, $newValue2
    }
    else {
        $_ -replace $windowedMode, $setWindowedMode
    }
    if ($currentIteration -eq $iterationCount) {
        Write-Host "Updated file at $timestamp" -ForegroundColor Green
    }
}

# Save the updated content back to the file
Set-Content -Path $TSVDataPath -Value $newContent

