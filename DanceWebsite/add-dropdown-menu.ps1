$content = Get-Content viewer.html -Raw

# Add dropdown menu HTML after the header
$dropdownHTML = @'

        <!-- Hamburger Dropdown Menu -->
        <div id="hamburger-menu" class="glass-panel" style="position: absolute; top: 120px; left: 20px; right: 20px; z-index: 2000; display: none; padding: 15px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.5);">
            <!-- About Us -->
            <div onclick="toggleMenuContent('about')" class="menu-item-div" style="padding: 15px; border-radius: 10px; cursor: pointer; display: flex; align-items: center; gap: 12px; margin-bottom: 8px; transition: all 0.3s;">
                <i class="fas fa-info-circle" style="color: var(--primary); width: 20px;"></i>
                <span class="menu-label" style="flex: 1; font-weight: 600;">About Us</span>
                <i class="fas fa-chevron-down" id="arrow-about" style="font-size: 0.8rem; transition: transform 0.3s;"></i>
            </div>
            <div id="menu-about" style="display: none; padding: 12px 15px 12px 47px; background: rgba(255,255,255,0.05); border-radius: 8px; margin-bottom: 10px;">
                <p style="font-size: 0.85rem; color: var(--text-muted); margin: 0 0 10px 0;">AR/XR Tamil Culture Platform</p>
                <button onclick="switchView('about'); toggleHamburgerMenu()" style="padding: 8px 15px; background: var(--primary); color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 0.8rem; width: 100%;">View Details</button>
            </div>

            <!-- Language -->
            <div onclick="toggleMenuContent('language')" class="menu-item-div" style="padding: 15px; border-radius: 10px; cursor: pointer; display: flex; align-items: center; gap: 12px; margin-bottom: 8px; transition: all 0.3s;">
                <i class="fas fa-language" style="color: var(--secondary); width: 20px;"></i>
                <span class="menu-label" style="flex: 1; font-weight: 600;">Language</span>
                <i class="fas fa-chevron-down" id="arrow-language" style="font-size: 0.8rem; transition: transform 0.3s;"></i>
            </div>
            <div id="menu-language" style="display: none; padding: 12px 15px 12px 47px; background: rgba(255,255,255,0.05); border-radius: 8px; margin-bottom: 10px;">
                <div onclick="changeLanguage('en'); toggleHamburgerMenu()" style="padding: 10px; background: rgba(255,255,255,0.1); border-radius: 6px; margin-bottom: 8px; cursor: pointer;">🇬🇧 English</div>
                <div onclick="changeLanguage('ta'); toggleHamburgerMenu()" style="padding: 10px; background: rgba(255,255,255,0.1); border-radius: 6px; cursor: pointer;">🇮🇳 தமிழ்</div>
            </div>

            <!-- Gender -->
            <div onclick="toggleMenuContent('gender')" class="menu-item-div" style="padding: 15px; border-radius: 10px; cursor: pointer; display: flex; align-items: center; gap: 12px; margin-bottom: 8px; transition: all 0.3s;">
                <i class="fas fa-venus-mars" style="color: #e91e63; width: 20px;"></i>
                <span class="menu-label" style="flex: 1; font-weight: 600;">Gender</span>
                <i class="fas fa-chevron-down" id="arrow-gender" style="font-size: 0.8rem; transition: transform 0.3s;"></i>
            </div>
            <div id="menu-gender" style="display: none; padding: 12px 15px 12px 47px; background: rgba(255,255,255,0.05); border-radius: 8px; margin-bottom: 10px;">
                <p style="font-size: 0.85rem; color: var(--text-muted); margin: 0 0 10px 0;">Avatar Preference</p>
                <button onclick="switchView('gender'); toggleHamburgerMenu()" style="padding: 8px 15px; background: var(--primary); color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 0.8rem; width: 100%;">Change Settings</button>
            </div>

            <!-- Support -->
            <div onclick="toggleMenuContent('support')" class="menu-item-div" style="padding: 15px; border-radius: 10px; cursor: pointer; display: flex; align-items: center; gap: 12px; margin-bottom: 8px; transition: all 0.3s;">
                <i class="fas fa-headset" style="color: #4caf50; width: 20px;"></i>
                <span class="menu-label" style="flex: 1; font-weight: 600;">Support</span>
                <i class="fas fa-chevron-down" id="arrow-support" style="font-size: 0.8rem; transition: transform 0.3s;"></i>
            </div>
            <div id="menu-support" style="display: none; padding: 12px 15px 12px 47px; background: rgba(255,255,255,0.05); border-radius: 8px; margin-bottom: 10px;">
                <p style="font-size: 0.85rem; color: var(--text-muted); margin: 0 0 10px 0;">Need help? Contact support</p>
                <button onclick="switchView('support'); toggleHamburgerMenu()" style="padding: 8px 15px; background: var(--primary); color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 0.8rem; width: 100%;">View Support</button>
            </div>

            <!-- Settings -->
            <div onclick="toggleMenuContent('settings')" class="menu-item-div" style="padding: 15px; border-radius: 10px; cursor: pointer; display: flex; align-items: center; gap: 12px; margin-bottom: 8px; transition: all 0.3s;">
                <i class="fas fa-cog" style="color: #9c27b0; width: 20px;"></i>
                <span class="menu-label" style="flex: 1; font-weight: 600;">Settings</span>
                <i class="fas fa-chevron-down" id="arrow-settings" style="font-size: 0.8rem; transition: transform 0.3s;"></i>
            </div>
            <div id="menu-settings" style="display: none; padding: 12px 15px 12px 47px; background: rgba(255,255,255,0.05); border-radius: 8px; margin-bottom: 10px;">
                <p style="font-size: 0.85rem; color: var(--text-muted); margin: 0 0 10px 0;">App Settings</p>
                <button onclick="switchView('settings'); toggleHamburgerMenu()" style="padding: 8px 15px; background: var(--primary); color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 0.8rem; width: 100%;">Open Settings</button>
            </div>
        </div>
'@

$insertAfter = '</div>

        <!-- Dropdown Menu -->'
$content = $content -replace [regex]::Escape($insertAfter), ($insertAfter + $dropdownHTML)

Set-Content viewer.html -Value $content
Write-Host "Added hamburger dropdown menu!"
