import 'package:flutter/material.dart';

class CultureItem {
  final String name;
  final String nameTa;
  final String type;
  final String typeTa;
  final String emoji;
  final String description;
  final String descriptionTa;
  final Color color;
  final String assetFolder;
  final String imagePath;
  final String category;

  const CultureItem({
    required this.name,
    required this.nameTa,
    required this.type,
    required this.typeTa,
    required this.emoji,
    required this.description,
    required this.descriptionTa,
    required this.color,
    required this.assetFolder,
    required this.imagePath,
    required this.category,
  });

  /// Returns name in the given language
  String localName(String lang) => lang == 'Tamil' ? nameTa : name;

  /// Returns type/subtitle in the given language
  String localType(String lang) => lang == 'Tamil' ? typeTa : type;

  /// Returns full description in the given language
  String localDesc(String lang) => lang == 'Tamil' ? descriptionTa : description;
}

const List<CultureItem> allCultures = [
  CultureItem(
    name: 'Bharatanatyam',
    nameTa: 'பரதநாட்டியம்',
    type: 'Classical Dance',
    typeTa: 'செவ்வியல் நடனம்',
    emoji: '💃',
    category: 'Classical',
    assetFolder: 'bharatanatyam',
    imagePath: 'assets/images/dances/bharatanatyam.jpg',
    color: Color(0xFFE91E63),
    description:
        'Bharatanatyam is a major form of Indian classical dance that originated in Tamil Nadu. It is one of the oldest classical dance traditions in India and is known for its fixed upper torso, bent legs, and knees flexed (Araimandi) combined with spectacular footwork and a sophisticated vocabulary of sign language based on gestures of hands, eyes, and face muscles.',
    descriptionTa:
        'பரதநாட்டியம் தமிழ்நாட்டில் தோன்றிய இந்தியாவின் முக்கிய செவ்வியல் நடன வடிவங்களில் ஒன்றாகும். இது இந்தியாவின் மிகவும் பழமையான செவ்வியல் நடன மரபுகளில் ஒன்றாகும். இந்த நடனம் நேர்மையான மேல் உடல், வளைந்த கால்கள் மற்றும் முழங்கால்கள் மடிந்த அமர்மண்டி நிலை, அற்புதமான காலடி வேலை, மற்றும் கைகள், கண்கள் மற்றும் முக தசைகளின் சைகைகளை அடிப்படையாக கொண்ட சூட்சுமம் வாய்ந்த சைகை மொழி ஆகியவற்றிற்கு புகழ்பெற்றது.',
  ),
  CultureItem(
    name: 'Karakattam',
    nameTa: 'காரக்காட்டம்',
    type: 'Folk (Pot Balance)',
    typeTa: 'நாட்டுப்புற (குடம் தூக்கல்)',
    emoji: '🏺',
    category: 'Folk',
    assetFolder: 'karakattam',
    imagePath: 'assets/images/dances/karakattam.jpg',
    color: Color(0xFF009688),
    description:
        'Karakattam is an ancient folk dance of Tamil Nadu performed in praise of the rain goddess Mariamman. The performers balance a pot (Karakam) on their head. Traditionally, this dance is categorized into two types: Sakthi Karakam, performed in temples as a spiritual offering, and Aatta Karakam, performed for entertainment.',
    descriptionTa:
        'காரக்காட்டம் தமிழ்நாட்டின் மழை தேவியான மாரியம்மனை போற்றி செய்யப்படும் பண்டைய நாட்டுப்புற நடனமாகும். நடிகர்கள் தங்கள் தலையில் ஒரு குடம் (காரகம்) வைத்து சமன் செய்வார்கள். இந்த நடனம் பாரம்பரியமாக இரண்டு வகைகளாக வகைப்படுத்தப்படுகிறது: ஆலயங்களில் ஆன்மீக காணிக்கையாக நிகழ்த்தப்படும் சக்தி காரகம், மற்றும் பொழுதுபோக்கிற்காக நிகழ்த்தப்படும் ஆட்ட காரகம்.',
  ),
  CultureItem(
    name: 'Silambattam',
    nameTa: 'சிலம்பாட்டம்',
    type: 'Traditional Martial Arts',
    typeTa: 'பாரம்பரிய தற்காப்பு கலை',
    emoji: '⚔️',
    category: 'Martial Arts',
    assetFolder: 'silambattam',
    imagePath: 'assets/images/dances/silambattam.jpg',
    color: Color(0xFFFF5722),
    description:
        'Silambattam is a weapon-based Indian martial art originating from Tamil Nadu. It is one of the oldest martial arts in the world. The name refers to the sound of the bamboo staff which is the primary weapon used. It involves complex footwork, spins, and rhythmic strikes.',
    descriptionTa:
        'சிலம்பாட்டம் தமிழ்நாட்டிலிருந்து தோன்றிய ஆயுதம் சார்ந்த இந்திய தற்காப்பு கலையாகும். இது உலகின் மிக பழமையான தற்காப்பு கலைகளில் ஒன்றாகும். இந்த பெயர் பயன்படுத்தப்படும் முதன்மை ஆயுதமான மூங்கில் தடியின் ஒலியை குறிக்கிறது. இது சிக்கலான காலடி வேலை, சுழல்கள் மற்றும் தாளமான தாக்குதல்களை உள்ளடக்கியது.',
  ),
  CultureItem(
    name: 'Kavadi Attam',
    nameTa: 'காவடி ஆட்டம்',
    type: 'Devotional Celebration',
    typeTa: 'பக்தி விழா நடனம்',
    emoji: '🕉️',
    category: 'Folk',
    assetFolder: 'kavadiattam',
    imagePath: 'assets/images/dances/kavadi_attam.jpg',
    color: Color(0xFF673AB7),
    description:
        'Kavadi Attam is a ceremonial sacrifice and offering practiced by devotees during the worship of Lord Murugan. It involves carrying a "Kavadi" (a semi-circular decorated canopy) on the shoulders, often accompanied by rhythmic singing known as Kavadi Chindu.',
    descriptionTa:
        'காவடி ஆட்டம் என்பது முருகப்பெருமான் வழிபாட்டின் போது பக்தர்களால் செய்யப்படும் சடங்கு தியாகம் மற்றும் காணிக்கையாகும். இதில் தோள்களில் "காவடி" (அரை வட்ட வடிவ அலங்கரிக்கப்பட்ட கோபுரம்) தூக்குவது அடங்கும், இது பெரும்பாலும் காவடி சிந்து என்று அழைக்கப்படும் தாளமான பாடலுடன் இணைந்திருக்கும்.',
  ),
  CultureItem(
    name: 'Puliyattam',
    nameTa: 'புலியாட்டம்',
    type: 'Tiger Spirit Dance',
    typeTa: 'புலி ஆவி நடனம்',
    emoji: '🐯',
    category: 'Folk',
    assetFolder: 'puliyattam',
    imagePath: 'assets/images/dances/puliyattam.jpg',
    color: Color(0xFFFFA000),
    description:
        'Puliyattam (Tiger Dance) is a folk dance performed in Tamil Nadu during festivals. Performers paint their bodies with yellow and black stripes to look like tigers and wear masks. The dance mimics the stealthy movements and pounces of a tiger to the beat of heavy drums.',
    descriptionTa:
        'புலியாட்டம் (புலி நடனம்) தமிழ்நாட்டில் திருவிழாக்களின் போது நிகழ்த்தப்படும் ஒரு நாட்டுப்புற நடனமாகும். நடிகர்கள் புலிகளைப் போல தோற்றமளிக்க மஞ்சள் மற்றும் கறுப்பு கோடுகளால் உடலை வர்ணம் பூசி முகமூடிகளை அணிவார்கள். இந்த நடனம் கனமான மேளத்தின் தாளத்திற்கு புலியின் திருட்டுத்தனமான அசைவுகள் மற்றும் பாய்ச்சல்களை பின்பற்றுகிறது.',
  ),
  CultureItem(
    name: 'Therukoothu',
    nameTa: 'தெருக்கூத்து',
    type: 'Ancient Street Theater',
    typeTa: 'பண்டைய தெரு நாடகம்',
    emoji: '🎭',
    category: 'Folk',
    assetFolder: 'therukoothu',
    imagePath: 'assets/images/dances/therukoothu.jpg',
    color: Color(0xFF1976D2),
    description:
        'Therukoothu is an ancient form of street theater performed in the villages of Tamil Nadu. It usually depicts epic stories from the Mahabharata and Ramayana. It combines song, music, dance, and drama with elaborate costumes and heavy makeup.',
    descriptionTa:
        'தெருக்கூத்து என்பது தமிழ்நாட்டின் கிராமங்களில் நிகழ்த்தப்படும் தெரு நாடகத்தின் பண்டைய வடிவமாகும். இது பொதுவாக மகாபாரதம் மற்றும் ராமாயணத்திலிருந்து மகாகாவிய கதைகளை சித்தரிக்கிறது. இது விரிவான உடை மற்றும் கனமான ஒப்பனையுடன் பாடல், இசை, நடனம் மற்றும் நாடகம் ஆகியவற்றை ஒருங்கிணைக்கிறது.',
  ),
  CultureItem(
    name: 'Kummi',
    nameTa: 'கும்மி',
    type: 'Rhythmic Clap Dance',
    typeTa: 'தாளமான கைதட்டல் நடனம்',
    emoji: '👏',
    category: 'Folk',
    assetFolder: 'kummi',
    imagePath: 'assets/images/dances/kummi.jpg',
    color: Color(0xFF388E3C),
    description:
        'Kummi is one of the most important and ancient forms of village dances of Tamil Nadu. It originated when there were no musical instruments, with the participants providing the rhythm by clapping their hands. It is usually performed by women in a circle.',
    descriptionTa:
        'கும்மி தமிழ்நாட்டின் கிராம நடனங்களின் மிக முக்கியமான மற்றும் பண்டைய வடிவங்களில் ஒன்றாகும். இசைக் கருவிகள் இல்லாத காலத்தில் தோன்றியது, பங்கேற்பாளர்கள் கைதட்டி தாளம் வழங்குவார்கள். இது பொதுவாக பெண்களால் வட்டமாக நிகழ்த்தப்படுகிறது.',
  ),
  CultureItem(
    name: 'Oyillattam',
    nameTa: 'ஒயிலாட்டம்',
    type: 'Folk Dance of Grace',
    typeTa: 'அழகு நாட்டுப்புற நடனம்',
    emoji: '🧣',
    category: 'Folk',
    assetFolder: 'oyillattam',
    imagePath: 'assets/images/dances/oyillattam.jpg',
    color: Color(0xFF0288D1),
    description:
        'Oyillattam (Dance of Grace) is a traditional dance where performers wear colorful small towels on their hands and perform rhythmic steps to the accompaniment of drums. It was traditionally a male dance but is now performed by all.',
    descriptionTa:
        'ஒயிலாட்டம் (அழகு நடனம்) ஒரு பாரம்பரிய நடனமாகும், இதில் நடிகர்கள் தங்கள் கைகளில் வண்ணமயமான சிறிய துண்டுகளை அணிந்து மேளத்தின் இசையுடன் தாளமான அடிகளை நிகழ்த்துவார்கள். இது பாரம்பரியமாக ஆண்களின் நடனமாக இருந்தது ஆனால் இப்போது அனைவராலும் நிகழ்த்தப்படுகிறது.',
  ),
  CultureItem(
    name: 'Bommalattam',
    nameTa: 'பொம்மலாட்டம்',
    type: 'Traditional Puppetry',
    typeTa: 'பாரம்பரிய பொம்மை ஆட்டம்',
    emoji: '🎎',
    category: 'Folk',
    assetFolder: 'bommalattam',
    imagePath: 'assets/images/dances/bommalattam.jpg',
    color: Color(0xFF5C6BC0),
    description:
        'Bommalattam (Puppet Show) is a traditional puppet theater from Tamil Nadu. It uses large puppets controlled by strings and wires. The stories are usually based on folklore or religious epics.',
    descriptionTa:
        'பொம்மலாட்டம் (பொம்மை நாடகம்) தமிழ்நாட்டிலிருந்து வந்த ஒரு பாரம்பரிய பொம்மை வடிவ நாடகமாகும். இது கயிறுகள் மற்றும் கம்பிகளால் கட்டுப்படுத்தப்படும் பெரிய பொம்மைகளை பயன்படுத்துகிறது. கதைகள் பொதுவாக நாட்டுப்புற கதைகள் அல்லது மத காவியங்களை அடிப்படையாக கொண்டவை.',
  ),
  CultureItem(
    name: 'Villu Paatu',
    nameTa: 'வில்லுப்பாட்டு',
    type: 'Bowing Storytelling',
    typeTa: 'வில் கதைப்பாடல்',
    emoji: '🏹',
    category: 'Folk',
    assetFolder: 'villupaatu',
    imagePath: 'assets/images/dances/villu_paatu.jpg',
    color: Color(0xFFD32F2F),
    description:
        'Villu Paatu (Bow Song) is an ancient form of musical story-telling. The lead singer uses a large bow decorated with bells as a primary musical instrument. The songs usually tell stories of local heroes or mythical events.',
    descriptionTa:
        'வில்லுப்பாட்டு (வில் பாடல்) இசை கதைசொல்லும் பண்டைய வடிவமாகும். முன்னணி பாடகர் மணிகளால் அலங்கரிக்கப்பட்ட ஒரு பெரிய வில்லை முதன்மை இசைக் கருவியாக பயன்படுத்துகிறார். பாடல்கள் பொதுவாக உள்ளூர் வீரர்கள் அல்லது புராண நிகழ்வுகளின் கதைகளை சொல்கின்றன.',
  ),
  CultureItem(
    name: 'Kolattam',
    nameTa: 'கோலாட்டம்',
    type: 'Stick Dance',
    typeTa: 'கோல் நடனம்',
    emoji: '🪄',
    category: 'Folk',
    assetFolder: 'kolattam',
    imagePath: 'assets/images/dances/kolattam.jpg',
    color: Color(0xFF7B1FA2),
    description:
        'Kolattam is an ancient village art performed with small wooden sticks. Dancers strike their sticks against each other or their partners sticks in rhythmic patterns while moving in circles or complex formations.',
    descriptionTa:
        'கோலாட்டம் சிறிய மரக்கோல்களுடன் செய்யப்படும் பண்டைய கிராம கலையாகும். நடனக்காரர்கள் வட்டங்களில் அல்லது சிக்கலான அமைப்புகளில் நகரும்போது தாளமான வடிவங்களில் தங்கள் கோல்களை ஒருவரின் கோலுக்கு எதிராக அடிக்கிறார்கள்.',
  ),
  CultureItem(
    name: 'Poikkal Kuthirai Attam',
    nameTa: 'பொய்க்கால் குதிரையாட்டம்',
    type: 'Dummy Horse Dance',
    typeTa: 'போலி குதிரை நடனம்',
    emoji: '🐎',
    category: 'Folk',
    assetFolder: 'poikkalkuthirai',
    imagePath: 'assets/images/dances/poikkal_kuthirai.jpg',
    color: Color(0xFF5D4037),
    description:
        'Poikkal Kuthirai (Fake Leg Horse) is a folk dance where performers carry a dummy horse shell around their waist. They wear wooden stilts and mimic the graceful movements of a horse, often telling stories of legendary heroes.',
    descriptionTa:
        'பொய்க்கால் குதிரையாட்டம் (போலி கால் குதிரை) ஒரு நாட்டுப்புற நடனமாகும், இதில் நடிகர்கள் தங்கள் இடுப்பைச் சுற்றி போலி குதிரை ஓடு தூக்குவார்கள். அவர்கள் மரக் கால்களை அணிந்து குதிரையின் அழகான அசைவுகளை பின்பற்றுவார்கள், பெரும்பாலும் புகழ்பெற்ற வீரர்களின் கதைகளை சொல்வார்கள்.',
  ),
  CultureItem(
    name: 'Mayil Aattam',
    nameTa: 'மயிலாட்டம்',
    type: 'Peacock Dance',
    typeTa: 'மயில் நடனம்',
    emoji: '🦚',
    category: 'Folk',
    assetFolder: 'mayilaattam',
    imagePath: 'assets/images/dances/mayil_aattam.jpg',
    color: Color(0xFF00838F),
    description:
        'Mayil Aattam (Peacock Dance) is a traditional dance where performers dress as peacocks with a beak and a tail of feathers. The movements are choreographed to mimic the graceful gestures and turns of a peacock.',
    descriptionTa:
        'மயிலாட்டம் (மயில் நடனம்) ஒரு பாரம்பரிய நடனமாகும், இதில் நடிகர்கள் அலகு மற்றும் இறகுகளின் வால் கொண்ட மயில்களாக உடை தரிப்பார்கள். அசைவுகள் மயிலின் அழகான சைகைகள் மற்றும் திரும்பல்களை பின்பற்ற ஒத்திகை செய்யப்படுகின்றன.',
  ),
  CultureItem(
    name: 'Devaraattam',
    nameTa: 'தேவராட்டம்',
    type: 'Celebratory Victory Dance',
    typeTa: 'வெற்றி கொண்டாட்ட நடனம்',
    emoji: '🛡️',
    category: 'Folk',
    assetFolder: 'devaraattam',
    imagePath: 'assets/images/dances/devaraattam.jpg',
    color: Color(0xFFF57F17),
    description:
        'Devaraattam (Dance of the Devas) is a pure rhythmic folk dance performed by the Rajakambalam Nayakar community. It is performed to the beat of the "Urumi" and "Dundubi" drums and is characterized by its powerful energy.',
    descriptionTa:
        'தேவராட்டம் (தேவர்களின் நடனம்) ராஜகம்பளம் நாயக்கர் சமூகத்தினர் நிகழ்த்தும் தூய தாளமான நாட்டுப்புற நடனமாகும். இது "உறுமி" மற்றும் "துந்துபி" மேளங்களின் தாளத்திற்கு நிகழ்த்தப்படுகிறது மற்றும் அதன் சக்திவாய்ந்த ஆற்றலால் வகைப்படுத்தப்படுகிறது.',
  ),
  CultureItem(
    name: 'Paampu Attam',
    nameTa: 'பாம்பாட்டம்',
    type: 'Snake Dance',
    typeTa: 'பாம்பு நடனம்',
    emoji: '🐍',
    category: 'Folk',
    assetFolder: 'paampuattam',
    imagePath: 'assets/images/dances/paampu_attam.jpg',
    color: Color(0xFF558B2F),
    description:
        'Paampu Attam (Snake Dance) is a folk dance where performers wear a body-tight suit that looks like a snake skin. They mimic the slithering, creeping, and posing movements of a cobra to the music of the Magudi.',
    descriptionTa:
        'பாம்பாட்டம் (பாம்பு நடனம்) ஒரு நாட்டுப்புற நடனமாகும், இதில் நடிகர்கள் பாம்பின் தோலைப் போல தோற்றமளிக்கும் இறுக்கமான உடலாடையை அணிவார்கள். மகுடி இசைக்கு நாகத்தின் வழுக்கும், ஊர்வும் மற்றும் போஸ் கொடுக்கும் அசைவுகளை பின்பற்றுவார்கள்.',
  ),
  CultureItem(
    name: 'Paraiattam',
    nameTa: 'பறையாட்டம்',
    type: 'Energetic Drum Dance',
    typeTa: 'ஆற்றல்மிக்க மேள நடனம்',
    emoji: '🥁',
    category: 'Folk',
    assetFolder: 'paraiattam',
    imagePath: 'assets/images/dances/paraiattam.jpg',
    color: Color(0xFFE64A19),
    description:
        'Paraiattam is a traditional dance involving the Parai, one of the oldest drums in India. The dance is characterized by energetic leaps and fast rhythmic patterns, historically used to announce messages or celebrate festivals.',
    descriptionTa:
        'பறையாட்டம் என்பது இந்தியாவின் மிகவும் பழமையான மேளங்களில் ஒன்றான பறையை உள்ளடக்கிய ஒரு பாரம்பரிய நடனமாகும். இந்த நடனம் ஆற்றல்மிக்க தாண்டல்கள் மற்றும் வேகமான தாளமான வடிவங்களால் வகைப்படுத்தப்படுகிறது, வரலாற்று ரீதியாக செய்திகளை அறிவிக்க அல்லது திருவிழாக்களை கொண்டாட பயன்படுத்தப்பட்டது.',
  ),
];
