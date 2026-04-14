$path = "c:\Users\DEEPAK\Desktop\DanceWebsite\viewer.html"
$content = Get-Content $path -Raw -Encoding UTF8

# Remove the premature closing </div> at line 1162 that's closing view-about too early
# This appears right after the h3 closing tag and before the Project Title comment
$pattern = '(\s+<h3 id="about-page-title"[^>]+>About Us</h3>\r?\n)\s+</div>\r?\n(\s+<!-- Project Title -->)'
$replacement = '$1$2'

$content = $content -replace $pattern, $replacement

$content | Set-Content -Path $path -Encoding UTF8 -NoNewline
Write-Host "Removed premature closing div from About Us view"
