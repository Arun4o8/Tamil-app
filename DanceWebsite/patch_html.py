import codecs

print("Processing index.html...")
with codecs.open("index.html", "r", "utf-8") as f:
    text = f.read()

# Add to index.html menu bar
search_bar = '            <button onclick="performSearch()" class="icon-btn">'
lang_btn = '            <button onclick="window.location.href=\'viewer.html#language\'" class="icon-btn">\n                <i class="fas fa-language" style="font-size: 1.2rem;"></i>\n            </button>\n'
text = text.replace(search_bar, lang_btn + search_bar)

# Add script src
text = text.replace('<script src="js/app-logic.js"></script>', '<script src="js/translations.js"></script>\n    <script src="js/app-logic.js"></script>')

with codecs.open("index.html", "w", "utf-8") as f:
    f.write(text)

print("Processing viewer.html...")
with codecs.open("viewer.html", "r", "utf-8") as f:
    text2 = f.read()

start = text2.find("// --------------------------------------------------------------\n        //  SELF-CONTAINED TAMIL TRANSLATION ENGINE")
end = text2.find("// Apply saved language on page load")
if start != -1 and end != -1:
    text2 = text2[:start] + "\n        " + text2[end:]
    
    # We also need to add <script src="js/translations.js"> where the TRANSLATION ENGINE block is
    engine_comment = "<!-- =================== TRANSLATION ENGINE =================== -->\n    <script>"
    replacement = "<!-- =================== TRANSLATION ENGINE =================== -->\n    <script src=\"js/translations.js\"></script>\n    <script>"
    text2 = text2.replace(engine_comment, replacement)

with codecs.open("viewer.html", "w", "utf-8") as f:
    f.write(text2)

print("Updated index.html and viewer.html")
