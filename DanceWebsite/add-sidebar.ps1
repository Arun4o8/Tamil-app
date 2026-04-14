$content = Get-Content viewer.html -Raw

# Add sidebar HTML after the header-menu div
$sidebarHTML = @'

        <!-- Left Sidebar Menu -->
        <div id="left-sidebar" style="position: fixed; top: 0; left: -300px; width: 300px; height: 100%; background: rgba(20, 20, 20, 0.98); backdrop-filter: blur(20px); z-index: 3000; transition: left 0.3s ease; box-shadow: 2px 0 20px rgba(0,0,0,0.5); border-right: 1px solid var(--primary);">
            <div style="padding: 20px;">
                <!-- Close Button -->
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
                    <h3 style="color: var(--primary); margin: 0; font-size: 1.4rem;">Menu</h3>
                    <i class="fas fa-times" onclick="toggleSidebar()" style="color: var(--text-main); font-size: 1.5rem; cursor: pointer; padding: 10px;"></i>
                </div>
                
                <!-- Menu Items -->
                <div onclick="switchView('about'); toggleSidebar()" class="sidebar-item" style="padding: 15px; border-radius: 10px; cursor: pointer; display: flex; align-items: center; gap: 15px; margin-bottom: 10px; transition: all 0.3s;">
                    <i class="fas fa-info-circle" style="color: var(--primary); width: 25px; font-size: 1.2rem;"></i>
                    <span class="menu-label" style="color: var(--text-main); font-size: 1rem; font-weight: 600;">About Us</span>
                </div>
                
                <div onclick="switchView('language'); toggleSidebar()" class="sidebar-item" style="padding: 15px; border-radius: 10px; cursor: pointer; display: flex; align-items: center; gap: 15px; margin-bottom: 10px; transition: all 0.3s;">
                    <i class="fas fa-language" style="color: var(--secondary); width: 25px; font-size: 1.2rem;"></i>
                    <span class="menu-label" style="color: var(--text-main); font-size: 1rem; font-weight: 600;">Language</span>
                </div>
                
                <div onclick="switchView('gender'); toggleSidebar()" class="sidebar-item" style="padding: 15px; border-radius: 10px; cursor: pointer; display: flex; align-items: center; gap: 15px; margin-bottom: 10px; transition: all 0.3s;">
                    <i class="fas fa-venus-mars" style="color: #e91e63; width: 25px; font-size: 1.2rem;"></i>
                    <span class="menu-label" style="color: var(--text-main); font-size: 1rem; font-weight: 600;">Gender</span>
                </div>
                
                <div onclick="switchView('support'); toggleSidebar()" class="sidebar-item" style="padding: 15px; border-radius: 10px; cursor: pointer; display: flex; align-items: center; gap: 15px; margin-bottom: 10px; transition: all 0.3s;">
                    <i class="fas fa-headset" style="color: #4caf50; width: 25px; font-size: 1.2rem;"></i>
                    <span class="menu-label" style="color: var(--text-main); font-size: 1rem; font-weight: 600;">Support</span>
                </div>
                
                <div onclick="switchView('settings'); toggleSidebar()" class="sidebar-item" style="padding: 15px; border-radius: 10px; cursor: pointer; display: flex; align-items: center; gap: 15px; margin-bottom: 10px; transition: all 0.3s;">
                    <i class="fas fa-cog" style="color: #9c27b0; width: 25px; font-size: 1.2rem;"></i>
                    <span class="menu-label" style="color: var(--text-main); font-size: 1rem; font-weight: 600;">Settings</span>
                </div>
            </div>
        </div>

        <!-- Sidebar Overlay -->
        <div id="sidebar-overlay" onclick="toggleSidebar()" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.7); z-index: 2999; display: none;"></div>
'@

$insertAfter = '</div>
        </div>

        <!-- Dropdown Menu -->'
$content = $content -replace [regex]::Escape($insertAfter), ($insertAfter + $sidebarHTML)

Set-Content viewer.html -Value $content
Write-Host "Sidebar HTML added!"
