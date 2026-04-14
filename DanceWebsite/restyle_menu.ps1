$content = Get-Content viewer.html -Raw

$newCss = @'
        /* Menu Item Styling */
        .menu-item-div {
            background: #222222 !important; /* Solid Dark Background */
            border-bottom: 2px solid #333333 !important; /* Solid Underline */
            margin-bottom: 12px !important;
            border-radius: 8px !important;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2) !important;
        }
        
        .menu-item-div .menu-label {
            color: #ff9100 !important; /* Vivid Orange Text */
            font-weight: 700 !important;
            font-size: 1rem !important;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        
        .menu-item-div i {
            color: #ffffff !important; /* White Icons for contrast */
        }
        
        .menu-item-div:hover {
            background: #333333 !important;
            border-bottom: 2px solid var(--primary) !important;
        }
'@

# Regex to replace the previous block (approximate match via comment)
# We match from /* Menu Item Styling */ to the next closing brace of the last rule.
# It's safer to just replace the whole style tag content if likely unique or append if not found, 
# but I'll try to find the comment.

if ($content -match '/\* Menu Item Styling \*/') {
    # Replace existing block
    # Regex: match comment, then everything until "}" loop. 
    # Hard to regex replace a block correctly without markers.
    # I'll replace the exact string I added last time if possible, or just append this as an override (CSS cascade works).
    # Since I used !important, appending is fine.
    
    $content = $content -replace '</style>', ($newCss + "`n    </style>")
} else {
    # If not found (should be there), append.
    $content = $content -replace '</style>', ($newCss + "`n    </style>")
}

Set-Content viewer.html -Value $content
Write-Host "Updated menu items with bold colors and solid background!"
