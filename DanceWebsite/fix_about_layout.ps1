$path = "c:\Users\DEEPAK\Desktop\DanceWebsite\viewer.html"
$lines = Get-Content $path -Encoding UTF8
$newLines = @()
$skipCount = 0

for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($skipCount -gt 0) {
        $skipCount--
        continue
    }

    $line = $lines[$i]
    
    # 1. Fix Layout for About Cards (Line > 1100 approx coverage)
    # Target Director, Mentor, and Developers. 
    # Avoid line 964 (Dark Mode).
    if ($i -gt 1100 -and $line -match '<div style="display: flex; align-items: center; gap: 15px;">') {
        $line = $line -replace '<div style="display: flex; align-items: center; gap: 15px;">', '<div style="display: flex; flex-direction: column; align-items: center; gap: 10px; text-align: center;">'
        Write-Host "Fixed layout at line $($i+1)"
    }

    # 2. Fix Header logic
    if ($line -match '<div style="display: flex; align-items: center; gap: 15px; margin-bottom: 20px;">' -and $i -gt 1100 -and $i -lt 1120) {
        # Peek ahead to see if it's the broken block
        if (($i + 2) -lt $lines.Count -and $lines[$i + 2] -match '<div style="display: flex; align-items: center; gap: 15px; margin-bottom: 20px;">') {
            # Found the start of bad block
            $newLines += '            <div style="display: flex; align-items: center; gap: 15px; margin-bottom: 20px;">'
            $newLines += '                <button onclick="switchView(''home'')" style="background: none; border: none; color: var(--text-main); font-size: 1.2rem; cursor: pointer; padding: 0;"><i class="fas fa-arrow-left"></i></button>'
            $newLines += '                <h3 id="about-page-title" style="color: var(--primary); font-size: 1.5rem; margin: 0;">About Us</h3>'
            $newLines += '            </div>'
           
            # Skip lines: 
            # 1102 (current) -> skipped effectively by not adding $line
            # 1103 button -> skip
            # 1104 div -> skip
            # 1105 button -> skip
            # 1106 h3 -> skip
            $skipCount = 4 
            Write-Host "Fixed Header Block at line $($i+1)"
            continue
        }
    }
    
    $newLines += $line
}

$newLines | Set-Content -Path $path -Encoding UTF8
Write-Host "Done"
