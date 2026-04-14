filepath = r"c:\Users\DEEPAK\Desktop\DanceWebsite\js\app-logic.js"
with open(filepath, "r", encoding="utf-8") as f:
    content = f.read()

marker = "                // ==================== GLOBAL FUNCTIONS (for HTML onclick handlers) ===================="
idx = content.find(marker)
print("Marker found at index:", idx)

if idx != -1:
    missing_close = """            }
        }
    }
}

// ==================== GLOBAL INSTANCES ====================
const api = new TamilCultureAPI();
const trainingManager = new TrainingManager(api);

// ==================== CLEAN switchView ====================
window.switchView = function (viewName) {
    document.querySelectorAll(".view-section").forEach(function(el) { el.classList.remove("view-active"); });
    var v = document.getElementById("view-" + viewName);
    if (v) v.classList.add("view-active");
    document.querySelectorAll(".nav-item").forEach(function(el) { el.classList.remove("active"); });
    var n = document.getElementById("nav-" + viewName);
    if (n) n.classList.add("active");
    if (viewName === "saved" && typeof window.renderSavedItemsHelper === "function") window.renderSavedItemsHelper();
    var btn = document.querySelector(".app-header button");
    if (btn) btn.style.display = (viewName === "home") ? "none" : "flex";
    window.scrollTo(0, 0);
    window.location.hash = viewName;
};

"""
    content = content[:idx] + missing_close + content[idx:]
    # Remove old duplicate global instances
    dup = "// ==================== GLOBAL INSTANCES ====================\r\nconst api = new TamilCultureAPI();\r\nconst trainingManager = new TrainingManager(api);\r\n"
    first = content.find(dup)
    if first != -1:
        second = content.find(dup, first + 1)
        if second != -1:
            content = content[:second] + content[second + len(dup):]
            print("Removed duplicate global instances")
    with open(filepath, "w", encoding="utf-8") as f:
        f.write(content)
    print("Done!")
else:
    print("Marker not found, checking structure...")
    lines = content.split("\n")
    for i, l in enumerate(lines[460:475], 461):
        print(f"  {i}: {l[:80]}")
