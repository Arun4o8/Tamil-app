/**
 * Tamil Culture Heritage - JavaScript Application Logic
 * This file contains all the business logic extracted from viewer.html
 * Works with Java backend API
 */

// ==================== CONFIGURATION ====================
const API_BASE_URL = 'http://localhost:8080/api';
const USE_JAVA_BACKEND = false; // Set to true to use Java backend, false for local data

// Global Placeholder for functions to avoid TypeErrors if called too early
window.switchView = window.switchView || function (view) { console.log("View switch requested: " + view); };

// ==================== DATA (Fallback if Java backend is not available) ====================
const localMethodsDataTamil = {
    "Bharatanatyam": [
        { title: "அரைமண்டி நிலை", icon: "fa-universal-access", desc: "குதிகால்கள் ஒன்றாக இருக்கும்போது மற்றும் முழங்கால்கள் பக்கவாட்டில் சுட்டிக்காட்டப்படும் அடிப்படை நிலை. இது நிலைத்தன்மையை உருவாக்குகிறது." },
        { title: "ஹஸ்த முத்திரைகள்", icon: "fa-hand-paper", desc: "கதைகளைச் சொல்லவும் இயற்கையைப் பிரதிநிதித்துவப்படுத்தவும் பயன்படும் ஒற்றைக்கை சைகைகளைக் கற்கவும்." },
        { title: "அடவு காலடி", icon: "fa-shoe-prints", desc: "தாளத்தில் கைகள் மற்றும் கால்களின் ஒருங்கிணைப்பை மாஸ்டர் செய்யுங்கள்." },
        { title: "அபிநய பாவனைகள்", icon: "fa-smile", desc: "முகபாவனைகள் மூலம் உணர்ச்சிகளை வெளிப்படுத்தும் முறையைப் பயிற்சி செய்யுங்கள்." }
    ],
    "Karakattam": [
        { title: "முறை 1: சமநிலை", icon: "fa-heading", desc: "தலையில் கரகம் (செம்பு) வைத்து சமநிலைப்படுத்தக் கற்றுக்கொள்ளுங்கள்." },
        { title: "முறை 2: நடை", icon: "fa-walking", desc: "தலையை அசையாமல் தாளத்திற்கு ஏற்ப நடக்கும் பயிற்சி." },
        { title: "முறை 3: சுழற்சிகள்", icon: "fa-sync", desc: "கரகத்துடன் 360 டிகிரி சுழலும் வேகமான அசைவுகள்." },
        { title: "முறை 4: ஏணி ஏறுதல்", icon: "fa-level-up-alt", desc: "கரகத்தைச் சமநிலைப்படுத்திக் கொண்டே ஏணியில் ஏறும் சாகச முறையைக் கற்கவும்." }
    ],
    "Silambattam": [
        { title: "பிடி (கைப்பிடி)", icon: "fa-mitten", desc: "மூங்கில் கம்பை சரியான அழுத்தத்துடன் பிடிப்பது எப்படி என்று கற்றுக் கொள்ளுங்கள்." },
        { title: "அடைப்படை சுழற்சி", icon: "fa-sync-alt", desc: "முன்கை மற்றும் மணிக்கட்டு வலிமையை வளர்க்கும் அடிப்படை சுழல் முறை." },
        { title: "தற்காப்பு நிலை", icon: "fa-user-shield", desc: "தாக்குதலைத் தடுக்கும் மற்றும் பின்வாங்கும் அடிப்படைத் தற்காப்பு நிலைகள்." },
        { title: "கால்ப்பாடம்", icon: "fa-running", desc: "முக்கோண வடிவில் கால்களை நகர்த்தி எதிரியை எதிர்கொள்ளும் முறையைக் கற்கவும்." }
    ],
    "Kavadi Attam": [
        { title: "காவடி சுமத்தல்", icon: "fa-weight-hanging", desc: "தோள்களில் காவடியைச் சமள்ளையாகச் சுமக்கப் பழகுங்கள்." },
        { title: "முறை 1: நடை பயிற்சி", icon: "fa-shoe-prints", desc: "காவடி சுமந்து கொண்டே தாளத்திற்கு ஏற்ப நடக்கும் பயிற்சி." },
        { title: "முறை 2: சுழற்சி முறை", icon: "fa-sync", desc: "காவடியைச் சுழற்றி ஆடும் முறையைக் கற்கவும்." },
        { title: "முறை 3: வளைந்து ஆடுதல்", icon: "fa-redo", desc: "காவடியுடன் முன்னும் பின்னும் வளைந்து ஆடும் பாவனைகள்." }
    ],
    "Kummi": [
        { title: "முறை 1: தாள கைதட்டல்", icon: "fa-hands", desc: "வட்டத்தில் நின்று தாளத்திற்கு ஏற்ப கைகளைத் தட்டும் முறையைக் கற்கவும்." },
        { title: "முறை 2: வட்ட நடை", icon: "fa-walking", desc: "வட்ட வடிவத்தைப் பராமரிக்கும் போது தாள நடையைப் பயிற்சி செய்யுங்கள்." },
        { title: "முறை 3: பாடல் ஒருங்கிணைப்பு", icon: "fa-music", desc: "நாட்டுப்புறப் பாடல்களுடன் கைதட்டலை ஒருங்கிணைக்கக் கற்றுக்கொள்ளுங்கள்." },
        { title: "முறை 4: தாள வேகம்", icon: "fa-tachometer-alt", desc: "பாடல் வேகம் அதிகரிக்கும் போது கைதட்டல் மற்றும் நடையின் வேகத்தை அதிகரிக்கவும்." }
    ],
    "Therukoothu": [
        { title: "முறை 1: வீரக் குரல்", icon: "fa-microphone-alt", desc: "காவியக் கதைகளைச் சொல்லப் பயன்படும் உரத்த குரலில் பாடும் முறையைப் பயிற்சி செய்யுங்கள்." },
        { title: "முறை 2: நாடகப் பிரவேசம்", icon: "fa-running", desc: "தெருக்கூத்துக்கே உரிய துடிப்பான மேடைப் பிரவேசத்தை மாஸ்டர் செய்யுங்கள்." },
        { title: "முறை 3: ஒப்பனை பாவனைகள்", icon: "fa-mask", desc: "அலங்கார ஆடைகளுக்கு ஏற்ற கனமான காலடிகள் மற்றும் நிலைகளைக் கற்கவும்." },
        { title: "முறை 4: கதை பாவனைகள்", icon: "fa-theater-masks", desc: "முகபாவனைகள் மூலம் கதையின் உணர்ச்சிகளை வெளிப்படுத்தும் முறையைப் பயிற்சி செய்யுங்கள்." }
    ],
    "Puliyattam": [
        { title: "முறை 1: புலி நடை", icon: "fa-paw", desc: "புலி இரையைத் தேடிச் செல்வது போன்ற பதுங்கல் முறையைப் பயிற்சி செய்யுங்கள்." },
        { title: "முறை 2: பாய்ச்சல் பயிற்சி", icon: "fa-bolt", desc: "புலியின் துடிப்பான பாய்ச்சல் மற்றும் தாவும் முறையைக் கற்கவும்." },
        { title: "முறை 3: உறுமல் பாவனை", icon: "fa-volume-up", desc: "உடல் அசைவுகளுடன் புலியின் உறுமலை ஒருங்கிணைக்கும் முறையைப் பயிற்சி செய்யுங்கள்." },
        { title: "முறை 4: தாள வேகம்", icon: "fa-drum", desc: "தப்பு மேளத் தாளத்திற்கு ஏற்ப அதிவேகமாக புலி போல ஆடும் முறை." }
    ],
    "Bommalattam": [
        { title: "முறை 1: அடிப்படை இயக்கம்", icon: "fa-fingerprint", desc: "பொம்மைகளின் கை மற்றும் தலை அசைவுகளைக் கட்டுப்படுத்தக் கற்றுக் கொள்ளுங்கள்." },
        { title: "முறை 2: பொம்மை நடை", icon: "fa-shoe-prints", desc: "பொம்மைகளை மேடையில் தாளமாக நடக்க வைக்கும் கலையில் தேர்ச்சி பெறுங்கள்." },
        { title: "முறை 3: கதை சொல்லும் பாவனைகள்", icon: "fa-theater-masks", desc: "பல்வேறு உணர்ச்சிகளைப் பிரதிபலிக்கும் பொம்மை நிலைகளைக் கற்கவும்." },
        { title: "முறை 4: குரல் ஒருங்கிணைப்பு", icon: "fa-microphone", desc: "பொம்மைகளின் அசைவுகளுடன் குரல் மாற்றங்களை ஒருங்கிணைக்கக் கற்றுக்கொள்ளுங்கள்." }
    ],
    "Villu Paatu": [
        { title: "முறை 1: வில் அடி", icon: "fa-hands", desc: "சிறிய குச்சிகளைக் கொண்டு வில் நாணின் மீது தாளமாக அடிப்பது எப்படி என்று கற்கவும்." },
        { title: "முறை 2: கதை சொல்லும் வேகம்", icon: "fa-mouth", desc: "வில்லின் தாளத்தை வரலாற்று கதை சொல்லும் வேகத்துடன் ஒருங்கிணைக்கவும்." },
        { title: "முறை 3: குழு நேரம்", icon: "fa-users", desc: "மற்ற இசைக்கலைஞர்களுடன் இணைந்து தாளத்தைப் பயிற்சி செய்யுங்கள்." },
        { title: "முறை 4: உணர்ச்சி வெளிப்பாடு", icon: "fa-smile-beam", desc: "கதையின் உணர்ச்சிகளுக்கு ஏற்ப குரல் மற்றும் முகபாவனைகளை மாற்றியமைக்கக் கற்றுக்கொள்ளுங்கள்." }
    ],
    "Kolattam": [
        { title: "முறை 1: அடிப்படை அடி", icon: "fa-magic", desc: "துணையுடன் சேர்ந்து சிறிய குச்சிகளைத் தாளமாகத் தட்டுவதைக் கற்கவும்." },
        { title: "முறை 2: பின்னல் நடை", icon: "fa-random", desc: "நடனக் கலைஞர்கள் வட்டத்தில் உள்ளேயும் வெளியேயும் பின்னிச் செல்லும் சிக்கலான நடை பயிற்சி." },
        { title: "முறை 3: அதிவேகத் தாளம்", icon: "fa-bolt", desc: "தவில் வேகம் அதிகரிக்கும் போது குச்சிகளை வேகமாகத் தட்டும் முறையில் தேர்ச்சி பெறுங்கள்." },
        { title: "முறை 4: குழு ஒருங்கிணைப்பு", icon: "fa-users", desc: "பல நடனக் கலைஞர்களுடன் இணைந்து சிக்கலான வடிவங்களை உருவாக்கக் கற்றுக்கொள்ளுங்கள்." }
    ],
    "Oyillattam": [
        { title: "முறை 1: துண்டு ஆட்டம்", icon: "fa-mitten", desc: "கைகளில் வண்ணத் துண்டுகளைப் பிடித்துத் தாளமாக அசைப்பதைக் கற்கவும்." },
        { title: "முறை 2: ஒயில் நடை", icon: "fa-walking", desc: "குழுவாக வரிசையாக நின்று கம்பீரமாக அடியெடுத்து வைக்கும் முறையைப் பயிற்சி செய்யுங்கள்." },
        { title: "முறை 3: தாள ஒருங்கிணைப்பு", icon: "fa-drum", desc: "தவில் மற்றும் தாளத்திற்கு ஏற்ப அசைவுகளை ஒருங்கிணைக்கவும்." },
        { title: "முறை 4: குழு உருவாக்கம்", icon: "fa-object-group", desc: "நடனக் கலைஞர்கள் பல்வேறு வடிவங்களை உருவாக்கும் முறையைக் கற்கவும்." }
    ],
    "Poikkal Kuthirai": [
        { title: "முறை 1: மரக்கால் நடை", icon: "fa-socks", desc: "மரக்கால்களைக் கட்டி குதிரை போல நடக்கும் பயிற்சியைத் தொடங்குங்கள்." },
        { title: "முறை 2: குதிரை அசைவு", icon: "fa-horse", desc: "குதிரையின் ஓட்டம் மற்றும் துள்ளலை உடல் அசைவுகள் மூலம் பிரதிபலிக்கவும்." },
        { title: "முறை 3: சமநிலை ஆட்டம்", icon: "fa-balance-scale", desc: "மரக்கால்களுடன் தாளத்திற்கு ஏற்ப வேகமாக ஆடும்போது சமநிலையைப் பராமரிக்கவும்." },
        { title: "முறை 4: கதை சொல்லும் பாவனைகள்", icon: "fa-theater-masks", desc: "குதிரை அசைவுகளுடன் கதை சொல்லும் பாவனைகளை ஒருங்கிணைக்கக் கற்றுக்கொள்ளுங்கள்." }
    ],
    "Mayil Aattam": [
        { title: "முறை 1: தோகை விரித்தல்", icon: "fa-feather-alt", desc: "மயில் தோகை விரிப்பது போன்ற பாவனைகளை மாஸ்டர் செய்யுங்கள்." },
        { title: "முறை 2: மயில் நடை", icon: "fa-walking", desc: "மயிலின் மென்மையான மற்றும் அழகான நடைமுறையைப் பயிற்சி செய்யுங்கள்." },
        { title: "முறை 3: தாளக் கொத்து", icon: "fa-music", desc: "மயில் அசைவுகளைத் தாளக்கருவிகளுடன் ஒருங்கிணைக்கக் கற்றுக்கொள்ளுங்கள்." },
        { title: "முறை 4: உணவு தேடும் பாவனை", icon: "fa-seedling", desc: "மயில் உணவு தேடுவது போன்ற மென்மையான அசைவுகளைப் பயிற்சி செய்யுங்கள்." }
    ],
    "Devaraattam": [
        { title: "முறை 1: தேவ துந்துபி தாளம்", icon: "fa-drum", desc: "தேவ துந்துபியின் வேகமான தாளத்திற்கு ஏற்ப அடியெடுத்து வைக்கவும்." },
        { title: "முறை 2: குழு சுழற்சி", icon: "fa-sync", desc: "குழுவாகச் சேர்ந்து தாளத்திற்கு ஏற்ப வேகமாகச் சுழலும் பயிற்சி." },
        { title: "முறை 3: வீர ஆட்டம்", icon: "fa-shield-alt", desc: "இந்த நடனத்திற்கே உரிய கம்பீரமான மற்றும் வீரமான பாவனைகளைக் கற்கவும்." },
        { title: "முறை 4: போர் பாவனைகள்", icon: "fa-fist-raised", desc: "போர் வீரர்களின் அசைவுகள் மற்றும் தற்காப்பு நிலைகளைப் பயிற்சி செய்யுங்கள்." }
    ],
    "Paampu Attam": [
        { title: "முறை 1: பாம்பு ஊர்தல்", icon: "fa-snake", desc: "தரை மட்டத்தில் பாம்பின் வளைந்து நெளிந்து செல்லும் இயக்கத்தைப் பயிற்சி செய்யுங்கள்." },
        { title: "முறை 2: படம் எடுத்தல்", icon: "fa-user-ninja", desc: "பாம்பு படம் எடுப்பது போன்ற உடல் நிலைகள் மற்றும் பாவனைகளை கற்கவும்." },
        { title: "முறை 3: தாள வளைவு", icon: "fa-undo", desc: "மகுடி இசைக்கு ஏற்ப உடல் முழுவதையும் வளைத்து ஆடும் கலையை மாஸ்டர் செய்யுங்கள்." },
        { title: "முறை 4: இரட்டைப் பாம்பு", icon: "fa-grip-lines", desc: "இரண்டு பாம்புகள் பின்னிப் பிணைந்து ஆடுவது போன்ற அசைவுகளைப் பயிற்சி செய்யுங்கள்." }
    ],
    "Paraiattam": [
        { title: "முறை 1: பறை அடி", icon: "fa-drum", desc: "பறை கருவியை லாவகமாகப் பிடித்து தாளமிடுவதைக் கற்றுக் கொள்ளுங்கள்." },
        { title: "முறை 2: ஆட்டக் காலடி", icon: "fa-shoe-prints", desc: "பறையடித்தவாறே தாளத்திற்கு ஏற்ப துள்ளிக் குதித்து ஆடும் பயிற்சி." },
        { title: "முறை 3: குழு முழக்கம்", icon: "fa-users", desc: "பல கலைஞர்களுடன் இணைந்து ஒரே நேரத்தில் பறையடித்து ஆடும் ஒருங்கிணைப்பு." },
        { title: "முறை 4: பறை சத்தம்", icon: "fa-volume-up", desc: "பறையின் பல்வேறு சத்தங்களை உருவாக்கி, தாளத்திற்கு ஏற்ப மாற்றியமைக்கக் கற்றுக்கொள்ளுங்கள்." }
    ]
};

