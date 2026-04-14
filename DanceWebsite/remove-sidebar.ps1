$content = Get-Content viewer.html -Raw

# Remove the left sidebar
$content = $content -replace '(?s)<!-- Left Sidebar Menu -->.*?<!-- Sidebar Overlay -->', ''

# Remove sidebar overlay
$content = $content -replace '(?s)<!-- Sidebar Overlay -->.*?</div>\s*<!-- Dropdown Menu -->', '<!-- Dropdown Menu -->'

Set-Content viewer.html -Value $content
Write-Host "Removed left sidebar!"
