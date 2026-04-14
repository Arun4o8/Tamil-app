import os

with open(r'c:\Users\DEEPAK\Desktop\DanceWebsite\viewer_fixed.html', 'r', encoding='utf-8') as f:
    text = f.read()

# 1. Replace Learning Options Button
old_learning_button = """            <button id="detail-start-training-btn" onclick="startTrainingFromDetail()" class="btn-primary"
                style="margin-top: 30px; width: 100%; padding: 18px; border-radius: 12px; font-weight: 700;">Start
                Guided
                Learning</button>"""

new_learning_buttons = """            <h4 style="margin-top: 30px; margin-bottom: 15px; text-align: center; color: var(--text-main); font-weight: 600;">Learning Options</h4>
            <div style="display: flex; flex-direction: column; gap: 12px; margin-bottom: 30px;">
                <button id="detail-start-training-btn" onclick="startTrainingFromDetail()" class="btn-primary"
                    style="width: 100%; padding: 18px; border-radius: 12px; font-weight: 700; display: flex; justify-content: space-between; align-items: center;">
                    <span style="display: flex; align-items: center; gap: 10px;"><i class="fas fa-book-reader" style="font-size: 1.2rem;"></i> Step-by-Step Training</span>
                    <i class="fas fa-chevron-right"></i>
                </button>
                <button onclick="launchXRFromDetail('AR')" class="btn-secondary"
                    style="width: 100%; padding: 18px; border-radius: 12px; font-weight: 700; display: flex; justify-content: space-between; align-items: center;">
                    <span style="display: flex; align-items: center; gap: 10px;"><i class="fas fa-camera" style="font-size: 1.2rem; color: #ffca28;"></i> Learning in AR View</span>
                    <i class="fas fa-chevron-right"></i>
                </button>
                <button onclick="launchXRFromDetail('XR')" class="btn-secondary"
                    style="width: 100%; padding: 18px; border-radius: 12px; font-weight: 700; display: flex; justify-content: space-between; align-items: center;">
                    <span style="display: flex; align-items: center; gap: 10px;"><i class="fas fa-vr-cardboard" style="font-size: 1.2rem; color: var(--primary);"></i> Learning in VR Immersive</span>
                    <i class="fas fa-chevron-right"></i>
                </button>
            </div>"""

text = text.replace(old_learning_button, new_learning_buttons)

# 2. Add launchXRFromDetail js function
old_script_start = """        window.startTrainingFromDetail = function () {
            startTraining(activeDetailCulture);
        }"""

new_script_start = old_script_start + """\n
        window.launchXRFromDetail = (mode) => {
            if (mode === 'XR') {
                if (typeof connectToUnity === 'function') {
                    connectToUnity(window.activeDetailCulture, "Free Practice Mode");
                } else {
                    alert(`Starting VR Immersive Experience: ${window.activeDetailCulture}`);
                }
                if (typeof recordActivity === 'function') {
                    recordActivity(window.activeDetailCulture + " - VR Mode View");
                }
            } else {
                const msg = localStorage.getItem('selectedLanguage') === 'ta' ? `AR காட்சியைத் தொடங்குகிறது ${window.activeDetailCulture}... உங்கள் கேமராவை ஒரு தட்டையான மேற்பரப்பில் காட்டுங்கள்!` : `Opening AR View for ${window.activeDetailCulture}... Point your camera at a flat surface!`;
                alert(msg);
                if (typeof recordActivity === 'function') {
                    recordActivity(window.activeDetailCulture + " - AR Mode View");
                }
            }
        };\n"""

text = text.replace(old_script_start, new_script_start)

# 3. Replace Front Page recent activity and home grid with Dances & Celebrations cards
import re

# Match the grid block and the recent activity block
# Let's find exactly the view-home section.
match_home = re.search(r'(<div id="view-home".*?>).*?(<div id="view-rules".*?>)', text, re.DOTALL)
if match_home:
    old_home_content = match_home.group(1) + match_home.group(2)
    # the replacement content for view-home
    new_home_content = """<div id="view-home" class="view-section view-active">
            <div style="display: flex; flex-direction: column; gap: 15px; margin-bottom: 30px;">
                <div class="dance-card" onclick="switchView('explore')" style="display: flex; align-items: center; padding: 15px; gap: 15px; border-radius: 12px; cursor: pointer; background: var(--glass-bg); border: 1px solid var(--glass-border);">
                    <div style="width: 60px; height: 60px; border-radius: 10px; overflow: hidden; flex-shrink: 0;">
                        <img src="cover.png" style="width: 100%; height: 100%; object-fit: cover;">
                    </div>
                    <div style="flex-grow: 1; text-align: left;">
                        <span style="font-size: 1.1rem; font-weight: 700; color: var(--text-main); display: block;">Dances</span>
                        <span style="font-size: 0.85rem; color: var(--text-muted);">Explore Heritage Art Forms</span>
                    </div>
                    <i class="fas fa-chevron-right" style="color: var(--primary);"></i>
                </div>
                
                <div class="dance-card" onclick="alert('Celebrations coming soon!')" style="display: flex; align-items: center; padding: 15px; gap: 15px; border-radius: 12px; cursor: pointer; background: var(--glass-bg); border: 1px solid var(--glass-border);">
                    <div style="width: 60px; height: 60px; border-radius: 10px; overflow: hidden; flex-shrink: 0;">
                        <img src="cover.png" style="width: 100%; height: 100%; object-fit: cover;">
                    </div>
                    <div style="flex-grow: 1; text-align: left;">
                        <span style="font-size: 1.1rem; font-weight: 700; color: var(--text-main); display: block;">Celebrations</span>
                        <span style="font-size: 0.85rem; color: var(--text-muted);">Festivals & Events</span>
                    </div>
                    <i class="fas fa-chevron-right" style="color: var(--primary);"></i>
                </div>
            </div>
        </div>
        
        """ + match_home.group(2)
        
    text = text[:match_home.start()] + new_home_content + text[match_home.end():]

# Write out the completed viewer.html
with open(r'c:\Users\DEEPAK\Desktop\DanceWebsite\viewer.html', 'w', encoding='utf-8') as f:
    f.write(text)

print("Restored full file successfully.")
