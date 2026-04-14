$content = Get-Content viewer.html -Raw

# Replace sidebar functions with hamburger menu functions
$newFunctions = @'

        // Toggle Hamburger Menu
        window.toggleHamburgerMenu = function() {
            const menu = document.getElementById('hamburger-menu');
            if (!menu) return;
            
            if (menu.style.display === 'none' || menu.style.display === '') {
                menu.style.display = 'block';
            } else {
                menu.style.display = 'none';
            }
        }

        // Toggle Menu Content Sections
        window.toggleMenuContent = function(section) {
            const contentDiv = document.getElementById('menu-' + section);
            const arrow = document.getElementById('arrow-' + section);
            
            // Toggle current section
            if (contentDiv) {
                const isOpen = contentDiv.style.display === 'block';
                contentDiv.style.display = isOpen ? 'none' : 'block';
                if (arrow) arrow.style.transform = isOpen ? 'rotate(0deg)' : 'rotate(180deg)';
            }
        }
'@

# Remove old sidebar functions
$content = $content -replace '(?s)window\.toggleSidebarContent.*?}', ''
$content = $content -replace '(?s)window\.toggleSidebar.*?}', ''

# Add new functions before toggleHeaderMenu
$insertBefore = '        window.toggleHeaderMenu'
$content = $content -replace [regex]::Escape($insertBefore), ($newFunctions + "`r`n" + $insertBefore)

Set-Content viewer.html -Value $content
Write-Host "Updated JavaScript functions!"
