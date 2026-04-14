$content = Get-Content viewer.html -Raw

# Search for the user menu definition
# <div id="user-menu" class="glass-panel" style="position: absolute; top: 45px; right: 10px; width: 140px; padding: 8px; z-index: 2000; display: none; border-radius: 12px; box-shadow: 0 5px 20px rgba(0,0,0,0.5); border: 1px solid var(--glass-border);">

# We will replace 'position: absolute; top: 45px; right: 10px;' with 'position: fixed; top: 90px; right: 25px;'
# Using regex to update the style attribute
$pattern = '(<div id="user-menu"[^>]*style=")([^"]*)(")'

$content = $content -replace 'style="position: absolute; top: 45px; right: 10px;', 'style="position: fixed; top: 90px; right: 25px;'

Set-Content viewer.html -Value $content
Write-Host "Updated user menu positioning to fixed!"
