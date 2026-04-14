$content = Get-Content viewer.html -Raw

$css = @'
        /* Menu Item Styling */
        .menu-item-div {
            background: linear-gradient(90deg, rgba(255,255,255,0.03), rgba(255,255,255,0.08)) !important;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2) !important;
            margin-bottom: 12px !important;
            border-radius: 8px !important;
        }
        
        .menu-item-div .menu-label {
            color: #ffffff !important;
            font-weight: 700 !important;
            letter-spacing: 0.5px;
        }
        
        .menu-item-div:hover {
            background: rgba(255, 87, 34, 0.2) !important;
            border-bottom: 1px solid var(--primary) !important;
        }
'@

$content = $content -replace '</style>', ($css + "`n    </style>")

Set-Content viewer.html -Value $content
Write-Host "Updated menu bar styling with colors and underlines!"
