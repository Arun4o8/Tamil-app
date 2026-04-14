$content = Get-Content viewer.html -Raw

# Identify the start and end of the corrupted block
# Start: "window.startTrainingFromDetail ="
# End: "window.toggleHeaderMenu ="

# We want to keep both start and end lines, but remove the garbage in between.
# The garbage seen:
#
#        // Toggle Sidebar Content Sections
#        
#            });
#            
#            // Toggle current section
#            if (contentDiv) {
#                contentDiv.style.display = contentDiv.style.display === 'none' ? 'block' : 'none';
#            }
#        }

$pattern = '(?s)(window\.startTrainingFromDetail\s*=\s*\(\)\s*=>\s*window\.startTraining\(window\.activeDetailCulture\);\s*)(.*?)(window\.toggleHeaderMenu\s*=)'

# Replace with nothing in between
$replacement = '$1' + "`n`n" + '$3'

$content = $content -replace $pattern, $replacement

Set-Content viewer.html -Value $content
Write-Host "Cleaned up script syntax errors!"
