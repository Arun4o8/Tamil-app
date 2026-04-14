$content = Get-Content viewer.html
$viewLines = $content | Select-String 'id="view-' -Context 0,15

foreach ($match in $viewLines) {
    Write-Host "View Found: $($match.Line)"
    foreach ($line in $match.Context.PostContext) {
        Write-Host $line
    }
    Write-Host "----------------------------------------"
}
