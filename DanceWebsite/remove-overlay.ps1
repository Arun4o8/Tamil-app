$content = Get-Content viewer.html -Raw
$content = $content -replace '<div id="sidebar-overlay".*?</div>', ''
Set-Content viewer.html -Value $content
Write-Host "Removed sidebar overlay!"
