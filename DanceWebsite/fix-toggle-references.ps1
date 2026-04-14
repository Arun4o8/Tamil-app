$content = Get-Content viewer.html -Raw
$content = $content -replace 'onclick="toggleSidebar\(\)"', 'onclick="toggleHamburgerMenu()"'
Set-Content viewer.html -Value $content
Write-Host "Fixed toggleSidebar references!"
