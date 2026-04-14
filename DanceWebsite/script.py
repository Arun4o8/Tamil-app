import sys

file_path = r'c:\Users\DEEPAK\Desktop\DanceWebsite\viewer.html'

with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

start_idx = -1
for i, line in enumerate(lines):
    if '<div id="view-home"' in line:
        start_idx = i
        break

all_forms_start_idx = -1
for i in range(start_idx + 1, len(lines)):
    if 'All Forms' in lines[i]:
        all_forms_start_idx = i - 1
        break

discovery_hub_idx = -1
for i in range(all_forms_start_idx, len(lines)):
    if 'id="discovery-hub-title"' in lines[i]:
        discovery_hub_idx = i
        break
        
view_rules_idx = -1
for i in range(discovery_hub_idx, len(lines)):
    if '<div id="view-rules"' in lines[i]:
        view_rules_idx = i
        break

if start_idx != -1 and all_forms_start_idx != -1 and discovery_hub_idx != -1:
    new_html = '''
            <!-- Category Cards -->
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-top: 20px; margin-bottom: 20px;">
                <!-- Celebration Card -->
                <div class="glass-panel animate-fade-in" onclick="alert('Celebrations coming soon!')" style="padding: 30px 15px; display: flex; flex-direction: column; align-items: center; gap: 15px; cursor: pointer; border-radius: 20px; border: 1px solid rgba(255, 202, 40, 0.4); transiti>
                    <div style="width: 70px; height: 70px; border-radius: 50%; display: flex; align-items: center; justify-content: center; background: rgba(255, 202, 40, 0.2); box-shadow: 0 0 15px rgba(255, 202, 40, 0.3);">
                        <i class="fas fa-glass-cheers" style="font-size: 2rem; color: #ffca28;"></i>
                    </div>
                    <span style="font-size: 1.1rem; color: var(--text-main); font-weight: 700;">Celebrations</span>
                </div>

                <!-- Dances Card -->
                <div class="glass-panel animate-fade-in delay-1" onclick="const s = document.getElementById('home-dances-section'); s.style.display = s.style.display === 'none' ? 'block' : 'none'; if(s.style.display === 'block') { setTimeout(() => window.scrollTo({top: s.offsetTop - 80, behavior: 'smooth'}), 100); }" style="padding: 30px 15px; display: flex; flex-direction: column; align-items: center; gap: 15px; cursor: pointer; border-radius: 20px; border: 1px solid rgba(233, 30, 99, 0.4); transition: transform 0.3s;" onmouseover="this.style.background='rgba(233, 30, 99, 0.1)'; this.style.transform='translateY(-5px)'" onmouseout="this.style.background='var(--glass)'; this.style.transform='translateY(0)'">
                    <div style="width: 70px; height: 70px; border-radius: 50%; display: flex; align-items: center; justify-content: center; background: rgba(233, 30, 99, 0.2); box-shadow: 0 0 15px rgba(233, 30, 99, 0.3);">
                        <i class="fas fa-users" style="font-size: 2rem; color: var(--primary);"></i>
                    </div>
                    <span style="font-size: 1.1rem; color: var(--text-main); font-weight: 700;">Dances</span>
                </div>
            </div>

            <!-- Hidden container for dances -->
            <div id="home-dances-section" style="display: none; padding-top: 10px;">
'''
    output = lines[:start_idx + 1]
    output.append(new_html)
    output.extend(lines[all_forms_start_idx:discovery_hub_idx])
    output.append('            </div> <!-- end home-dances-section -->\n\n')
    
    # Hide the rest of view-home
    output.append('<!-- Hiding old home features\n')
    output.extend(lines[discovery_hub_idx:view_rules_idx - 1])
    output.append('-->\n')
    
    # Add view-rules and below
    output.extend(lines[view_rules_idx - 1:])
    
    with open(file_path, 'w', encoding='utf-8') as f:
        f.writelines(output)
    print("Done")
else:
    print(f"Error {start_idx} {all_forms_start_idx} {discovery_hub_idx}")