const localMethodsData = {
    "Bharatanatyam": [
        { title: "Araimandi Position", icon: "fa-universal-access", desc: "The basic position where heels are together and knees point sideways. It creates stability." },
        { title: "Hasta Mudras", icon: "fa-hand-paper", desc: "Learn single-hand gestures used to tell stories and represent nature." },
        { title: "Adavu Footwork", icon: "fa-shoe-prints", desc: "Master the coordination of hands and feet in specific rhythmic patterns." },
        { title: "Abhinaya Expressions", icon: "fa-smile", desc: "Practice expressing emotions (Rasas) through precise facial muscle movements." }
    ],
    "Karakattam": [
        { title: "Method 1: Head Balance", icon: "fa-heading", desc: "Learn to balance the brass pot (karakam) on your head with correct posture." },
        { title: "Method 2: Rhythmic Walk", icon: "fa-walking", desc: "Practice synchronized body movements while keeping the pot perfectly still." },
        { title: "Method 3: Rapid Spins", icon: "fa-sync", desc: "Execute 360-degree fast spins while maintaining core balance." },
        { title: "Method 4: Ladder Stunts", icon: "fa-level-up-alt", desc: "Learn the advanced technique of climbing a ladder while balancing the pot." }
    ],
    "Silambattam": [
        { title: "Method 1: The Grip", icon: "fa-mitten", desc: "Learn how to hold the bamboo staff with the right tension and finger positioning." },
        { title: "Method 2: Basic Twirls", icon: "fa-sync-alt", desc: "Master 360-degree defensive and offensive twirling techniques." },
        { title: "Method 3: Footwork Bases", icon: "fa-user-shield", desc: "Learn the 4-step triangle footwork essential for martial combat mobility." },
        { title: "Method 4: Combat Strikes", icon: "fa-khanda", desc: "Practice high and low strikes with the staff targeting virtual opponents." }
    ],
    "Kavadi Attam": [
        { title: "Method 1: Kavadi Balance", icon: "fa-weight-hanging", desc: "Learn to balance the decorative Kavadi on your shoulders with correct posture." },
        { title: "Method 2: Rhythmic Steps", icon: "fa-shoe-prints", desc: "Practice the specific swaying footwork that matches the Kavadi Chindu music." },
        { title: "Method 3: Pivot Turns", icon: "fa-sync", desc: "Master graceful rotations while carrying the Kavadi to enhance its visual appeal." },
        { title: "Method 4: Swaying Motion", icon: "fa-redo", desc: "Learn the forward and backward swaying movements that signify religious ecstasy." }
    ],
    "Kummi": [
        { title: "Method 1: Rhythmic Clap", icon: "fa-hands", desc: "Learn the essential synchronized clapping patterns performed in a circle." },
        { title: "Method 2: Circling Walk", icon: "fa-walking", desc: "Practice the rhythmic side-stepping movement while maintaining the circle formation." },
        { title: "Method 3: Song Coordination", icon: "fa-music", desc: "Learn to coordinate hand claps with the traditional folk songs sung by the performers." },
        { title: "Method 4: Tempo Increase", icon: "fa-tachometer-alt", desc: "Practice maintaining perfect clap synchronization as the song's tempo gradually increases." }
    ],
    "Therukoothu": [
        { title: "Method 1: Epic Voice", icon: "fa-microphone-alt", desc: "Practice the high-pitched, loud singing style used to tell epic stories." },
        { title: "Method 2: Dramatic Entry", icon: "fa-running", desc: "Master the energetic and loud entry onto the stage typical of street theater." },
        { title: "Method 3: Mask & Makeup Poses", icon: "fa-mask", desc: "Learn the heavy footwork and stances that complement the elaborate costumes." },
        { title: "Method 4: Narrative Gestures", icon: "fa-theater-masks", desc: "Master the hand and face gestures used to represent characters like Kings, Demons, or Gods." }
    ],
    "Puliyattam": [
        { title: "Method 1: Tiger Stealth", icon: "fa-paw", desc: "Mimic the low, stealthy movements of a tiger stalking its prey." },
        { title: "Method 2: The Leap", icon: "fa-bolt", desc: "Master the sudden, energetic leaps and bounds of the tiger Spirit." },
        { title: "Method 3: Rhythmic Growls", icon: "fa-volume-up", desc: "Coordinate body movements with ferocious sound effects and heavy drum beats." },
        { title: "Method 4: Drum Speed Hunt", icon: "fa-drum", desc: "Execute rapid hunting sequences following the accelerated tempo of the 'Thappu' drums." }
    ],
    "Bommalattam": [
        { title: "Method 1: Basic Manipulation", icon: "fa-fingerprint", desc: "Learn how to control puppet strings for basic arm and head movements." },
        { title: "Method 2: Puppet Walking", icon: "fa-shoe-prints", desc: "Master the art of making the puppet appear to walk rhythmically on stage." },
        { title: "Method 3: Storytelling Poses", icon: "fa-theater-masks", desc: "Learn static poses that represent different emotions for the puppets." },
        { title: "Method 4: Voice Modulation", icon: "fa-microphone", desc: "Practice modulating your voice to match different puppet characters and emotions." }
    ],
    "Villu Paatu": [
        { title: "Method 1: Bow Striking", icon: "fa-hands", desc: "Learn the rhythmic striking of the long bow string with small sticks." },
        { title: "Method 2: Narrative Flow", icon: "fa-mouth", desc: "Coordinate the rhythm of the bow with the pace of historical storytelling." },
        { title: "Method 3: Ensemble Timing", icon: "fa-users", desc: "Practice timing with other percussionists in the Villu Paatu group." },
        { title: "Method 4: Emotional Pitch", icon: "fa-grin-stars", desc: "Practice changing your vocal pitch to match the dramatic turns in the villu story." }
    ],
    "Kolattam": [
        { title: "Method 1: Basic Strike", icon: "fa-magic", desc: "Learn the synchronized striking of wooden sticks with a partner." },
        { title: "Method 2: Weaving Movement", icon: "fa-random", desc: "Practice the complex movement of dancers weaving in and out of a circle." },
        { title: "Method 3: High-Speed Rhythm", icon: "fa-bolt", desc: "Master the rapid-fire stick strikes as the drum tempo increases." },
        { title: "Method 4: Double Strike", icon: "fa-sync", desc: "Learn to perform overhead and underhand double strikes while rotating positions." }
    ],
    "Oyillattam": [
        { title: "Method 1: Kerchief Waves", icon: "fa-mitten", desc: "Learn the rhythmic waving of colorful kerchiefs in each hand." },
        { title: "Method 2: Graceful Row Walk", icon: "fa-walking", desc: "Practice moving in a row with elegant and synchronized steps." },
        { title: "Method 3: Drum Coordination", icon: "fa-drum", desc: "Master the coordination between foot steps and the heavy drum beats." },
        { title: "Method 4: Group Weave", icon: "fa-object-group", desc: "Learn how the rows of dancers weave through each other without breaking the rhythmic flow." }
    ],
    "Poikkal Kuthirai": [
        { title: "Method 1: Stilt Walking", icon: "fa-socks", desc: "Practice walking on wooden stilts associated with the horse dance." },
        { title: "Method 2: Equine Movement", icon: "fa-horse", desc: "Mimic the galloping and trotting movements of a horse through body language." },
        { title: "Method 3: Balanced Dance", icon: "fa-balance-scale", desc: "Maintain balance while performing rapid spins and steps on stilts." },
        { title: "Method 4: Heroic Poses", icon: "fa-shield-alt", desc: "Master the majestic and heroic stances that represent legendary horse riders." }
    ],
    "Mayil Aattam": [
        { title: "Method 1: Plumage Display", icon: "fa-feather-alt", desc: "Master the poses that mimic the opening of a peacock's feathers." },
        { title: "Method 2: Elegant Pecking", icon: "fa-walking", desc: "Practice the gentle, bird-like head movements and picking steps." },
        { title: "Method 3: The Peacock Spright", icon: "fa-music", desc: "Coordinate graceful peacock movements with the rhythm of pipes and drums." },
        { title: "Method 4: Foraging Flow", icon: "fa-seedling", desc: "Mimic a peacock searching for food with delicate and rhythmic floor movements." }
    ],
    "Devaraattam": [
        { title: "Method 1: Dundubi Rhythm", icon: "fa-drum", desc: "Learn to step in sync with the high-speed 'Deva Dundubi' drum beats." },
        { title: "Method 2: Group Rotations", icon: "fa-sync", desc: "Practice fast-paced circular movements as a synchronized group." },
        { title: "Method 3: Majestic Stances", icon: "fa-shield-alt", desc: "Master the powerful and regal poses unique to this celestial dance." },
        { title: "Method 4: Warrior Spirits", icon: "fa-fist-raised", desc: "Embody the fierce and ancient warrior spirits through aggressive yet rhythmic limb movements." }
    ],
    "Paampu Attam": [
        { title: "Method 1: Slithering Flow", icon: "fa-snake", desc: "Practice the fluid, wave-like body movements on the ground floor." },
        { title: "Method 2: Cobra Hood Poses", icon: "fa-user-ninja", desc: "Learn the hand and body gestures mimicking a cobra with a raised hood." },
        { title: "Method 3: Magudi Response", icon: "fa-undo", desc: "Coordinate full-body flexibility with the hypnotic notes of the magudi pipe." },
        { title: "Method 4: The Coil & Strike", icon: "fa-grip-lines", desc: "Master the sudden coiling and defensive striking movements characteristic of a guardian snake." }
    ],
    "Paraiattam": [
        { title: "Method 1: Parai Striking", icon: "fa-drum", desc: "Learn the basic techniques for holding and striking the ancient Parai drum." },
        { title: "Method 2: Energetic Footwork", icon: "fa-shoe-prints", desc: "Practice the leaps and energetic steps performed while drumming." },
        { title: "Method 3: Ensemble Roar", icon: "fa-users", desc: "Coordinate rhythmic patterns with a large group of fellow Parai drummers." },
        { title: "Method 4: Sonic Resilience", icon: "fa-volume-up", desc: "Learn to maintain complex rhythmic variants while maintaining extreme physical intensity." }
    ]
};

