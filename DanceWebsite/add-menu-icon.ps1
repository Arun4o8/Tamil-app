$content = Get-Content viewer.html -Raw
$search = '        <div class="app-header">'
$replace = @'
        <div class="app-header">
            <!-- Menu Icon -->
            <div onclick="toggleHeaderMenu()" style="cursor: pointer; padding: 10px; margin-right: 10px;">
                <i class="fas fa-bars" style="color: var(--text-main); font-size: 1.3rem; opacity: 0.9;"></i>
            </div>
'@
$content = $content -replace [regex]::Escape($search), $replace
Set-Content viewer.html -Value $content
Write-Host "Menu icon added successfully!"
