$path = "c:\Users\DEEPAK\Desktop\DanceWebsite\viewer.html"
$content = Get-Content $path -Raw -Encoding UTF8

# Update inline style to use !important
$content = $content -replace '<div id="view-about" class="view-section" style="display: none;">', '<div id="view-about" class="view-section" style="display: none !important;">'

$content | Set-Content -Path $path -Encoding UTF8 -NoNewline
Write-Host "Added !important to view-about display:none"
