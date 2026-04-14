$content = Get-Content viewer.html -Raw

# Replace hardcoded Orange hex codes with Rose
$content = $content -replace '#ff9100', '#FF4081' 
$content = $content -replace '#ff5722', '#E91E63' 

# Also replace the text "Vivid Orange Text" comment if present to avoid confusion
$content = $content -replace 'Vivid Orange Text', 'Vivid Rose Text'

Set-Content viewer.html -Value $content
Write-Host "Updated viewer.html to Rose theme!"
