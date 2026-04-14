$content = Get-Content viewer.html -Raw

# 1. Re-enable Three Dots and Add Menu
# Find the div containing the icon
$iconSearch = '<div style="position: relative;">\s*<i class="fas fa-ellipsis-v"[^>]*></i>\s*</div>'
# Note: I'm not sure if the inner html matches exactly due to attributes I might have removed
# Let's search for the icon tag specifically.

$content = $content -replace '<i class="fas fa-ellipsis-v"[^>]*></i>', '<i class="fas fa-ellipsis-v" onclick="toggleUserMenu()" style="color: var(--text-main); font-size: 1.2rem; cursor: pointer; opacity: 0.8; padding: 10px;"></i>
                
                <!-- User Menu (Logout) -->
                <div id="user-menu" class="glass-panel" style="position: absolute; top: 45px; right: 10px; width: 140px; padding: 8px; z-index: 2000; display: none; border-radius: 12px; box-shadow: 0 5px 20px rgba(0,0,0,0.5); border: 1px solid var(--glass-border);">
                    <div onclick="logoutUser()" class="menu-item-div" style="display: flex; align-items: center; gap: 10px; padding: 10px; cursor: pointer; color: #ff5252; transition: all 0.2s; border-radius: 8px;">
                        <i class="fas fa-sign-out-alt"></i>
                        <span style="font-weight: 600; font-size: 0.9rem;">Log Out</span>
                    </div>
                </div>'

# 2. Add JavaScript functions
# We'll add them to the script block in the head, where we added others.
$jsFunctions = @'
        // Toggle User Menu (Three Dots)
        window.toggleUserMenu = function() {
            const menu = document.getElementById('user-menu');
            if (menu) {
                menu.style.display = (menu.style.display === 'none' || menu.style.display === '') ? 'block' : 'none';
            }
        }

        // Logout Function
        window.logoutUser = function() {
            if(confirm('Are you sure you want to log out?')) {
                // Clear session if needed
                localStorage.removeItem('userLoggedIn'); 
                // Redirect to login page
                window.location.href = 'index.html';
            }
        }
'@

# Insert after existing toggleHamburgerMenu
$content = $content -replace '(window\.toggleHamburgerMenu = function\(\) \{)', ($jsFunctions + "`n`n        " + '$1')

Set-Content viewer.html -Value $content
Write-Host "Added Log Out option to three dots menu!"