// ==================== CULTURE DETAILS DATA ====================
window.cultureData = {
    'en': {
        'Bharatanatyam': 'Bharatanatyam is a major form of Indian classical dance that originated in Tamil Nadu. It is one of the oldest classical dance traditions in India and is known for its fixed upper torso, bent legs, and knees flexed (Araimandi) combined with spectacular footwork and a sophisticated vocabulary of sign language based on gestures of hands, eyes, and face muscles.',
        'Karakattam': 'Karakattam is an ancient folk dance of Tamil Nadu performed in praise of the rain goddess Mariamman. The performers balance a pot (Karakam) on their head. Traditionally, this dance is categorized into two types: Sakthi Karakam, performed in temples as a spiritual offering, and Aatta Karakam, performed for entertainment.',
        'Silambattam': 'Silambattam is a weapon-based Indian martial art originating from Tamil Nadu. It is one of the oldest martial arts in the world. The name refers to the sound of the bamboo staff which is the primary weapon used. It involves complex footwork, spins, and rhythmic strikes.',
        'Kavadi Attam': 'Kavadi Attam is a ceremonial sacrifice and offering practiced by devotees during the worship of Lord Murugan. It involves carrying a "Kavadi" (a semi-circular decorated canopy) on the shoulders, often accompanied by rhythmic singing known as Kavadi Chindu.',
        'Puliyattam': 'Puliyattam (Tiger Dance) is a folk dance performed in Tamil Nadu during festivals. Performers paint their bodies with yellow and black stripes to look like tigers and wear masks. The dance mimics the stealthy movements and pounces of a tiger to the beat of heavy drums.',
        'Therukoothu': 'Therukoothu is an ancient form of street theater performed in the villages of Tamil Nadu. It usually depicts epic stories from the Mahabharata and Ramayana. It combines song, music, dance, and drama with elaborate costumes and heavy makeup.',
        'Kummi': 'Kummi is one of the most important and ancient forms of village dances of Tamil Nadu. It originated when there were no musical instruments, with the participants providing the rhythm by clapping their hands. It is usually performed by women in a circle.',
        'Oyillattam': 'Oyillattam (Dance of Grace) is a traditional dance where performers wear colorful small towels on their hands and perform rhythmic steps to the accompaniment of drums. It was traditionally a male dance but is now performed by all.',
        'Bommalattam': 'Bommalattam (Puppet Show) is a traditional puppet theater from Tamil Nadu. It uses large puppets controlled by strings and wires. The stories are usually based on folklore or religious epics.',
        'Villu Paatu': 'Villu Paatu (Bow Song) is an ancient form of musical story-telling. The lead singer uses a large bow decorated with bells as a primary musical instrument. The songs usually tell stories of local heroes or mythical events.',
        'Kolattam': 'Kolattam is an ancient village art performed with small wooden sticks. Dancers strike their sticks against each other or their partners sticks in rhythmic patterns while moving in circles or complex formations.',
        'Poikkal Kuthirai': 'Poikkal Kuthirai (Fake Leg Horse) is a folk dance where performers carry a dummy horse shell around their waist. They wear wooden stilts and mimic the graceful movements of a horse, often telling stories of legendary heroes.',
        'Mayil Aattam': 'Mayil Aattam (Peacock Dance) is a traditional dance where performers dress as peacocks with a beak and a tail of feathers. The movements are choreographed to mimic the graceful gestures and turns of a peacock.',
        'Devaraattam': 'Devaraattam (Dance of the Devas) is a pure rhythmic folk dance performed by the Rajakambalam Nayakar community. It is performed to the beat of the "Urumi" and "Dundubi" drums and is characterized by its powerful energy.',
        'Paampu Attam': 'Paampu Attam (Snake Dance) is a folk dance where performers wear a body-tight suit that looks like a snake skin. They mimic the slithering, creeping, and posing movements of a cobra to the music of the Magudi.',
        'Paraiattam': 'Paraiattam is a traditional dance involving the Parai, one of the oldest drums in India. The dance is characterized by energetic leaps and fast rhythmic patterns, historically used to announce messages or celebrate festivals.'
    },
    'ta': {
        'Bharatanatyam': 'பரதநாட்டியம் தமிழ்நாட்டில் தோன்றிய ஒரு முக்கிய இந்திய செவ்வியல் நடனமாகும். இது இந்தியாவின் பழமையான செவ்வியல் நடன மரபுகளில் ஒன்றாகும். இது நிலையான மேல் உடல், வளைந்த கால்கள் மற்றும் முழங்கால்கள் (அரைமண்டி) ஆகியவற்றுடன் வியக்கத்தக்க காலடி மற்றும் கைகள், கண்கள் மற்றும் முக தசைகளின் சைகைகளை அடிப்படையாகக் கொண்ட ஒரு அதிநவீன சைகை மொழிக்காக அறியப்படுகிறது.',
        'Karakattam': 'கரகாட்டம் என்பது மழைக்கடவுளான மாரியம்மனைப் போற்றி ஆடப்படும் தமிழ்நாட்டின் ஒரு பழமையான நாட்டுப்புற நடனமாகும். நடனக் கலைஞர்கள் தங்கள் தலையில் ஒரு செம்பை (கரகம்) சமநிலைப்படுத்துகிறார்கள். பாரம்பரியமாக, இந்த நடனம் இரண்டு வகைகளாகப் பிரிக்கப்படுகிறது: சக்தி கரகம், கோவில்களில் ஆன்மீக காணிக்கையாக ஆடப்படுகிறது, மற்றும் ஆட்ட கரகம், பொழுதுபோக்கிற்காக ஆடப்படுகிறது.',
        'Silambattam': 'சிலம்பாட்டம் என்பது தமிழ்நாட்டைச் சேர்ந்த ஒரு ஆயுதம் சார்ந்த இந்திய தற்காப்புக் கலையாகும். இது உலகின் பழமையான தற்காப்புக் கலைகளில் ஒன்றாகும். முதன்மை ஆயுதமாகப் பயன்படுத்தப்படும் மூங்கில் கம்பின் ஒலியைக் குறிக்கிறது. இதில் சிக்கலான காலடி, சுழற்சிகள் மற்றும் தாளத் தாக்குதல்கள் அடங்கும்.',
        'Kavadi Attam': 'காவடி ஆட்டம் என்பது முருகனை வழிபடும் போது பக்தர்கள் செய்யும் ஒரு சடங்கு பலி மற்றும் காணிக்கையாகும். இது தோள்களில் ஒரு "காவடியை" (அரை வட்ட வடிவ அலங்கரிக்கப்பட்ட விதானம்) சுமந்து செல்வதை உள்ளடக்கியது, பெரும்பாலும் காவடிச் சிந்து என்று அழைக்கப்படும் தாளப் பாடலுடன் இருக்கும்.',
        'Puliyattam': 'புலியாட்டம் என்பது பண்டிகைகளின் போது தமிழ்நாட்டில் ஆடப்படும் ஒரு நாட்டுப்புற நடனமாகும். நடனக் கலைஞர்கள் புலிகளைப் போலத் தோற்றமளிக்கத் தங்கள் உடலில் மஞ்சள் மற்றும் கறுப்பு நிறக் கோடுகளை வரைந்து முகமூடி அணிகிறார்கள். கனமான மேளத் தாளங்களுக்கு ஏற்ப புலியின் பதுங்கல் மற்றும் பாய்ச்சல்களை இந்த நடனம் பிரதிபலிக்கிறது.',
        'Therukoothu': 'தெருக்கூத்து என்பது தமிழ்நாட்டின் கிராமங்களில் ஆடப்படும் ஒரு பழமையான வீதி நாடகமாகும். இது பொதுவாக மகாபாரதம் மற்றும் இராமாயணத்தின் இதிகாசக் கதைகளை சித்தரிக்கிறது. இது விரிவான உடைகள் மற்றும் கனமான ஒப்பனையுடன் பாடல், இசை, நடனம் மற்றும் நாடகத்தை ஒருங்கிணைக்கிறது.',
        'Kummi': 'கும்மி என்பது தமிழ்நாட்டின் மிக முக்கியமான மற்றும் பழமையான கிராமிய நடன வடிவங்களில் ஒன்றாகும். இசைக்கருவிகள் இல்லாத காலத்தில், பங்கேற்பாளர்கள் கைகளைத் தட்டி தாளத்தை வழங்கியபோது இது உருவானது. இது பொதுவாக பெண்கள் ஒரு வட்டத்தில் ஆடுகிறார்கள்.',
        'Oyillattam': 'ஒயிலாட்டம் என்பது ஒரு பாரம்பரிய நடனமாகும், இதில் நடனக் கலைஞர்கள் தங்கள் கைகளில் வண்ணமயமான சிறிய துண்டுகளை அணிந்துகொண்டு மேளத் தாளங்களுக்கு ஏற்ப தாள நடைகளை ஆடுகிறார்கள். இது பாரம்பரியமாக ஆண்களின் நடனமாக இருந்தது, ஆனால் இப்போது அனைவரும் ஆடுகிறார்கள்.',
        'Bommalattam': 'பொம்மலாட்டம் என்பது தமிழ்நாட்டின் ஒரு பாரம்பரிய பொம்மை நாடகமாகும். இது நூல்கள் மற்றும் கம்பிகளால் கட்டுப்படுத்தப்படும் பெரிய பொம்மைகளைப் பயன்படுத்துகிறது. கதைகள் பொதுவாக நாட்டுப்புறக் கதைகள் அல்லது மத இதிகாசங்களை அடிப்படையாகக் கொண்டவை.',
        'Villu Paatu': 'வில்லுப்பாட்டு என்பது இசை வழி கதை சொல்லும் ஒரு பழமையான வடிவமாகும். முக்கியப் பாடகர் மணிகளால் அலங்கரிக்கப்பட்ட ஒரு பெரிய வில்லை முதன்மையான இசைக் கருவியாகப் பயன்படுத்துகிறார். பாடல்கள் பொதுவாக உள்ளூர் நாயகர்கள் அல்லது புராண நிகழ்வுகளின் கதைகளைச் சொல்கின்றன.',
        'Kolattam': 'கோலாட்டம் என்பது சிறிய மரக் குச்சிகளைக் கொண்டு ஆடப்படும் ஒரு பழமையான கிராமியக் கலையாகும். நடனக் கலைஞர்கள் வட்டமாக அல்லது சிக்கலான அமைப்புகளில் நகரும்போது தங்கள் குச்சிகளை ஒருவரையொருவர் அல்லது தங்கள் கூட்டாளியின் குச்சிகளுடன் தாளமாகத் தட்டுகிறார்கள்.',
        'Poikkal Kuthirai': 'பொய்க்கால் குதிரை ஆட்டம் என்பது நடனக் கலைஞர்கள் இடுப்பில் ஒரு பொய்க் குதிரையைச் சுமந்து கொண்டு ஆடும் ஒரு நாட்டுப்புற நடனமாகும். அவர்கள் மரக்கால்களை அணிந்து குதிரையின் கம்பீரமான அசைவுகளைப் பிரதிபலிக்கிறார்கள்.',
        'Mayil Aattam': 'மயிலாட்டம் என்பது நடனக் கலைஞர்கள் மயில் போன்ற ஆடை அணிந்து ஆடும் ஒரு பாரம்பரிய நடனமாகும். மயிலின் அழகான அசைவுகள் மற்றும் சுழற்சிகளைப் பிரதிபலிக்கும் வகையில் இது அமைகிறது.',
        'Devaraattam': 'தேவராட்டம் என்பது ராஜகம்பளம் நாயக்கர் சமூகத்தினரால் ஆடப்படும் ஒரு தூய தாள நாட்டுப்புற நடனமாகும். இது "உருமி" மற்றும் "துந்துபி" மேளங்களின் தாளத்திற்கு ஏற்ப ஆடப்படுகிறது.',
        'Paampu Attam': 'பாம்பு ஆட்டம் என்பது நடனக் கலைஞர்கள் பாம்புத் தோல் போன்ற ஆடை அணிந்து ஆடும் ஒரு நடனமாகும். மகுடி இசைக்கு ஏற்ப பாம்பின் நெளிவு மற்றும் படம் எடுக்கும் அசைவுகளை அவர்கள் செய்கிறார்கள்.',
        'Paraiattam': 'பறையாட்டம் என்பது இந்தியாவின் பழமையான வாத்தியமான பறையை முழங்கி ஆடப்படும் ஒரு பாரம்பரிய நடனமாகும். இது துடிப்பான துள்ளல்கள் மற்றும் வேகமான தாளங்களைக் கொண்டுள்ளது.'
    }
};

