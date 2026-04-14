$content = Get-Content viewer.html
$views = $content | Select-String 'id="view-'
$views
