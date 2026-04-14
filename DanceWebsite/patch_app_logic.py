import codecs

with codecs.open('js/app-logic.js', 'r', 'utf-8') as f:
    app_logic = f.read()

# Remove window.cultureDetailsTamil
start1 = app_logic.find("window.cultureDetailsTamil = {")
if start1 != -1:
    end1 = app_logic.find("};", start1) + 2
    app_logic = app_logic[:start1] + app_logic[end1:]

# Remove window.translations
start2 = app_logic.find("window.translations = {")
if start2 != -1:
    end2 = app_logic.find("};", start2) + 2
    app_logic = app_logic[:start2] + app_logic[end2:]

# Remove window.changeLanguage
start3 = app_logic.find("window.changeLanguage = function (lang) {")
end3 = app_logic.find("// ==================== INITIALIZATION ====================")
if start3 != -1 and end3 != -1:
    app_logic = app_logic[:start3] + app_logic[end3:]

with codecs.open('js/app-logic.js', 'w', 'utf-8') as f:
    f.write(app_logic)

print("Patch applied to app-logic.js")