// ==================== API SERVICE ====================
class TamilCultureAPI {
    constructor() {
        this.baseURL = API_BASE_URL;
        this.useBackend = USE_JAVA_BACKEND;
    }

    async getTrainingMethods(danceFormName) {
        const currentLang = localStorage.getItem('selectedLanguage') || 'en';
        if (!this.useBackend) {
            console.log('📦 Using local data (Java backend disabled)');
            if (currentLang === 'ta') {
                return Promise.resolve(localMethodsDataTamil[danceFormName] || localMethodsData[danceFormName] || []);
            }
            return Promise.resolve(localMethodsData[danceFormName] || []);
        }

        try {
            console.log("🌐 Fetching from Java backend: " + this.baseURL + "/danceforms/" + danceFormName + "/training");
            const response = await fetch(this.baseURL + "/danceforms/" + encodeURIComponent(danceFormName) + "/training");

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();
            console.log('✓ Data received from Java backend');

            return data.map(method => ({
                title: method.title,
                icon: method.icon,
                desc: method.description,
                refImg: method.referenceImageUrl
            }));
        } catch (error) {
            console.error('✗ Java backend error, falling back to local data:', error);
            const fallback = currentLang === 'ta' ?
                (localMethodsDataTamil[danceFormName] || localMethodsData[danceFormName]) :
                localMethodsData[danceFormName];
            return fallback || [];
        }
    }
}

