import re

with open(r'c:\Users\DEEPAK\Desktop\DanceWebsite\viewer.html', 'r', encoding='utf-8') as f:
    text = f.read()

def replace_image(match):
    culture_name = match.group(1)
    folder_name = culture_name.lower().replace(" ", "")
    img_tag_part = match.group(2)
    # The image is currently unsplash, replace the whole src="..." match inside img_tag
    # We'll just replace the URL directly since we know it's unsplash
    new_img_src = f'assets/cultures/{folder_name}/thumb.png'
    new_img_tag = re.sub(r'src="https://images.unsplash.com/[^"]+"', f'src="{new_img_src}"', img_tag_part)
    return f"""<div class="dance-card" onclick="showCultureDetail('{culture_name}')">{new_img_tag}"""

# We need a regex that matches the div and the img tag inside it.
pattern = r'<div class="dance-card" onclick="showCultureDetail\(\'(.*?)\'\)">(.*?)<img[^>]+src="https://images.unsplash.com/[^"]+"[^>]*>'

# Wait, `.*` might match too much. Let's do it simply line-by-line or by finding the next `img` tag.
lines = text.split('\n')
current_culture = None
for i in range(len(lines)):
    m = re.search(r'onclick="showCultureDetail\(\'(.*?)\'\)"', lines[i])
    if m:
        current_culture = m.group(1).lower().replace(" ", "")
    
    if current_culture and 'src="https://images.unsplash.com/' in lines[i]:
        new_src = f'assets/cultures/{current_culture}/thumb.png'
        lines[i] = re.sub(r'src="https://images.unsplash.com/[^"]+"', f'src="{new_src}"', lines[i])
        current_culture = None

with open(r'c:\Users\DEEPAK\Desktop\DanceWebsite\viewer.html', 'w', encoding='utf-8') as f:
    f.write('\n'.join(lines))
    
print("Images patched.")
