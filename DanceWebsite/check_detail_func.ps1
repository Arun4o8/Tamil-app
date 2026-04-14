$content = Get-Content viewer.html
$func = $content | Select-String 'function showCultureDetail' -Context 0,50
$func | ForEach-Object { $_.Context.PostContext }
