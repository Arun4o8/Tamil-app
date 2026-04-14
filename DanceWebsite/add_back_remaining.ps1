$content = Get-Content viewer.html -Raw


$exploreSearch = '<div id="explore-tabs" class="category-tabs">'
$exploreReplace = '<div style="display: flex; align-items: center; gap: 15px; margin-bottom: 20px;">
                <button onclick="switchView(' + "'home'" + ')" style="background: none; border: none; color: var(--text-main); font-size: 1.2rem; cursor: pointer; padding: 0;"><i class="fas fa-arrow-left"></i></button>
                <h3 id="explore-title" style="margin: 0; color: var(--primary); font-size: 1.5rem;">Explore</h3>
            </div>
            <div id="explore-tabs" class="category-tabs">'
            
$content = $content -replace [regex]::Escape($exploreSearch), $exploreReplace# 2. Update Saved Header
# Currently: <div id="view-saved" class="view-section">\s*<div id="saved-list-container">
$savedSearch = '<div id="saved-list-container">'
$savedReplace = '<div style="display: flex; align-items: center; gap: 15px; margin-bottom: 20px;">
                <button onclick="switchView(' + "'home'" + ')" style="background: none; border: none; color: var(--text-main); font-size: 1.2rem; cursor: pointer; padding: 0;"><i class="fas fa-arrow-left"></i></button>
                <h3 id="saved-title" style="margin: 0; color: var(--primary); font-size: 1.5rem;">Saved Items</h3>
            </div>
            <div id="saved-list-container">'

$content = $content -replace [regex]::Escape($savedSearch), $savedReplace

# 3. Update Rules Header
# Same pattern as About/Language
$rulesSearchPattern = '<h3 id="rules-title"[^>]*>(.*?)</h3>'
# We'll use regex replace to capture title
$rulesMatch = [regex]::Match($content, $rulesSearchPattern)
if ($rulesMatch.Success) {
    $fullTag = $rulesMatch.Value
    $titleText = $rulesMatch.Groups[1].Value
    
    $replacement = '<div style="display: flex; align-items: center; gap: 15px; margin-bottom: 20px;">
                <button onclick="switchView(' + "'home'" + ')" style="background: none; border: none; color: var(--text-main); font-size: 1.2rem; cursor: pointer; padding: 0;"><i class="fas fa-arrow-left"></i></button>
                <h3 id="rules-title" style="margin: 0; color: var(--primary); font-size: 1.5rem;">' + $titleText + '</h3>
            </div>'
            
    $content = $content -replace [regex]::Escape($fullTag), $replacement
}

Set-Content viewer.html -Value $content
Write-Host "Updated Explore, Saved, and Rules headers!"
