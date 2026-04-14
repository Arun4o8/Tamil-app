import codecs
import re

with codecs.open('js/app-logic.js', 'r', 'utf-8') as f:
    app_logic = f.read()

culture_match = re.search(r'(window\.cultureDetailsTamil = \{.*?\n\};)', app_logic, re.DOTALL)
if not culture_match:
    print("Could not find cultureDetailsTamil in app-logic.js")
    exit(1)
culture_details_tamil_str = culture_match.group(1)

with codecs.open('viewer.html', 'r', 'utf-8') as f:
    viewer_html = f.read()

# Replace window.TAMIL
tamil_str = """window.TAMIL = {
            // Header
            'welcome_to': 'வரவேற்கிறோம்',
            'our_culture': 'நமது கலாச்சாரம்',
            // Home Dashboard
            'home': 'முகப்பு',
            'home_dances': 'நடனங்கள்',
            'home_dances_desc': 'பாரம்பரிய கலை வடிவங்களை ஆராயுங்கள்',
            'home_celebrations': 'ஆഘോഷங்கள்',
            'home_celebrations_desc': 'திருவிழாக்கள் & நிகழ்வுகள்',
            'discovery_hub': 'கண்டுபிடிப்பு மையம்',
            'challenge': 'சவால்',
            'cultural_quiz': 'கலாச்சார வினாடி வினா',
            'rules_guidelines': 'வழிகாட்டுதல்கள் & விதிகள்',
            // Navigation
            'explore': 'ஆராயுங்கள்',
            'saved': 'சேமித்தவை',
            'celebrations': 'நிகழ்வுகள்',
            'profile': 'சுயவிவரம்',
            // Menu
            'my_profile': 'என் சுயவிவரம்',
            'practice_session': 'பயிற்சி அமர்வு',
            'about_us': 'எங்களைப் பற்றி',
            'language': 'மொழி',
            'avatar_gender': 'அவதார் பாலினம்',
            'gender': 'பாலினம்',
            'support': 'ஆதரவு',
            'settings': 'அமைப்புகள்',
            'logout': 'வெளியேறு',
            // Explore
            'explore_cultures': 'கலாச்சாரங்களை ஆராயுங்கள்',
            'all_dances': 'அனைத்து நடனங்கள்',
            'classical': 'பாரம்பரிய',
            'folk': 'நாட்டுப்புற',
            'martial_arts': 'தற்காப்புக்கலை',
            'view_details': 'விவரங்களை காண்',
            // Dance names
            'Bharatanatyam': 'பரதநாட்டியம்',
            'Karakattam': 'கரகாட்டம்',
            'Silambattam': 'சிலம்பாட்டம்',
            'Kavadi Attam': 'காவடி ஆட்டம்',
            'Puliyattam': 'புலியாட்டம்',
            'Therukoothu': 'தெருக்கூத்து',
            'Kummi': 'கும்மி',
            'Oyillattam': 'ஒயிலாட்டம்',
            'Bommalattam': 'பொம்மலாட்டம்',
            'Villu Paatu': 'வில்லுப்பாட்டு',
            'Kolattam': 'கோலாட்டம்',
            'Poikkal Kuthirai Attam': 'பொய்க்கால் குதிரை ஆட்டம்',
            'Mayil Aattam': 'மயிலாட்டம்',
            'Devaraattam': 'தேவராட்டம்',
            'Paampu Attam': 'பாம்பு ஆட்டம்',
            'Paraiattam': 'பறையாட்டம்',
            // Dance types (exact text as in HTML)
            'Classical Dance': 'பாரம்பரிய நடனம்',
            'Folk (Pot Balance)': 'நாட்டுப்புறம் (பானை வீச்சு)',
            'Traditional Martial Arts': 'பாரம்பரிய தற்காப்புக்கலை',
            'Devotional Celebration': 'பக்தி நடனம்',
            'Tiger Spirit Dance': 'புலி ஆவி நடனம்',
            'Ancient Street Theater': 'பழங்கால வீதி நாடகம்',
            'Rhythmic Rhythm & Song': 'தாள இசை & பாடல்',
            'Folk Dance of Grace': 'நேர்த்தியான நாட்டுப்புற நடனம்',
            'Traditional Puppetry': 'பாரம்பரிய பொம்மலாட்டம்',
            'Bowing Storytelling': 'வில்லுப்பாட்டு கதைசொல்லல்',
            'Stick Dance': 'கோல் நடனம்',
            'Dummy Horse Dance': 'பொய்க்கால் குதிரை நடனம்',
            'Peacock Dance': 'மயிலாட்டம்',
            'Celebratory Victory Dance': 'வெற்றி கொண்டாட்ட நடனம்',
            'Snake Dance': 'பாம்பு நடனம்',
            'Energetic Drum Dance': 'எனர்ஜெடிக் பறை நடனம்',
            // View titles
            'language_view_title': 'மொழி',
            'learning_guidelines': 'கற்றல் வழிகாட்டுதல்கள்',
            'learning_steps_title': 'கற்றல் படிகள்',
            'safety_first': 'பாதுகாப்பு முதலில்',
            'cultural_respect': 'கலாச்சார மரியாதை',
            // Rules
            'rule1': 'அடிப்படை நிலையுடன் தொடங்குங்கள் (அரைமண்டி)',
            'rule2': 'தினமும் முத்திரைகளை பயிற்சி செய்யுங்கள்',
            'rule3': 'சரியான படிமுறைகளை பின்பற்றுங்கள்',
            'safety1': 'பயிற்சிக்கு முன் வார்ம்-அப் செய்யவும்',
            'safety2': 'முதுகை நேராக வைத்து பயிற்சி செய்யவும்',
            'safety3': 'பயிற்சியின் போது நீர் அருந்தவும்',
            'respect1': 'மரபுகள் மற்றும் குருவை மதிக்கவும்',
            'respect2': 'பொருத்தமான உடைகளை அணியவும்',
            'respect3': 'கலைக்கு பின்னால் உள்ள கதைகளை புரிந்துகொள்ளவும்',
            'back_to_home': 'முகப்பிற்குச் செல்க',
            'back_home': 'முகப்பிற்குச் செல்க',
            // Gender view
            'choose_gender': 'AR/VR அனுபவங்களுக்கான உங்கள் அவதாரத்தின் பாலினத்தை தேர்ந்தெடுக்கவும்.',
            'male_label': 'ஆண்',
            'female_label': 'பெண்',
            'non_binary_label': 'மற்றவை / பைனரி அல்லாதவை',
            // Support
            'contact_support': 'வாடிக்கையாளர் ஆதரவு',
            'faqs': 'அடிக்கடி கேட்கப்படும் கேள்விகள்',
            // Saved view
            'no_saved_items': 'சேமித்த உருப்படிகள் எதுவும் இல்லை.',
            'explore_now': 'இப்போதே ஆராயுங்கள்',
            // Profile
            'edit_profile': 'சுயவிவரத்தைத் திருத்து',
            'dark_mode': 'இருண்ட பயன்முறை',
            // Settings
            'lang_settings': 'மொழி அமைப்புகள்',
            'support_help': 'ஆதரவு & உதவி',
            // Quiz
            'master_heritage': 'உங்கள் பாரம்பரியத்தை அறியுங்கள்',
            'test_knowledge': 'தமிழ் கலாச்சாரம் மற்றும் நடன வடிவங்களில் உங்கள் அறிவை சோதிக்கவும்.',
            'start_challenge': 'சவாலை தொடங்கு',
            'quiz_complete': 'வினாடி வினா முடிந்தது!',
            'try_again': 'மீண்டும் முயற்சி செய்',
            'start': 'தொடங்கு'
        };"""

viewer_html = re.sub(r'window\.TAMIL = \{.*?\n        \};', tamil_str, viewer_html, flags=re.DOTALL)
viewer_html = re.sub(r'window\.cultureDetailsTamil = \{.*?\n        \};', culture_details_tamil_str, viewer_html, flags=re.DOTALL)

# Some trailing brackets or missing spaces could break the regex. So we do it carefully.
# We also fix the toast
toast_pattern = r"(toast\.innerText = \(lang === 'ta'\) \? )'.*?'( : '.*Language Changed!'.*?;)"
viewer_html = re.sub(toast_pattern, r"\1'மொழி மாற்றப்பட்டது!'\2", viewer_html)

with codecs.open('viewer.html', 'w', 'utf-8') as f:
    f.write(viewer_html)

print("Patch applied successfully.")
