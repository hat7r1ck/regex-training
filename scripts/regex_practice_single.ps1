# PowerShell Script to Generate a Regex Practice File from User Input

# Prompt for user's first and last name
$firstName = Read-Host "Enter your first name"
$lastName = Read-Host "Enter your last name"

# Convert to lowercase and remove extra spaces
$firstName = $firstName.Trim().ToLower()
$lastName = $lastName.Trim().ToLower()

# Define output folder and file location
$downloadsPath = [Environment]::GetFolderPath('UserProfile') + '\Downloads'
$outputFolder = "$downloadsPath\RegexPractice"
$outputFile = "$outputFolder\RegexPractice.txt"

# Create output directory if it doesn't exist
if (!(Test-Path -Path $outputFolder)) {
    New-Item -ItemType Directory -Path $outputFolder
}

# Create variations of the name (first name, last name, initials, etc.)
$initials = "$($firstName.Substring(0,1))$($lastName.Substring(0,1))"

# Add number variations for practicing quantifiers
$randomNumbers = @(
    "$firstName$lastName123",
    "$firstName$lastName5678",
    "$firstName$lastName42",
    "$firstName$lastName9"
)

$variations = @(
    "$firstName $lastName",
    "$lastName, $firstName",
    "$firstName.$lastName",
    "$firstName$lastName",
    "$initials",
    "$firstName-$lastName",
    "$lastName$firstName"
) + $randomNumbers

# Create the answer regex and encode it in Base64
$answerRegex = "($firstName[ .,-]?$lastName|$lastName[ ,]?$firstName|$initials|$lastName$firstName|$firstName$lastName\d{1,4})"
$encodedAnswer = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($answerRegex))

# Add encoded answer to the file
$variations += "`nAnswer (Base64 Encoded): $encodedAnswer"

# Write variations to the file
$variations | Set-Content -Path $outputFile

Write-Output "Regex practice file created at: $outputFile"
