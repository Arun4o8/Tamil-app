$content = Get-Content viewer.html -Raw

# Define the start and end markers of the broken code block
# We want to remove everything from "// Toggle Left Sidebar" up to (but not including) "window.toggleHeaderMenu"
# This covers the broken sidebar remnants and the duplicate hamburger functions

$startMarker = '// Toggle Left Sidebar'
$endMarker = 'window.toggleHeaderMenu = () => {'

# Use regex with Singleline option (?s) to match across newlines
# We escape special characters in the markers just in case
$pattern = '(?s)' + [regex]::Escape($startMarker) + '.*?' + [regex]::Escape($endMarker)

# Replace with just the end marker (effectively deleting the block but keeping the next function)
# Or better, replace with just an empty string and we ensure we don't eat the end marker?
# Let's match UP TO the end marker lookahead or just include it in the replace string

# My regex approach: Match "Start...End" and replace with "End"
# Use a capture group for clarity? No, just simple string replacement

$content = $content -replace $pattern, $endMarker

Set-Content viewer.html -Value $content
Write-Host "Fixed broken JavaScript syntax!"
