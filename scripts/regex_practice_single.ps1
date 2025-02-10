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

# Add number variations for practicing quantifiers
$randomNumbers = @(
    "$firstName$lastName123",
    "$firstName$lastName5678",
    "$firstName$lastName42",
    "$firstName$lastName9"
)

# Create the full list of variations
$variations = @(
    "$firstName $lastName",
    "$lastName, $firstName",
    "$firstName.$lastName",
    "$firstName$lastName",
    "$initials",
    "$firstName-$lastName",
    "$lastName$firstName"
)

# Combine variations with random numbers
$allVariations = $variations + $randomNumbers

# Write all variations to the output file, ensuring each is on its own line.
$allVariations | Out-File -FilePath $outputFile -Encoding UTF8

# Create the answer regex.
$answerRegex = "($firstName[ .,-]?$lastName|$lastName[ ,]?$firstName|$initials|$lastName$firstName|$firstName$lastName\d{1,4})"

# Encode the answer regex in Base64.
$encodedAnswer = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($answerRegex))

# Append the Base64 encoded answer on a new line (using Windows line breaks)
Add-Content -Path $outputFile -Value "`r`nAnswer (Base64 Encoded): $encodedAnswer"

Write-Output "Practice file created at: $outputFile"
