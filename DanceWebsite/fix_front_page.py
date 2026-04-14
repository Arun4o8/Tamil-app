import os

file_path = r'c:\Users\DEEPAK\Desktop\DanceWebsite\viewer.html'

with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

out_lines = []
skip = False
for line in lines:
    if '<div id="culture-grid-home"' in line:
        skip = True
        
    if skip:
        if '<h3 style="margin-bottom: 15px;">Recent Activity</h3>' in line:
            skip = False
            # Insert the newly requested content before Recent Activity
            out_lines.append('''            <div style="display: flex; flex-direction: column; gap: 15px; margin-bottom: 30px;">
                <div class="dance-card" onclick="switchView('explore')" style="display: flex; align-items: center; padding: 15px; gap: 15px; border-radius: 12px; cursor: pointer; background: var(--glass-bg); border: 1px solid var(--glass-border);">
                    <div style="width: 60px; height: 60px; border-radius: 10px; overflow: hidden; flex-shrink: 0;">
                        <img src="https://images.unsplash.com/photo-1547407139-3c921a66005c?auto=format&fit=crop&q=80&w=300" style="width: 100%; height: 100%; object-fit: cover;">
                    </div>
                    <div style="flex-grow: 1; text-align: left;">
                        <span style="font-size: 1.1rem; font-weight: 700; color: var(--text-main); display: block;">Dances</span>
                        <span style="font-size: 0.85rem; color: var(--text-muted);">Explore Heritage Art Forms</span>
                    </div>
                    <i class="fas fa-chevron-right" style="color: var(--primary);"></i>
                </div>
                
                <div class="dance-card" onclick="alert('Celebrations coming soon!')" style="display: flex; align-items: center; padding: 15px; gap: 15px; border-radius: 12px; cursor: pointer; background: var(--glass-bg); border: 1px solid var(--glass-border);">
                    <div style="width: 60px; height: 60px; border-radius: 10px; overflow: hidden; flex-shrink: 0;">
                        <img src="https://images.unsplash.com/photo-1514302240736-b1fee5985889?auto=format&fit=crop&q=80&w=300" style="width: 100%; height: 100%; object-fit: cover;">
                    </div>
                    <div style="flex-grow: 1; text-align: left;">
                        <span style="font-size: 1.1rem; font-weight: 700; color: var(--text-main); display: block;">Celebrations</span>
                        <span style="font-size: 0.85rem; color: var(--text-muted);">Festivals & Events</span>
                    </div>
                    <i class="fas fa-chevron-right" style="color: var(--primary);"></i>
                </div>
            </div>\n\n''')
            out_lines.append(line)
    else:
        out_lines.append(line)

with open(file_path, 'w', encoding='utf-8') as f:
    f.writelines(out_lines)

print("Restored front page!")
