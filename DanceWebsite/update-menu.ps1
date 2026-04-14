$content = Get-Content viewer.html -Raw

# 1. Remove onclick from three dots
$content = $content -replace '<i class="fas fa-ellipsis-v" onclick="toggleHeaderMenu\(\)"', '<i class="fas fa-ellipsis-v"'

# 2. Change hamburger menu to open sidebar instead
$content = $content -replace 'onclick="toggleHeaderMenu\(\)" style="cursor: pointer; padding: 10px; margin-right: 10px;"', 'onclick="toggleSidebar()" style="cursor: pointer; padding: 10px; margin-right: 10px;"'

Set-Content viewer.html -Value $content
Write-Host "Updated menu functionality!"
