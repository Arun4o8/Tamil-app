$content = Get-Content viewer.html -Raw

# Add toggleSidebar function and CSS
$sidebarJS = @'

        // Toggle Left Sidebar
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

        // Add hover effects to sidebar items
        document.addEventListener('DOMContentLoaded', function() {
            const style = document.createElement('style');
            style.textContent = `
                .sidebar-item:hover {
                    background: rgba(255, 87, 34, 0.2) !important;
                    transform: translateX(5px);
                }
                .sidebar-item:active {
                    transform: scale(0.98) translateX(5px);
                }
            `;
            document.head.appendChild(style);
        });
'@

$insertBefore = '        window.toggleHeaderMenu'
$content = $content -replace [regex]::Escape($insertBefore), ($sidebarJS + "`r`n" + $insertBefore)

Set-Content viewer.html -Value $content
Write-Host "Sidebar JavaScript added!"
