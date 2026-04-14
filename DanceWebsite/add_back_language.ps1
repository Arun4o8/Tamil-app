$content = Get-Content viewer.html -Raw

# Helper to transform simple H3 title to grouped header with back button
function Add-BackBtn($html, $searchStr, $titleEndStr) {
    # Extract ID from search string if possible or assume structure
    # We will replace the H3 with the flex container
    
    # Try match the whole h3 line
    # Regex look for: <h3 id="ID" style="...">content</h3>
    
    $regex = '(<h3 id="[^"]+" style="[^"]+">)(.*?)(</h3>)'
    # We need to target specific sections
    
    return $html
}

# 3. Update Language Header
# Search: <h3 id="lang-title" style="margin-bottom: 20px; color: var(--primary);">
$langPattern = '<h3 id="lang-title"[^>]*>(.*?)</h3>'
$langMatch = [regex]::Match($content, $langPattern)
if ($langMatch.Success) {
    $fullTag = $langMatch.Value
    $titleText = $langMatch.Groups[1].Value
    # Extract the ID and Style parts to preserve them if needed, but we essentially want to wrap it
    # Easier to just replace the whole tag with our new structure
    
    $replacement = '<div style="display: flex; align-items: center; gap: 15px; margin-bottom: 20px;">
                <button onclick="switchView(' + "'home'" + ')" style="background: none; border: none; color: var(--text-main); font-size: 1.2rem; cursor: pointer; padding: 0;"><i class="fas fa-arrow-left"></i></button>
                <h3 id="lang-title" style="margin: 0; color: var(--primary); font-size: 1.5rem;">' + $titleText + '</h3>
            </div>'
            
    $content = $content -replace [regex]::Escape($fullTag), $replacement
}

# 

Set-Content viewer.html -Value $content
Write-Host "Updated Language view header"