// ==================== TRAINING MANAGER ====================
class TrainingManager {
    constructor(api) {
        this.api = api;
        this.currentDanceForm = null;
        this.currentStep = 0;
        this.trainingMethods = [];
    }

    async startTraining(danceFormName) {
        console.log("🎯 Starting training for: " + danceFormName);

        // Fetch training methods
        this.trainingMethods = await this.api.getTrainingMethods(danceFormName);

        if (!this.trainingMethods || this.trainingMethods.length === 0) {
            console.error('❌ No training methods found');
            alert('Training methods not available for this dance form.');
            return;
        }

        this.currentDanceForm = danceFormName;
        this.currentStep = 0;

        console.log("✓ Loaded " + this.trainingMethods.length + " training methods");

        // Show training view
        if (typeof switchView === 'function') {
            switchView('training');
        }

        this.displayCurrentMethod();
    }

    displayCurrentMethod() {
        if (this.currentStep >= this.trainingMethods.length) {
            this.completeTraining();
            return;
        }

        const method = this.trainingMethods[this.currentStep];
        const currentLang = localStorage.getItem('selectedLanguage') || 'en';
        const t = window.translations ? window.translations[currentLang] : {};

        console.log(`📖 Displaying method ${this.currentStep + 1}: ${method.title}`);

        // Update UI elements
        const localizedDanceName = t[this.currentDanceForm.toLowerCase().replace(/\s/g, '')] || this.currentDanceForm;
        const trainingLabel = currentLang === 'ta' ? 'பயிற்சி' : 'Training';
        this.updateElement('training-culture-name', `${localizedDanceName} ${trainingLabel}`);

        const methodLabel = currentLang === 'ta' ? 'முறை' : 'Method';
        const ofLabel = currentLang === 'ta' ? '-இல்' : 'of';
        this.updateElement('method-step-count', `${methodLabel} ${this.currentStep + 1} ${ofLabel} ${this.trainingMethods.length}`);

        this.updateElement('method-title', method.title);
        this.updateElement('method-desc', method.desc);

        // Update icon
        const iconElement = document.getElementById('method-icon');
        if (iconElement) {
            iconElement.className = `fas ${method.icon}`;
        }

        // Load reference image
        this.loadReferenceImage(method.refImg);

        // Update progress dots
        this.updateProgressDots();
    }

