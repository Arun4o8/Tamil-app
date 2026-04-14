import os

with open('c:\\Users\\DEEPAK\\Desktop\\DanceWebsite\\viewer.html', 'r', encoding='utf-8') as f:
    viewer_lines = f.readlines()

with open('c:\\Users\\DEEPAK\\Desktop\\DanceWebsite\\viewer_fixed.html', 'r', encoding='utf-8') as f:
    fixed_lines = f.readlines()

top_part = []
for line in viewer_lines:
    if line.strip() == '<script type="module">':
        break
    top_part.append(line)

bottom_part = []
found_script = False
start_training_idx = -1
for i, line in enumerate(fixed_lines):
    if line.strip() == '<script type="module">':
        found_script = True
    if found_script:
        bottom_part.append(line)
        if 'startTrainingFromDetail' in line:
            print("Found startTrainingFromDetail at", len(bottom_part) - 1, line)
            if start_training_idx == -1: # Only trigger on first match.
                start_training_idx = len(bottom_part) - 1

XRFunction = '''
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
        };
'''

if start_training_idx != -1:
    # Insert right after the startTrainingFromDetail function block ends
    # The block takes 3 lines: function start, the call, and the closing brace.
    bottom_part.insert(start_training_idx + 3, XRFunction + '\n')

with open('c:\\Users\\DEEPAK\\Desktop\\DanceWebsite\\viewer.html', 'w', encoding='utf-8') as f:
    f.writelines(top_part)
    f.writelines(bottom_part)

print('Successfully restored the script section and added launchXRFromDetail!')
