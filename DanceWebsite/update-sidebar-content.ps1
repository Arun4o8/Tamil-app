$content = Get-Content viewer.html -Raw

# Replace the sidebar HTML with expandable content version
$oldSidebar = @'
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
'@

$newSidebar = @'
        <!-- Left Sidebar Menu -->
        <div id="left-sidebar" style="position: fixed; top: 0; left: -300px; width: 300px; height: 100%; background: rgba(20, 20, 20, 0.98); backdrop-filter: blur(20px); z-index: 3000; transition: left 0.3s ease; box-shadow: 2px 0 20px rgba(0,0,0,0.5); border-right: 1px solid var(--primary); overflow-y: auto;">
            <div style="padding: 20px;">
                <!-- Close Button -->
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
                    <h3 style="color: var(--primary); margin: 0; font-size: 1.4rem;">Menu</h3>
                    <i class="fas fa-times" onclick="toggleSidebar()" style="color: var(--text-main); font-size: 1.5rem; cursor: pointer; padding: 10px;"></i>
                </div>
                
                <!-- Menu Items -->
                <div onclick="toggleSidebarContent('about')" class="sidebar-item" style="padding: 15px; border-radius: 10px; cursor: pointer; display: flex; align-items: center; gap: 15px; margin-bottom: 10px; transition: all 0.3s;">
                    <i class="fas fa-info-circle" style="color: var(--primary); width: 25px; font-size: 1.2rem;"></i>
                    <span class="menu-label" style="color: var(--text-main); font-size: 1rem; font-weight: 600;">About Us</span>
                </div>
                <div id="sidebar-about" style="display: none; padding: 15px; background: rgba(255,255,255,0.05); border-radius: 8px; margin-bottom: 15px;">
                    <p style="color: var(--text-muted); font-size: 0.85rem; line-height: 1.5; margin: 0;">AR/XR Tamil Culture - Immersive Heritage Learning Platform by E16 AI Pvt Limited</p>
                    <button onclick="switchView('about'); toggleSidebar()" style="margin-top: 10px; padding: 8px 15px; background: var(--primary); color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 0.8rem;">View Full Details</button>
                </div>
                
                <div onclick="toggleSidebarContent('language')" class="sidebar-item" style="padding: 15px; border-radius: 10px; cursor: pointer; display: flex; align-items: center; gap: 15px; margin-bottom: 10px; transition: all 0.3s;">
                    <i class="fas fa-language" style="color: var(--secondary); width: 25px; font-size: 1.2rem;"></i>
                    <span class="menu-label" style="color: var(--text-main); font-size: 1rem; font-weight: 600;">Language</span>
                </div>
                <div id="sidebar-language" style="display: none; padding: 15px; background: rgba(255,255,255,0.05); border-radius: 8px; margin-bottom: 15px;">
                    <div onclick="changeLanguage('en'); toggleSidebar()" style="padding: 10px; background: rgba(255,255,255,0.1); border-radius: 6px; margin-bottom: 8px; cursor: pointer; color: var(--text-main);">🇬🇧 English</div>
                    <div onclick="changeLanguage('ta'); toggleSidebar()" style="padding: 10px; background: rgba(255,255,255,0.1); border-radius: 6px; cursor: pointer; color: var(--text-main);">🇮🇳 தமிழ்</div>
                </div>
                
                <div onclick="toggleSidebarContent('gender')" class="sidebar-item" style="padding: 15px; border-radius: 10px; cursor: pointer; display: flex; align-items: center; gap: 15px; margin-bottom: 10px; transition: all 0.3s;">
                    <i class="fas fa-venus-mars" style="color: #e91e63; width: 25px; font-size: 1.2rem;"></i>
                    <span class="menu-label" style="color: var(--text-main); font-size: 1rem; font-weight: 600;">Gender</span>
                </div>
                <div id="sidebar-gender" style="display: none; padding: 15px; background: rgba(255,255,255,0.05); border-radius: 8px; margin-bottom: 15px;">
                    <p style="color: var(--text-muted); font-size: 0.85rem; margin-bottom: 10px;">Avatar Preference:</p>
                    <button onclick="switchView('gender'); toggleSidebar()" style="padding: 8px 15px; background: var(--primary); color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 0.8rem; width: 100%;">Change Gender Settings</button>
                </div>
                
                <div onclick="toggleSidebarContent('support')" class="sidebar-item" style="padding: 15px; border-radius: 10px; cursor: pointer; display: flex; align-items: center; gap: 15px; margin-bottom: 10px; transition: all 0.3s;">
                    <i class="fas fa-headset" style="color: #4caf50; width: 25px; font-size: 1.2rem;"></i>
                    <span class="menu-label" style="color: var(--text-main); font-size: 1rem; font-weight: 600;">Support</span>
                </div>
                <div id="sidebar-support" style="display: none; padding: 15px; background: rgba(255,255,255,0.05); border-radius: 8px; margin-bottom: 15px;">
                    <p style="color: var(--text-muted); font-size: 0.85rem; line-height: 1.5; margin: 0;">Need help? Contact our support team or view FAQs.</p>
                    <button onclick="switchView('support'); toggleSidebar()" style="margin-top: 10px; padding: 8px 15px; background: var(--primary); color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 0.8rem; width: 100%;">View Support</button>
                </div>
                
                <div onclick="toggleSidebarContent('settings')" class="sidebar-item" style="padding: 15px; border-radius: 10px; cursor: pointer; display: flex; align-items: center; gap: 15px; margin-bottom: 10px; transition: all 0.3s;">
                    <i class="fas fa-cog" style="color: #9c27b0; width: 25px; font-size: 1.2rem;"></i>
                    <span class="menu-label" style="color: var(--text-main); font-size: 1rem; font-weight: 600;">Settings</span>
                </div>
                <div id="sidebar-settings" style="display: none; padding: 15px; background: rgba(255,255,255,0.05); border-radius: 8px; margin-bottom: 15px;">
                    <p style="color: var(--text-muted); font-size: 0.85rem; margin-bottom: 10px;">App Settings</p>
                    <button onclick="switchView('settings'); toggleSidebar()" style="padding: 8px 15px; background: var(--primary); color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 0.8rem; width: 100%;">Open Settings</button>
                </div>
            </div>
        </div>
'@

$content = $content -replace [regex]::Escape($oldSidebar), $newSidebar

Set-Content viewer.html -Value $content
Write-Host "Sidebar updated with expandable content!"
