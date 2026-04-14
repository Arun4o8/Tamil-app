$content = Get-Content viewer.html -Raw

# 2. Update Profile View Header
$profileSearch = '<div id="view-profile" class="view-section">'
$profileReplace = '<div id="view-profile" class="view-section">
            <div style="display: flex; align-items: center; gap: 15px; margin-bottom: 20px;">
                <button onclick="switchView(' + "'home'" + ')" style="background: none; border: none; color: var(--text-main); font-size: 1.2rem; cursor: pointer; padding: 0;"><i class="fas fa-arrow-left"></i></button>
                <h3 style="margin: 0; color: var(--primary); font-size: 1.5rem;">Profile</h3>
            </div>'

$content = $content -replace [regex]::Escape($profileSearch), $profileReplace

Set-Content viewer.html -Value $content
Write-Host "Updated Profile view header"
