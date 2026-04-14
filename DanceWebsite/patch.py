import os

with open('c:\\Users\\DEEPAK\\Desktop\\DanceWebsite\\viewer_fixed.html', 'r', encoding='utf-8') as f:
    text = f.read()

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


old_script_start = """        window.startTrainingFromDetail = function () {
            startTraining(activeDetailCulture);
        }"""

new_script_start = old_script_start + """

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
        };"""

if old_learning_button not in text:
    print("WARNING: Old learning button not found!")
else:
    text = text.replace(old_learning_button, new_learning_buttons)
    print("Replaced learning buttons.")

if old_script_start not in text:
    print("WARNING: Old script start not found!")
else:
    text = text.replace(old_script_start, new_script_start)
    print("Replaced script start.")

with open('c:\\Users\\DEEPAK\\Desktop\\DanceWebsite\\viewer.html', 'w', encoding='utf-8') as f:
    f.write(text)

print('Success: Replaced viewer.html with modified viewer_fixed.html content!')
