$content = Get-Content viewer.html
$exploreHeader = $content | Select-String 'id="view-explore"' -Context 0,10
$savedHeader = $content | Select-String 'id="view-saved"' -Context 0,10
$rulesHeader = $content | Select-String 'id="view-rules"' -Context 0,10

Write-Host "--- EXPLORE ---"
$exploreHeader | ForEach-Object { $_.Line; $_.Context.PostContext }
Write-Host "--- SAVED ---"
$savedHeader | ForEach-Object { $_.Line; $_.Context.PostContext }
Write-Host "--- RULES ---"
$rulesHeader | ForEach-Object { $_.Line; $_.Context.PostContext }
