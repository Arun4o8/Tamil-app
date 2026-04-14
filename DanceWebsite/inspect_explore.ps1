$content = Get-Content viewer.html
$explore = $content | Select-String 'id="view-explore"' -Context 0,30
$explore | ForEach-Object { $_.Line; $_.Context.PostContext }