    updateElement(id, text) {
        const element = document.getElementById(id);
        if (element) {
            element.textContent = text;
        }
    }

    loadReferenceImage(imageUrl) {
        const refImg = document.getElementById('method-ref-img');
        const icon = document.getElementById('method-icon');

        if (!refImg || !icon) {
            console.warn('⚠️ Image elements not found in DOM');
            return;
        }

        if (!imageUrl) {
            console.log('ℹ️ No reference image for this method');
            refImg.style.display = 'none';
            icon.style.display = 'block';
            return;
        }

        console.log('🖼️ Loading reference image:', imageUrl);

        refImg.style.display = 'none';
        icon.style.display = 'block';
        refImg.src = imageUrl;

        refImg.onload = () => {
            console.log('✓ Image loaded successfully!');
            refImg.style.display = 'block';
            icon.style.display = 'none';
        };

        refImg.onerror = (e) => {
            console.error('✗ Image failed to load:', imageUrl);
            refImg.style.display = 'none';
            icon.style.display = 'block';
        };
    }

    updateProgressDots() {
        const dotsContainer = document.getElementById('method-dots-container');
        if (!dotsContainer) return;

        dotsContainer.innerHTML = '';

        for (let i = 0; i < this.trainingMethods.length; i++) {
            const dot = document.createElement('div');
            dot.style.width = '8px';
            dot.style.height = '8px';
            dot.style.borderRadius = '50%';
            dot.style.background = i <= this.currentStep ? 'var(--secondary)' : 'rgba(255,255,255,0.2)';
            dotsContainer.appendChild(dot);
        }
    }

