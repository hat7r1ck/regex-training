# PowerShell Script to Generate Regex Practice File from User Input

# Prompt user for first and last name
$firstName = Read-Host "Enter your first name"
$lastName = Read-Host "Enter your last name"

# Convert names to lowercase and trim any extra spaces
$firstName = $firstName.Trim().ToLower()
$lastName = $lastName.Trim().ToLower()

# Define the output file path (using the Downloads folder)
$downloadsPath = Join-Path ([Environment]::GetFolderPath('UserProfile')) "Downloads"
$outputFile = Join-Path $downloadsPath "RegexPractice.txt"

# Create variations of the name (first name, last name, initials, etc.)
if ($lastName) {
    $initials = "$($firstName.Substring(0,1))$($lastName.Substring(0,1))"
} else {
    $initials = "$($firstName.Substring(0,1))"
}

# Basic variations
$variations = @(
    "$firstName $lastName",
    "$lastName, $firstName",
    "$firstName.$lastName",
    "$firstName$lastName",
    "$initials",
    "$firstName-$lastName",
    "$lastName$firstName"
)

# Number variations (for practicing quantifiers)
$numberVariations = @(
    "$firstName$lastName123",
    "$firstName$lastName5678",
    "$firstName$lastName42",
    "$firstName$lastName9"
)

# Combine all variations into one array
$allVariations = $variations + $numberVariations

# Clear (or create) the output file
Set-Content -Path $outputFile -Value "" -Encoding UTF8

# Write each variation to the file on its own line
foreach ($line in $allVariations) {
    Add-Content -Path $outputFile -Value $line -Encoding UTF8
}

# Create the answer regex.
$answerRegex = "($firstName[ .,-]?$lastName|$lastName[ ,]?$firstName|$initials|$lastName$firstName|$firstName$lastName\d{1,4})"

# Encode the answer regex in Base64
$encodedAnswer = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($answerRegex))

# Append a blank line and then the answer line
Add-Content -Path $outputFile -Value "" -Encoding UTF8
Add-Content -Path $outputFile -Value "Answer (Base64 Encoded): $encodedAnswer" -Encoding UTF8

Write-Output "Practice file created at: $outputFile"

# Append the Base64 encoded answer on a new line (using Windows line breaks)
Add-Content -Path $outputFile -Value "`r`nAnswer (Base64 Encoded): $encodedAnswer"

Write-Output "Practice file created at: $outputFile"
