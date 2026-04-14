$content = Get-Content viewer.html -Raw

# Search for the profile image with the specific attributes
$profileSearch = '<img src="profile.png".*?onclick="switchView\(' + "'profile'" + '\)">'

# We can match roughly and replace
$pattern = '(<img src="profile.png"[^>]+?)(cursor: pointer; )([^>]+?)(onclick="switchView\(' + "'profile'" + '\)")'

# Wait, regex is hard with multiple lines and attributes order.
# I will use a direct replace of the specific style and onclick if I can match the block.

# Let's match the specific text string from the file content we just read
$targetString = 'style="width: 55px; height: 55px; border-radius: 50%; object-fit: cover; border: 3px solid var(--primary); cursor: pointer; margin-right: 15px;"
                onclick="switchView(''profile'')">'

$replaceString = 'style="width: 55px; height: 55px; border-radius: 50%; object-fit: cover; border: 3px solid var(--primary); margin-right: 15px;">'

# Note: PowerShell string literals for newlines might mismatch if not careful.
# I'll try to execute a replace that matches loosely on the onclick part.

$content = $content -replace 'onclick="switchView\(''profile''\)"', ''
$content = $content -replace 'cursor: pointer; margin-right: 15px;"', 'margin-right: 15px;"'

Set-Content viewer.html -Value $content
Write-Host "Disabled profile picture click in header!"
