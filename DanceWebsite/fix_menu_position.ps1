$content = Get-Content viewer.html -Raw

# Search for the user menu definition with fixed position
$pattern = 'style="position: fixed; top: 90px; right: 25px;'
$replacement = 'style="position: absolute; top: 80px; right: 25px;'

$content = $content -replace [regex]::Escape($pattern), $replacement

Set-Content viewer.html -Value $content
Write-Host "Updated user menu positioning to absolute relative to container!"
