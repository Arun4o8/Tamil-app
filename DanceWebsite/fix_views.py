import re
with open("viewer.html", "r", encoding="utf-8") as f:
    html = f.read()

# Find the views to move
match = re.search(r'(<!-- 5\. ABOUT VIEW -->.*?)(?=<!-- Application Logic - Java \+ JavaScript -->)', html, re.DOTALL)
if match:
    views_html = match.group(1)
    
    # Remove from original location
    html = html.replace(views_html, "")
    
    # Insert before the closing div of app-container (just before script type="module")
    insert_point = '    </div>\n\n    <script type="module">'
    html = html.replace(insert_point, "\n" + views_html + insert_point)
    
    with open("viewer.html", "w", encoding="utf-8") as f:
        f.write(html)
    print("Successfully moved views inside app-container in viewer.html.")
else:
    print("Could not find the views to move.")
