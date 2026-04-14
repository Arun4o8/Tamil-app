import codecs

with codecs.open('js/translations.js', 'r', 'utf-8') as f:
    js = f.read()

# Add to TAMIL
ta_addition = """
            // Landing Page
            'landing_title_html': 'XR-ல் <br><span style="color: var(--primary);">தமிழ் கலாச்சாரத்தை</span><br>அனுபவியுங்கள்',
            'landing_desc': 'தமிழ் நடனம், கலை மற்றும் வரலாற்றின் துடிப்பான பாரம்பரியத்தை அதிவேக XR தொழில்நுட்பத்தின் மூலம் அனுபவியுங்கள்.',
            'get_started': 'தொடங்கு',
"""
js = js.replace('// Header\n', '// Header\n' + ta_addition)

# Add to ENGLISH
en_addition = """
            'landing_title_html': 'Experience<br><span style="color: var(--primary);">Tamil Culture</span><br>in XR',
            'landing_desc': 'Immerse yourself in the vibrant heritage of Tamil dance, art, and history through immersive XR technology.',
            'get_started': 'Get Started',
"""
js = js.replace('window.ENGLISH = {\n', 'window.ENGLISH = {\n' + en_addition)

# Add to idMap
idmap_addition = """
                'landing-desc': 'landing_desc',
                'landing-btn': 'get_started',
"""
js = js.replace("'welcome-text': 'welcome_to',", "'welcome-text': 'welcome_to'," + idmap_addition)

# Add innerHTML
ih_logic = """
            var landingTitle = document.getElementById('landing-title');
            if (landingTitle && t['landing_title_html']) {
                landingTitle.innerHTML = t['landing_title_html'];
            }
"""
js = js.replace('// 13. Toast', ih_logic + '\n            // 13. Toast')

with codecs.open('js/translations.js', 'w', 'utf-8') as f:
    f.write(js)
print('Updated translations.js')
