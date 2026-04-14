import fileinput

file_path = r'c:\Users\DEEPAK\Desktop\DanceWebsite\viewer.html'

with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

out_lines = []
skip = False

for i, line in enumerate(lines):
    if 'id="home-dances-section"' in line and '<div' in line:
        skip = True
        continue
    
    if skip:
        if '<!-- end home-dances-section -->' in line:
            skip = False
        continue
        
    # Replace the complex onclick for the Dances card
    if 'onclick="const s = document.getElementById(\'home-dances-section\');' in line:
        line = line.replace('onclick="const s = document.getElementById(\'home-dances-section\'); s.style.display = s.style.display === \'none\' ? \'block\' : \'none\'; if(s.style.display === \'block\') { setTimeout(() => window.scrollTo({top: s.offsetTop - 80, behavior: \'smooth\'}), 100); }"', 'onclick="switchView(\'explore\')"')
    
    out_lines.append(line)

with open(file_path, 'w', encoding='utf-8') as f:
    f.writelines(out_lines)

print("Removed home-dances-section and updated onclick")
