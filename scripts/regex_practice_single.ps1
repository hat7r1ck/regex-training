# PowerShell Script to Generate Regex Practice File from User Input

# Prompt the user for their first and last name
$firstName = Read-Host "Enter your first name"
$lastName = Read-Host "Enter your last name"

# Normalize input: remove extra spaces and convert to lowercase
$firstName = ($firstName.Trim()).ToLower()
$lastName = ($lastName.Trim()).ToLower()
$initials = "$($firstName.Substring(0,1))$($lastName.Substring(0,1))"

# Define output file location in Downloads folder
$downloadsPath = [Environment]::GetFolderPath('UserProfile') + '\Downloads'
$filePath = Join-Path $downloadsPath "RegexPractice.txt"

# Generate name variations for regex practice
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

# Add the Base64-encoded answer at the end of the file
$variations += "`nAnswer (Base64 Encoded): $encodedAnswer"

# Write the variations to the text file
$variations | Set-Content -Path $filePath

Write-Output "Regex practice file created at: $filePath"
