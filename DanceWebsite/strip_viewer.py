import codecs

with codecs.open('viewer.html', 'r', 'utf-8') as f:
    lines = f.readlines()

start_idx = -1
for i, line in enumerate(lines):
    if '<!-- =================== TRANSLATION ENGINE =================== -->' in line:
        start_idx = i
        break

end_idx = -1
for i, line in enumerate(lines[start_idx:]):
    if '// Apply saved language on page load' in line:
        end_idx = start_idx + i
        break

if start_idx != -1 and end_idx != -1:
    new_lines = lines[:start_idx+1] + ['    <script src="js/translations.js"></script>\n', '    <script>\n        '] + lines[end_idx:]
    with codecs.open('viewer.html', 'w', 'utf-8') as f:
        f.writelines(new_lines)
    print('Removed inline translation engine starting at', start_idx, 'and ending at', end_idx)
else:
    print('Failed to find markers')
