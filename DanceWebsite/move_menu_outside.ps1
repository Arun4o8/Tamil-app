$content = Get-Content viewer.html -Raw

# 1. Extract the user menu HTML
# It looks like:
# <div id="user-menu" ...>
#    ...
# </div>
# It is currently inside the header.

# Regex to capture the div
$menuPattern = '(?s)<div id="user-menu".*?</div>\s*</div>' 
# Note: The menu is inside a container div <div style="position: relative;">...</div> inside header?
# Let's check the structure again from previous inspect output:
# <div style="position: relative;">
#    <i class="fas fa-ellipsis-v" ...></i>
#    <div id="user-menu" ...>...</div>
# </div>

# We want to remove the MENU DIV from inside that container, and place it AFTER the header.

# Step 1: Remove menu from current location
$menuHTML = '<div id="user-menu" class="glass-panel" style="position: fixed; top: 90px; right: 25px; width: 140px; padding: 8px; z-index: 2500; display: none; border-radius: 12px; box-shadow: 0 5px 20px rgba(0,0,0,0.5); border: 1px solid var(--glass-border);">
            <div onclick="logoutUser()" class="menu-item-div" style="display: flex; align-items: center; gap: 10px; padding: 10px; cursor: pointer; color: #ff5252; transition: all 0.2s; border-radius: 8px;">
                <i class="fas fa-sign-out-alt"></i>
                <span style="font-weight: 600; font-size: 0.9rem;">Log Out</span>
            </div>
        </div>'

# Regex to find and remove the existing menu div
$content = $content -replace '(?s)<div id="user-menu".*?Log Out</span>\s*</div>\s*</div>', ''

# Step 2: Insert it after the header
# Header ends with </div>.
# We can insert it before "<!-- Hamburger Dropdown Menu -->" which is right after header usually.
$insertMarker = '<!-- Hamburger Dropdown Menu -->'
$content = $content -replace [regex]::Escape($insertMarker), ($menuHTML + "`n`n        " + $insertMarker)

Set-Content viewer.html -Value $content
Write-Host "Moved user menu outside of header to fix visibility!"
