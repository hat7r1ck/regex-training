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
    "$firstName$lastName" + "123",
    "$firstName$lastName" + "5678",
    "$firstName$lastName" + "42",
    "$firstName$lastName" + "9"
)

$variations = @(
    "$firstName $lastName",
    "$lastName, $firstName",
    "$firstName.$lastName",
    "$firstName$lastName",
    "$initials",
    "$firstName-$lastName",
    "$lastName$firstName"
)

# Combine all variations into a single array
$allVariations = $variations + $randomNumbers

# Create the answer regex and encode it in Base64
$answerRegex = "($firstName[ .,-]?$lastName|$lastName[ ,]?$firstName|$initials|$lastName$firstName|$firstName$lastName\d{1,4})"
$encodedAnswer = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($answerRegex))

# Add encoded answer to the variations array
$allVariations += "`nAnswer (Base64 Encoded): $encodedAnswer"

# Write variations to the file, ensuring each entry is on a new line
$allVariations | ForEach-Object { Add-Content -Path $outputFile -Value $_ }

Write-Output "Practice file created at: $outputFile"
