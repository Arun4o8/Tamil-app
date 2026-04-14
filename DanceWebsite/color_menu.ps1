$content = Get-Content viewer.html -Raw

# Search for the user menu definition
# We want to change the background style in the inline style attribute
$pattern = '(<div id="user-menu"[^>]*style=")([^"]*)(")'

# We prefer to target the style string specifically if we can match it
# Current style starts with: positions, etc. 
# We'll just replace the whole tag to be sure we insert the background correctly.

# Regex matching the whole opening tag
$tagRegex = '<div id="user-menu" class="glass-panel" style="([^"]*)">'

# We will replace it with the new style.
# Existing style roughly: position: absolute; ...
# We'll re-construct it but add background: #1a1a1a;
$newStyle = 'position: absolute; top: 80px; right: 25px; width: 140px; padding: 8px; z-index: 2500; display: none; border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.8); border: 1px solid var(--primary); background: #222222;'

$content = $content -replace '<div id="user-menu" class="glass-panel" style="[^"]*">', "<div id=`"user-menu`" class=`"glass-panel`" style=`"$newStyle`">"

Set-Content viewer.html -Value $content
Write-Host "Updated user menu background color!"
