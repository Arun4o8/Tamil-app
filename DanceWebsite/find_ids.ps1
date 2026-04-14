$content = Get-Content viewer.html
$content | Select-String 'id=".*?(gender|support|settings).*?"'
