$content = Get-Content viewer.html -Raw

# Replace the toggleSidebar function with a more robust version
$oldFunction = @'
        window.toggleSidebar = function() {
            const sidebar = document.getElementById('left-sidebar');
            const overlay = document.getElementById('sidebar-overlay');
            const isOpen = sidebar.style.left === '0px';
            
            if (isOpen) {
                sidebar.style.left = '-300px';
                overlay.style.display = 'none';
            } else {
                sidebar.style.left = '0px';
                overlay.style.display = 'block';
            }
        }
'@

$newFunction = @'
        window.toggleSidebar = function() {
            console.log('toggleSidebar called');
            const sidebar = document.getElementById('left-sidebar');
            const overlay = document.getElementById('sidebar-overlay');
            
            if (!sidebar) {
                console.error('Sidebar element not found!');
                return;
            }
            
            console.log('Current left position:', sidebar.style.left);
            const isOpen = sidebar.style.left === '0px';
            
            if (isOpen) {
                sidebar.style.left = '-300px';
                overlay.style.display = 'none';
                console.log('Closing sidebar');
            } else {
                sidebar.style.left = '0px';
                overlay.style.display = 'block';
                console.log('Opening sidebar');
            }
        }
'@

$content = $content -replace [regex]::Escape($oldFunction), $newFunction

Set-Content viewer.html -Value $content
Write-Host "Updated toggleSidebar with debugging!"
