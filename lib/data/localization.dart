const Map<String, Map<String, String>> translations = {
  'English': {
    // Navigation
    'Home': 'Home',
    'Explore': 'Explore',
    'Quiz': 'Quiz',
    'Profile': 'Profile',

    // Home Screen
    'Welcome Explorer!': 'Welcome Explorer!',
    'Discover Tamil heritage art forms': 'Discover Tamil heritage art forms',
    'Explore Cultures': 'Explore',
    'Dances': 'Dances',
    'Explore 16 Heritage Art Forms': 'Explore 16 Heritage Art Forms',
    'Celebrations': 'Celebrations',
    '6 Tamil Festivals & Events': '6 Tamil Festivals & Events',
    'Discovery Hub': 'Discovery Hub',
    'Cultural Quiz': 'Cultural Quiz',
    'Challenge': 'Challenge',
    'Guidelines': 'Guidelines',
    'My Progress': 'My Progress',
    'Spotlight': 'Spotlight',
    'Top Pick': 'Top Pick',

    // Explore Screen
    'Search dances...': 'Search dances...',
    'All': 'All',
    'Classical': 'Classical',
    'Folk': 'Folk',
    'Martial Arts': 'Martial Arts',
    'No dances found': 'No dances found',
    'View Details': 'View Details',

    // Detail Screen
    'About This Art Form': 'About This Art Form',
    'Learning Options': 'Learning Options',
    'Step-by-Step Training': 'Step-by-Step Training',
    'methods to master': 'methods to master',
    'Learning in AR View': 'Learning in AR View',
    'Augmented Reality Mode': 'Augmented Reality Mode',
    'Learning in VR Immersive': 'Learning in VR Immersive',
    'XR 3D Experience': 'XR 3D Experience',

    // Profile & Settings
    'My Profile': 'My Profile',
    'Dances Explored': 'Dances Explored',
    'Quiz Score': 'Quiz Score',
    'Days Active': 'Days Active',
    'General': 'General',
    'Language': 'Language',
    'Settings': 'Settings',
    'Dark Mode': 'Dark Mode',
    'More': 'More',
    'About App': 'About App',
    'Support': 'Support',
    'Log Out': 'Log Out',
    'Log Out?': 'Log Out?',
    'Are you sure you want to log out of your heritage journey?': 'Are you sure you want to log out of your heritage journey?',
    'Cancel': 'Cancel',

    // Rules
    'Learning Guidelines': 'Learning Guidelines',

    // App wide
    'Back to Home': 'Back to Home',
  },
  'Tamil': {
    // Navigation
    'Home': 'முகப்பு',
    'Explore': 'ஆராய்க',
    'Quiz': 'வினாடி வினா',
    'Profile': 'சுயவிவரம்',

    // Home Screen
    'Welcome Explorer!': 'வரவேற்கிறோம்!',
    'Discover Tamil heritage art forms': 'தமிழ் பாரம்பரிய கலைகளைக் கண்டறியுங்கள்',
    'Explore Cultures': 'கலாச்சாரங்கள்',
    'Dances': 'நடனங்கள்',
    'Explore 16 Heritage Art Forms': '16 பாரம்பரிய கலை வடிவங்களை ஆராயுங்கள்',
    'Celebrations': 'கொண்டாட்டங்கள்',
    '6 Tamil Festivals & Events': '6 தமிழ் திருவிழாக்கள்',
    'Discovery Hub': 'கண்டுபிடிப்பு மையம்',
    'Cultural Quiz': 'கலாச்சார வினாடி வினா',
    'Challenge': 'சவால்',
    'Guidelines': 'வழிகாட்டுதல்கள்',
    'My Progress': 'எனது முன்னேற்றம்',
    'Spotlight': 'சிறப்பம்சங்கள்',
    'Top Pick': 'சிறந்த தேர்வு',

    // Explore Screen
    'Search dances...': 'நடனங்களைத் தேடுக...',
    'All': 'அனைத்தும்',
    'Classical': 'செவ்வியல்',
    'Folk': 'நாட்டுப்புறம்',
    'Martial Arts': 'தற்காப்புக் கலைகள்',
    'No dances found': 'நடனங்கள் காணப்படவில்லை',
    'View Details': 'விவரங்களைப் பார்க்க',

    // Detail Screen
    'About This Art Form': 'இந்த கலை வடிவத்தைப் பற்றி',
    'Learning Options': 'கற்பதற்கான விருப்பங்கள்',
    'Step-by-Step Training': 'படிப்படியான பயிற்சி',
    'methods to master': 'பயிற்சி முறைகள்',
    'Learning in AR View': 'AR பார்வையில் கற்றல்',
    'Augmented Reality Mode': 'ஆக்மென்டட் ரியாலிட்டி',
    'Learning in VR Immersive': 'VR பார்வையில் கற்றல்',
    'XR 3D Experience': 'XR 3D அனுபவம்',

    // Profile & Settings
    'My Profile': 'எனது சுயவிவரம்',
    'Dances Explored': 'படித்த நடனங்கள்',
    'Quiz Score': 'வினாடி வினா மதிப்பெண்',
    'Days Active': 'செயல்பாட்டு நாட்கள்',
    'General': 'பொதுவானவை',
    'Language': 'மொழி',
    'Settings': 'அமைப்புகள்',
    'Dark Mode': 'இருண்ட முறை',
    'More': 'மேலும்',
    'About App': 'செயலியைப் பற்றி',
    'Support': 'ஆதரவு',
    'Log Out': 'வெளியேறு',
    'Log Out?': 'வெளியேறவா?',
    'Are you sure you want to log out of your heritage journey?': 'உங்கள் பாரம்பரியப் பயணத்திலிருந்து உறுதியாக வெளியேற விரும்புகிறீர்களா?',
    'Cancel': 'ரத்துசெய்',

    // Rules
    'Learning Guidelines': 'கற்றல் வழிகாட்டுதல்கள்',

    // App wide
    'Back to Home': 'முகப்பிற்குத் திரும்பு',
  }
};

String translate(String key, String language) {
  return translations[language]?[key] ?? key;
}
