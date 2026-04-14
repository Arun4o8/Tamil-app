$content = Get-Content viewer.html
$menu = $content | Select-String 'id="user-menu"' -Context 5,20
$menu | ForEach-Object { $_.Context.PreContext; $_.Line; $_.Context.PostContext }