    nextMethod() {
        console.log(`➡️ Moving to next method (current: ${this.currentStep + 1})`);
        this.currentStep++;
        this.displayCurrentMethod();
    }

    completeTraining() {
        console.log("🎉 Training completed for " + this.currentDanceForm + "!");
        const currentLang = localStorage.getItem('selectedLanguage') || 'en';
        const msg = currentLang === 'ta' ? "வாழ்த்துகள்! நீங்கள் " + this.currentDanceForm + " பயிற்சியை முடித்துவிட்டீர்கள்!" : "Congratulations! You've completed " + this.currentDanceForm + " training!";
        alert(msg);

        if (typeof openExperience === 'function') {
            openExperience(this.currentDanceForm);
        } else if (typeof switchView === 'function') {
            switchView('home');
        }
    }

    launchMethodExperience(mode) {
        if (!this.currentDanceForm || this.trainingMethods.length === 0) return;

        const method = this.trainingMethods[this.currentStep];

        if (mode === 'XR') {
            if (typeof connectToUnity === 'function') {
                connectToUnity(this.currentDanceForm, method.title);
            } else {
                alert(`Starting XR Experience: ${this.currentDanceForm} - ${method.title}`);
            }
            if (typeof recordActivity === 'function') {
                recordActivity(this.currentDanceForm + " - " + method.title + " (XR)");
            }
        } else {
            const msg = localStorage.getItem('selectedLanguage') === 'ta' ? "AR காட்சியைத் தொடங்குகிறது " + this.currentDanceForm + ": " + method.title + "... உங்கள் கேமராவை ஒரு தட்டையான மேற்பரப்பில் காட்டுங்கள்!" : "Opening AR View for " + this.currentDanceForm + ": " + method.title + "... Point your camera at a flat surface!";
            alert(msg);
            if (typeof recordActivity === 'function') {
                recordActivity(this.currentDanceForm + " - " + method.title + " (AR)");
            }
        }
    }
}

// ==================== OVERRIDE/ENHANCE GLOBAL switchView ====================
// We wrap the existing switchView if it exists, or define it to handle nav highlighting
const originalSwitchView = window.switchView;
window.switchView = function (viewName) {
    if (typeof originalSwitchView === 'function') {
        originalSwitchView(viewName);
    } else {
        // Fallback implementation if viewer.html's switchView isn't globally available yet
        document.querySelectorAll('.view-section').forEach(el => {
            el.classList.remove('view-active');
            el.removeAttribute('style'); // Remove entire style attribute to override !important
        });
        const v = document.getElementById('view-' + viewName);
        if (v) {
            v.classList.add('view-active');
            v.removeAttribute('style'); // Remove style attribute so CSS takes over
        }

        document.querySelectorAll('.nav-item').forEach(el => el.classList.remove('active'));
        const n = document.getElementById('nav-' + viewName);
        if (n) n.classList.add('active');

        window.location.hash = viewName;
        window.scrollTo(0, 0);
    }

    // Ensure navigation items are updated correctly
    document.querySelectorAll('.nav-item').forEach(el => el.classList.remove('active'));
    const navItem = document.getElementById('nav-' + viewName);
    if (navItem) navItem.classList.add('active');
};

// ==================== GLOBAL INSTANCES ====================
const api = new TamilCultureAPI();
const trainingManager = new TrainingManager(api);

// ==================== GLOBAL FUNCTIONS (for HTML onclick handlers) ====================
window.startTraining = function (danceFormName) {
    trainingManager.startTraining(danceFormName);
};

window.nextMethod = function () {
    trainingManager.nextMethod();
};

window.launchMethodExperience = function (mode) {
    trainingManager.launchMethodExperience(mode);
};

// ==================== INITIALIZATION ====================
document.addEventListener('DOMContentLoaded', () => {
    console.log('==============================================');
    console.log('🎭 Tamil Culture Heritage Platform');
    console.log('📡 Mode: ' + (USE_JAVA_BACKEND ? 'Java Backend' : 'Local Data'));
    console.log('==============================================');

    const savedLang = localStorage.getItem('selectedLanguage') || 'en';
    if (savedLang !== 'en') {
        setTimeout(() => {
            if (typeof window.changeLanguage === 'function') {
                window.changeLanguage(savedLang);
            }
        }, 100);
    }

    if (USE_JAVA_BACKEND) {
        console.log("🔗 Java API: " + API_BASE_URL);
    } else {
        console.log('📦 Using local JavaScript data');
    }
    console.log('==============================================');
});

// ==================== UI HELPERS ====================

window.toggleHeaderMenu = function (event) {
    if (event) event.stopPropagation();
    const menu = document.getElementById('header-menu');
    if (!menu) return;

    const isVisible = menu.style.display === 'flex';
    menu.style.display = isVisible ? 'none' : 'flex';

    if (menu.style.display === 'flex') {
        const closeHandler = (e) => {
            const icon = document.getElementById('hamburger-menu-icon');
            if (menu && !menu.contains(e.target) && (!icon || !icon.contains(e.target))) {
                menu.style.display = 'none';
                document.removeEventListener('click', closeHandler);
            }
        };
        setTimeout(() => document.addEventListener('click', closeHandler), 10);
    }
};

window.setGender = function (gender) {
    localStorage.setItem('userGender', gender);

    // Update Header Menu Checks
    const headerChecks = document.querySelectorAll('[id^="header-gender-check-"]');
    headerChecks.forEach(icon => {
        icon.style.opacity = '0';
    });
    const headerCheck = document.getElementById('header-gender-check-' + gender);
    if (headerCheck) {
        headerCheck.style.opacity = '1';
    }
};

