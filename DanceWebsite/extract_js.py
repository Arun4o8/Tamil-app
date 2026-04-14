import re

with open(r'c:\Users\DEEPAK\Desktop\DanceWebsite\viewer.html', 'r', encoding='utf-8') as f:
    text = f.read()

match = re.search(r'<script type="module">(.*?)</script>', text, re.DOTALL)
if match:
    with open(r'c:\Users\DEEPAK\Desktop\DanceWebsite\temp_script.js', 'w', encoding='utf-8') as jsf:
        jsf.write("import { } from 'firebase';\n" + match.group(1))
    print("Extracted JS.")
else:
    print("Script not found.")
