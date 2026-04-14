$content = Get-Content viewer.html -Raw

# Search for the profile nav item without onclick (or with empty/broken one)
# <div id="nav-profile" class="nav-item" >
$navSearch = '<div id="nav-profile" class="nav-item" >'
$navReplace = '<div id="nav-profile" class="nav-item" onclick="switchView(' + "'profile'" + ')">'

$content = $content -replace [regex]::Escape($navSearch), $navReplace

Set-Content viewer.html -Value $content
Write-Host "Enabled Profile click in bottom navigation!"
