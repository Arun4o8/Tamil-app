$content = Get-Content viewer.html -Raw

# Add toggleSidebarContent function
$toggleFunction = @'

        // Toggle Sidebar Content Sections
        window.toggleSidebarContent = function(section) {
            const contentDiv = document.getElementById('sidebar-' + section);
            const allSections = ['about', 'language', 'gender', 'support', 'settings'];
            
            // Close all other sections
            allSections.forEach(s => {
                if (s !== section) {
                    const div = document.getElementById('sidebar-' + s);
                    if (div) div.style.display = 'none';
                }
            });
            
            // Toggle current section
            if (contentDiv) {
                contentDiv.style.display = contentDiv.style.display === 'none' ? 'block' : 'none';
            }
        }
'@

$insertBefore = '        // Toggle Left Sidebar'
$content = $content -replace [regex]::Escape($insertBefore), ($toggleFunction + "`r`n" + $insertBefore)

Set-Content viewer.html -Value $content
Write-Host "Toggle function added!"