// Initialize dynamic views
document.addEventListener('DOMContentLoaded', () => {
    // Highlight current
    const g = localStorage.getItem('userGender');
    if (g) setTimeout(() => window.setGender(g), 500); // Delay to ensure DOM is ready
});

// ==================== QUIZ LOGIC ====================
const quizQuestions = [
    { q: "Which dance is performed with a pot balanced on the head?", options: ["Oyilattam", "Karakattam", "Mayil Aattam"], ans: 1 },
    { q: "What is the primary instrument used in Silambattam?", options: ["Bamboo Staff", "Sword", "Short Stick"], ans: 0 },
    { q: "Which dance involves dummy horses?", options: ["Poikkal Kuthirai", "Puliyattam", "Kavadi Attam"], ans: 0 },
    { q: "Which art form uses puppets to tell stories?", options: ["Villu Paatu", "Therukoothu", "Bommalattam"], ans: 2 },
    { q: "Which dance is performed in honor of Lord Murugan?", options: ["Kavadi Attam", "Devaraattam", "Kummi"], ans: 0 }
];

let currentQuizIndex = 0;
let quizScore = 0;
let currentCorrectIndex = -1;

function shuffleOptions(options, correctIdx) {
    let indices = options.map((_, i) => i);
    for (let i = indices.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [indices[i], indices[j]] = [indices[j], indices[i]];
    }
    
    let shuffled = indices.map(i => options[i]);
    let newCorrectIdx = indices.indexOf(correctIdx);
    return { shuffled, newCorrectIdx };
}

window.startQuiz = function () {
    console.log("Starting Quiz...");
    const intro = document.getElementById('quiz-intro');
    const active = document.getElementById('quiz-active');
    const result = document.getElementById('quiz-result');

    if (intro) intro.style.display = 'none';
    if (result) result.style.display = 'none';
    if (active) active.style.display = 'block';

    currentQuizIndex = 0;
    quizScore = 0;
    loadQuestion();
};

function loadQuestion() {
    if (currentQuizIndex >= quizQuestions.length) {
        showQuizResult();
        return;
    }

    const qData = quizQuestions[currentQuizIndex];
    const { shuffled, newCorrectIdx } = shuffleOptions(qData.options, qData.ans);
    currentCorrectIndex = newCorrectIdx;

    const qEl = document.getElementById('quiz-question');
    if (qEl) qEl.innerText = qData.q;

    // Update progress
    const progressEl = document.getElementById('quiz-progress');
    if (progressEl) progressEl.innerText = "Question " + (currentQuizIndex + 1) + "/" + quizQuestions.length;
    
    const scoreUi = document.getElementById('quiz-score-ui');
    if (scoreUi) scoreUi.innerText = "Score: " + (quizScore * 10);

    const pct = ((currentQuizIndex) / quizQuestions.length) * 100;
    const bar = document.getElementById('quiz-bar');
    if (bar) bar.style.width = pct + '%';

    const optsContainer = document.getElementById('quiz-options');
    if (optsContainer) {
        optsContainer.innerHTML = '';
        shuffled.forEach((opt, idx) => {
            const btn = document.createElement('button');
            btn.className = 'btn-secondary animate-fade-in';
            btn.style.width = '100%';
            btn.style.textAlign = 'left';
            btn.style.padding = '18px';
            btn.style.marginBottom = '12px';
            btn.style.borderRadius = '15px';
            btn.style.border = '1px solid var(--glass-border)';
            btn.style.background = 'var(--glass)';
            btn.style.color = 'var(--text-main)';
            btn.style.fontSize = '0.95rem';
            btn.style.transition = 'all 0.2s ease';
            btn.style.animationDelay = (idx * 0.1) + 's';
            btn.innerHTML = `<span style="display: flex; align-items: center; gap: 12px;">
                <span style="width: 28px; height: 28px; border-radius: 50%; background: rgba(255,255,255,0.05); display: flex; align-items: center; justify-content: center; font-size: 0.8rem; font-weight: 700; color: var(--secondary);">${String.fromCharCode(65 + idx)}</span>
                ${opt}
            </span>`;
            
            btn.onmouseover = () => {
                btn.style.background = 'rgba(255,255,255,0.08)';
                btn.style.borderColor = 'var(--secondary)';
                btn.style.transform = 'translateX(5px)';
            };
            btn.onmouseout = () => {
                btn.style.background = 'var(--glass)';
                btn.style.borderColor = 'var(--glass-border)';
                btn.style.transform = 'translateX(0)';
            };

            btn.onclick = () => handleAnswer(idx);
            optsContainer.appendChild(btn);
        });
    }
}

function handleAnswer(selectedIdx) {
    const qData = quizQuestions[currentQuizIndex];
    const opts = document.getElementById('quiz-options').children;

    if (selectedIdx === currentCorrectIndex) {
        opts[selectedIdx].style.background = 'rgba(76, 175, 80, 0.2)'; // Greenish
        opts[selectedIdx].style.borderColor = '#4caf50';
        opts[selectedIdx].style.color = '#4caf50';
        quizScore++;
    } else {
        opts[selectedIdx].style.background = 'rgba(244, 67, 54, 0.2)'; // Reddish
        opts[selectedIdx].style.borderColor = '#f44336';
        opts[selectedIdx].style.color = '#f44336';
        // Highlight correct one
        opts[currentCorrectIndex].style.background = 'rgba(76, 175, 80, 0.2)';
        opts[currentCorrectIndex].style.borderColor = '#4caf50';
        opts[currentCorrectIndex].style.color = '#4caf50';
    }

    // Disable all
    for (let b of opts) b.onclick = null;

    setTimeout(() => {
        currentQuizIndex++;
        loadQuestion();
    }, 1000);
}

function showQuizResult() {
    const active = document.getElementById('quiz-active');
    if (active) active.style.display = 'none';
    const resultDiv = document.getElementById('quiz-result');
    if (resultDiv) resultDiv.style.display = 'block';

    const scoreText = document.getElementById('result-score-text');
    const feedback = document.getElementById('result-feedback');

    const finalScore = quizScore * 10;
    if (scoreText) scoreText.innerText = "You scored " + finalScore + " / " + (quizQuestions.length * 10);

    if (feedback) {
        if (quizScore === quizQuestions.length) feedback.innerText = "Perfect! You are a Culture Master!";
        else if (quizScore >= quizQuestions.length / 2) feedback.innerText = "Good job! Keep exploring!";
        else feedback.innerText = "Nice try! Read more in Explore section.";
    }
}

window.toggleMenuContent = function (id) {
    let el = document.getElementById('menu-' + id + '-content');
    if (!el) {
        el = document.getElementById('menu-' + id);
    }

    const arrow = document.getElementById('arrow-' + id);
    if (!el) {
        console.error("Content element not found:", 'menu-' + id + '-content');
        return;
    }

    if (window.event) {
        window.event.stopPropagation();
    }

    if (el.style.display === 'none' || el.style.display === '') {
        el.style.display = 'block';
        if (arrow) arrow.style.transform = 'rotate(180deg)';
    } else {
        el.style.display = 'none';
        if (arrow) arrow.style.transform = 'rotate(0deg)';
    }
};
