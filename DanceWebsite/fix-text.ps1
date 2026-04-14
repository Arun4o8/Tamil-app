$content = Get-Content viewer.html -Raw

# Fix corrupted text in language menu
$content = $content -replace 'dY.*?English', '🇬🇧 English'
$content = $content -replace 'dY.*?Tamil.*', '🇮🇳 தமிழ்</div>'
# The Tamil line might match too much, let's be more specific or aggressive if needed
# The pattern seen was: dYrdY3 r rrrr'_?</div> (approx)

Set-Content viewer.html -Value $content
Write-Host "Fixed text encoding artifacts!"
