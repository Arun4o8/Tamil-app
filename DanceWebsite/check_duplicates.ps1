$content = Get-Content viewer.html
$matches = $content | Select-String 'id="user-menu"' -Context 2,2
foreach ($m in $matches) {
    Write-Host "Match at line $($m.LineNumber):"
    $m.Context.PreContext
    $m.Line
    $m.Context.PostContext
    Write-Host "---"
}
