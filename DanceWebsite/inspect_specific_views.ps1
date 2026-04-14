$content = Get-Content viewer.html
$matches = $content | Select-String 'id="view-(gender|support|settings|rules)"' -Context 0,5
foreach ($match in $matches) {
    Write-Host "View: $($match.Line)"
    $match.Context.PostContext
    Write-Host "---"
}
