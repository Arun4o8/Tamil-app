$content = Get-Content viewer.html -Raw

# 1. Update About View Header
$aboutSearch = '<h3 id="about-page-title"'
$aboutReplace = '<div style="display: flex; align-items: center; gap: 15px; margin-bottom: 20px;">
                <button onclick="switchView(' + "'home'" + ')" style="background: none; border: none; color: var(--text-main); font-size: 1.2rem; cursor: pointer; padding: 0;"><i class="fas fa-arrow-left"></i></button>
                <h3 id="about-page-title"'
$content = $content -replace [regex]::Escape($aboutSearch), $aboutReplace

# Remove text-align: center from about title style if present to align left with arrow
$content = $content -replace 'text-align: center; font-size: 1.8rem;">About Us</h3>', 'font-size: 1.5rem; margin: 0;">About Us</h3></div>'

Set-Content viewer.html -Value $content
Write-Host "Updated About view header"
