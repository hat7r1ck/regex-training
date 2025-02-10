# PowerShell Script to Generate Regex Practice File from User Input

# Prompt user for first and last name
$firstName = Read-Host "Enter your first name"
$lastName = Read-Host "Enter your last name"

# Convert names to lowercase and strip spaces
$firstName = $firstName.Trim().ToLower()
$lastName = $lastName.Trim().ToLower()

# Define the output file path
$downloadsPath = [Environment]::GetFolderPath('UserProfile') + '\Downloads'
$outputFile = "$downloadsPath\RegexPractice.txt"

# Create variations of the name (first name, last name, initials, etc.)
$initials = if ($lastName) { "$($firstName.Substring(0,1))$($lastName.Substring(0,1))" } else { "$($firstName.Substring(0,1))" }

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

# Write variations to the file, ensuring proper line breaks
$allVariations | Set-Content -Path $outputFile -Encoding UTF8

# Create the answer regex and encode it in Base64 (no extra spaces)
$answerRegex = "($firstName[ .,-]?$lastName|$lastName[ ,]?$firstName|$initials|$lastName$firstName|$firstName$lastName\d{1,4})"
$encodedAnswer = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($answerRegex))

# Add the Base64 encoded answer on a **new line**
Add-Content -Path $outputFile -Value "`nAnswer (Base64 Encoded): $encodedAnswer"

Write-Output "Practice file created at: $outputFile"
