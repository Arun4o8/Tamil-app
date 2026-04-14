$content = Get-Content viewer.html
$profile = $content | Select-String 'id="view-profile"' -Context 0,50
$profile | ForEach-Object { $_.Line; $_.Context.PostContext }
