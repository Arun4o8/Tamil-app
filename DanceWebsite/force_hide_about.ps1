$path = "c:\Users\DEEPAK\Desktop\DanceWebsite\viewer.html"
$content = Get-Content $path -Raw -Encoding UTF8

# Add inline display:none to view-about to force it hidden
$content = $content -replace '<div id="view-about" class="view-section">', '<div id="view-about" class="view-section" style="display: none;">'

$content | Set-Content -Path $path -Encoding UTF8 -NoNewline
Write-Host "Added inline style to force view-about hidden"
