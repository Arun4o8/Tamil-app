$content = Get-Content viewer.html -Raw

# Find the script tag location and add our functions right after it starts
$scriptToAdd = @'
<script>
        // Toggle Hamburger Menu - Defined early to avoid reference errors
        window.toggleHamburgerMenu = function() {
            console.log('toggleHamburgerMenu called');
            const menu = document.getElementById('hamburger-menu');
            if (!menu) {
                console.error('hamburger-menu not found');
                return;
            }
            
            if (menu.style.display === 'none' || menu.style.display === '') {
                menu.style.display = 'block';
                console.log('Menu opened');
            } else {
                menu.style.display = 'none';
                console.log('Menu closed');
            }
        }

        // Toggle Menu Content Sections
        window.toggleMenuContent = function(section) {
            const contentDiv = document.getElementById('menu-' + section);
            const arrow = document.getElementById('arrow-' + section);
            const allSections = ['about', 'language', 'gender', 'support', 'settings'];
            
            // Close all other sections
            allSections.forEach(s => {
                if (s !== section) {
                    const div = document.getElementById('menu-' + s);
                    const arr = document.getElementById('arrow-' + s);
                    if (div) div.style.display = 'none';
                    if (arr) arr.style.transform = 'rotate(0deg)';
                }
            });
            
            // Toggle current section
            if (contentDiv) {
                const isOpen = contentDiv.style.display === 'block';
                contentDiv.style.display = isOpen ? 'none' : 'block';
                if (arrow) arrow.style.transform = isOpen ? 'rotate(0deg)' : 'rotate(180deg)';
            }
        }
    </script>
'@

# Insert right after <head>
$content = $content -replace '(<head>)', ('$1' + "`r`n" + $scriptToAdd)

Set-Content viewer.html -Value $content
Write-Host "Added functions to head section!"
