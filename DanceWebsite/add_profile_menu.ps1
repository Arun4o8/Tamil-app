$content = Get-Content viewer.html -Raw

$profileMenuHTML = @'
            <!-- My Profile -->
            <div onclick="switchView('profile'); toggleHamburgerMenu()" class="menu-item-div" style="padding: 15px; border-radius: 10px; cursor: pointer; display: flex; align-items: center; gap: 12px; margin-bottom: 8px; transition: all 0.3s;">
                <i class="fas fa-user-circle" style="color: #ff9100; width: 20px;"></i>
                <span class="menu-label" style="flex: 1; font-weight: 600;">My Profile</span>
            </div>
'@

# Insert at the beginning of the hamburger menu content
# Find the About Us item and insert before it
# About Us starts with <!-- About Us -->
$insertBefore = '<!-- About Us -->'
$content = $content -replace [regex]::Escape($insertBefore), ($profileMenuHTML + "`n" + $insertBefore)

Set-Content viewer.html -Value $content
Write-Host "Added My Profile to hamburger menu!"
