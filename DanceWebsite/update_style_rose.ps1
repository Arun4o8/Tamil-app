$content = Get-Content style.css -Raw

# Replace Primary Color Definitions
$content = $content -replace '#ff5722', '#E91E63' # Primary
$content = $content -replace '#e64a19', '#C2185B' # Primary Dark
$content = $content -replace '#ff9100', '#FF4081' # Accent Orange -> Pink Accent

Set-Content style.css -Value $content
Write-Host "Updated style.css to Rose theme!"
