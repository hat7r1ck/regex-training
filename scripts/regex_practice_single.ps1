# PowerShell Script to Generate Regex Practice File from User Input

# Prompt user for first and last name
$firstName = Read-Host "Enter your first name"
$lastName = Read-Host "Enter your last name"

# Convert names to lowercase and trim extra spaces
$firstName = $firstName.Trim().ToLower()
$lastName = $lastName.Trim().ToLower()

# Define the output file path (using the Downloads folder)
$downloadsPath = Join-Path ([Environment]::GetFolderPath('UserProfile')) "Downloads"
$outputFile = Join-Path $downloadsPath "RegexPractice.txt"

# Generate initials using Substring (ensuring proper extraction)
if ($lastName) {
    $initials = "$($firstName.Substring(0,1))$($lastName.Substring(0,1))"
} else {
    $initials = "$($firstName.Substring(0,1))"
}

# Create an array of basic variations
$basicVariations = @(
    "$firstName $lastName",
    "$lastName, $firstName",
    "$firstName.$lastName",
    "$firstName$lastName",
    "$initials",
    "$firstName-$lastName",
    "$lastName$firstName"
)

# Create an array of number variations with proper variable expansion
$numberVariations = @(
    "$($firstName)$($lastName)123",
    "$($firstName)$($lastName)5678",
    "$($firstName)$($lastName)42",
    "$($firstName)$($lastName)9"
)

# Combine the variations
$allVariations = $basicVariations + $numberVariations

# Clear the output file (or create it if it doesn't exist)
Set-Content -Path $outputFile -Value "" -Encoding UTF8

# Write each variation to the file on its own line using a loop
foreach ($line in $allVariations) {
    Add-Content -Path $outputFile -Value $line -Encoding UTF8
}

# Build the answer regex.
# This regex matches one of the following patterns:
#   1. "$firstName" optionally followed by one of [ .,-] and then "$lastName"
#   2. "$lastName" optionally followed by one of [ ,] and then "$firstName"
#   3. The initials
#   4. "$lastName$firstName"
#   5. "$firstName$lastName" followed by 1 to 4 digits
$answerRegex = "($firstName[ .,-]?$lastName|$lastName[ ,]?$firstName|$initials|$lastName$firstName|$firstName$lastName\d{1,4})"

# Encode the answer regex in Base64
$encodedAnswer = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($answerRegex))

# Append a blank line and then the answer (Base64 Encoded) on a new line
Add-Content -Path $outputFile -Value "`r`nAnswer (Base64 Encoded): $encodedAnswer" -Encoding UTF8

Write-Output "Practice file created at: $outputFile"
