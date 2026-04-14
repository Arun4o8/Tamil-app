$content = Get-Content viewer.html -Raw

$practiceHTML = @'
            <!-- Practice Session -->
            <div onclick="toggleMenuContent('practice')" class="menu-item-div" style="padding: 15px; border-radius: 10px; cursor: pointer; display: flex; align-items: center; gap: 12px; margin-bottom: 8px; transition: all 0.3s;">
                <i class="fas fa-dumbbell" style="color: #ff9100; width: 20px;"></i>
                <span class="menu-label" style="flex: 1; font-weight: 600;">Practice Session</span>
                <i class="fas fa-chevron-down" id="arrow-practice" style="font-size: 0.8rem; transition: transform 0.3s;"></i>
            </div>
            <div id="menu-practice" style="display: none; padding: 12px 15px 12px 47px; background: rgba(255,255,255,0.05); border-radius: 8px; margin-bottom: 10px;">
                <p style="font-size: 0.85rem; color: var(--text-muted); margin: 0 0 10px 0;">Resume your training.</p>
                <button onclick="switchView('explore'); toggleHamburgerMenu()" style="padding: 8px 15px; background: var(--primary); color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 0.8rem; width: 100%;">Find a Class</button>
            </div>

'@

# Insert before Settings
$insertBefore = '<!-- Settings -->'
$content = $content -replace [regex]::Escape($insertBefore), ($practiceHTML + "`n" + $insertBefore)

# Also update the toggleMenuContent function to include 'practice' in the list of sections
# Search for: const allSections = ['about', 'language', 'gender', 'support', 'settings'];
$content = $content -replace "const allSections = \['about', 'language', 'gender', 'support', 'settings'\];", "const allSections = ['about', 'practice', 'language', 'gender', 'support', 'settings'];"

Set-Content viewer.html -Value $content
Write-Host "Added Practice Session to menu!"
