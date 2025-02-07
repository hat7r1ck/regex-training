# PowerShell Script to Generate Regex Practice Files from Teams Attendance Report

# Prompt the user to select the CSV file or automatically search Downloads folder
$downloadsPath = [Environment]::GetFolderPath('UserProfile') + '\\Downloads'
$csvFile = Get-ChildItem -Path $downloadsPath -Filter '*Attendance*.csv' | Sort-Object LastWriteTime -Descending | Select-Object -First 1

if (-not $csvFile) {
    $csvFile = Read-Host "Attendance report not found in Downloads. Please enter the full path to the CSV file"
} else {
    Write-Output "Using the attendance report found: $($csvFile.FullName)"
}

# Define output folder and zip file location
$outputFolder = "$downloadsPath\\RegexPractice"
$zipFile = "$downloadsPath\\RegexPractice.zip"

# Create output directory if it doesn't exist
if (!(Test-Path -Path $outputFolder)) {
    New-Item -ItemType Directory -Path $outputFolder
}

# Read CSV and extract names (assuming "Full Name" is the header in the CSV)
$names = Import-Csv -Path $csvFile.FullName | Select-Object -ExpandProperty 'Full Name'

# For each name, create a text file with variations
foreach ($name in $names) {
    $filePath = Join-Path $outputFolder "$($name).txt"
    
    # Create variations of the name (first name, last name, initials, etc.)
    $nameParts = $name -split '\\s+'
    $firstName = $nameParts[0]
    $lastName = if ($nameParts.Count -gt 1) { $nameParts[1] } else { "" }
    $initials = "$($firstName.Substring(0,1))$($lastName.Substring(0,1))"
    
    # Add number variations for practicing quantifiers
    $randomNumbers = @(
        "$firstName$lastName123",
        "$firstName$lastName5678",
        "$firstName$lastName42",
        "$firstName$lastName9"
    )

    $variations = @(
        "$name",
        "$firstName $lastName",
        "$lastName, $firstName",
        "$firstName.$lastName",
        "$firstName$lastName",
        "$initials",
        "$firstName-$lastName",
        "$lastName$firstName"
    ) + $randomNumbers

    # Create the answer regex and encode it in Base64
    $answerRegex = "($firstName[ .,-]?$lastName|$lastName[ ,]?$firstName|$initials|$lastName$firstName|$firstName$lastName\\d{1,4})"
    $encodedAnswer = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($answerRegex))

    # Add encoded answer to the file
    $variations += "`nAnswer (Base64 Encoded): $encodedAnswer"

    # Write variations to the file
    $variations | Set-Content -Path $filePath
}

# Compress all the text files into a zip
Compress-Archive -Path "$outputFolder\\*" -DestinationPath $zipFile -Force

Write-Output "Zip file created at: $zipFile"
