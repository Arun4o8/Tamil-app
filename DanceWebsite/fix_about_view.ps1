$path = "c:\Users\DEEPAK\Desktop\DanceWebsite\viewer.html"
$content = Get-Content $path -Raw -Encoding UTF8

# Remove the broken line 1163 - the orphaned fragment
$content = $content -replace '\s+style="margin-bottom: 20px; color: var\(--primary\); font-size: 1\.5rem; margin: 0;">About Us</h3>\r?\n\s+</div>', "`r`n            </div>"

$content | Set-Content -Path $path -Encoding UTF8 -NoNewline
Write-Host "Fixed broken HTML fragment in About Us view"
