class TrainingMethod {
  final String title;
  final String description;
  final String icon; // FontAwesome class name for reference

  const TrainingMethod({
    required this.title,
    required this.description,
    required this.icon,
  });
}

// Training methods indexed by dance name - extracted from app-logic.js
const Map<String, List<TrainingMethod>> trainingData = {
  'Bharatanatyam': [
    TrainingMethod(
      title: 'Araimandi Position',
      icon: 'fa-universal-access',
      description:
          'The basic position where heels are together and knees point sideways. It creates stability. Practice holding this stance for 30 seconds at a time.',
    ),
    TrainingMethod(
      title: 'Hasta Mudras',
      icon: 'fa-hand-paper',
      description:
          'Learn single-hand gestures used to tell stories and represent nature. There are 28 Asamyuta Hastas (single-hand gestures) to master.',
    ),
    TrainingMethod(
      title: 'Adavu Footwork',
      icon: 'fa-shoe-prints',
      description:
          'Master the coordination of hands and feet in specific rhythmic patterns. Practice Tatta Adavu (stamping) as your very first step.',
    ),
    TrainingMethod(
      title: 'Abhinaya Expressions',
      icon: 'fa-smile',
      description:
          'Practice expressing emotions (Rasas) through precise facial muscle movements. The 9 Rasas include Shringara (love), Hasya (joy), Karuna (compassion), and more.',
    ),
  ],
  'Karakattam': [
    TrainingMethod(
      title: 'Head Balance',
      icon: 'fa-heading',
      description:
          'Learn to balance the brass pot (karakam) on your head with correct posture. Start with an empty pot and gradually add flowers and decorations.',
    ),
    TrainingMethod(
      title: 'Rhythmic Walk',
      icon: 'fa-walking',
      description:
          'Practice synchronized body movements while keeping the pot perfectly still. Focus on your center of gravity and core strength.',
    ),
    TrainingMethod(
      title: 'Rapid Spins',
      icon: 'fa-sync',
      description:
          'Execute 360-degree fast spins while maintaining core balance. Spot a fixed point in front of you to avoid dizziness.',
    ),
    TrainingMethod(
      title: 'Ladder Stunts',
      icon: 'fa-level-up-alt',
      description:
          'Learn the advanced technique of climbing a ladder while balancing the pot. This is an advanced skill only practiced after months of preparation.',
    ),
  ],
  'Silambattam': [
    TrainingMethod(
      title: 'The Grip',
      icon: 'fa-mitten',
      description:
          'Learn how to hold the bamboo staff with the right tension and finger positioning. The grip should be firm but relaxed — not tight.',
    ),
    TrainingMethod(
      title: 'Basic Twirls',
      icon: 'fa-sync-alt',
      description:
          'Master 360-degree defensive and offensive twirling techniques using wrist rotation to build speed and control.',
    ),
    TrainingMethod(
      title: 'Footwork Bases',
      icon: 'fa-user-shield',
      description:
          'Learn the 4-step triangle footwork essential for martial combat mobility. Never cross your legs while moving.',
    ),
    TrainingMethod(
      title: 'Combat Strikes',
      icon: 'fa-khanda',
      description:
          'Practice high and low strikes with the staff targeting virtual opponents. Always lead with the tip, never the handle.',
    ),
  ],
  'Kavadi Attam': [
    TrainingMethod(
      title: 'Kavadi Balance',
      icon: 'fa-weight-hanging',
      description:
          'Learn to balance the decorative Kavadi on your shoulders with correct posture. Distribute the weight evenly on both sides.',
    ),
    TrainingMethod(
      title: 'Rhythmic Steps',
      icon: 'fa-shoe-prints',
      description:
          'Practice the specific swaying footwork that matches the Kavadi Chindu music — a two-step sway in sync with the beats.',
    ),
    TrainingMethod(
      title: 'Pivot Turns',
      icon: 'fa-sync',
      description:
          'Master graceful rotations while carrying the Kavadi to enhance its visual appeal. Turn slowly, keeping your body stable.',
    ),
    TrainingMethod(
      title: 'Swaying Motion',
      icon: 'fa-redo',
      description:
          'Learn the forward and backward swaying movements that signify religious ecstasy and devotion to Lord Murugan.',
    ),
  ],
  'Puliyattam': [
    TrainingMethod(
      title: 'Tiger Stealth',
      icon: 'fa-paw',
      description:
          'Mimic the low, stealthy movements of a tiger stalking its prey. Lower your center of gravity and move in slow deliberate steps.',
    ),
    TrainingMethod(
      title: 'The Leap',
      icon: 'fa-bolt',
      description:
          'Master the sudden, energetic leaps and bounds of the tiger spirit. Build leg strength with jumping exercises first.',
    ),
    TrainingMethod(
      title: 'Rhythmic Growls',
      icon: 'fa-volume-up',
      description:
          'Coordinate body movements with ferocious sound effects and heavy drum beats for a truly immersive tiger performance.',
    ),
    TrainingMethod(
      title: 'Drum Speed Hunt',
      icon: 'fa-drum',
      description:
          'Execute rapid hunting sequences following the accelerated tempo of the Thappu drums. Practice accelerating your movements with the rhythm.',
    ),
  ],
  'Therukoothu': [
    TrainingMethod(
      title: 'Epic Voice',
      icon: 'fa-microphone-alt',
      description:
          'Practice the high-pitched, loud singing style used to tell epic stories outdoors. Project your voice from your diaphragm, not your throat.',
    ),
    TrainingMethod(
      title: 'Dramatic Entry',
      icon: 'fa-running',
      description:
          'Master the energetic and loud entry onto the stage typical of street theater. Every character has a unique signature entry.',
    ),
    TrainingMethod(
      title: 'Mask & Makeup Poses',
      icon: 'fa-mask',
      description:
          'Learn the heavy footwork and stances that complement the elaborate costumes. The costume itself informs how you move.',
    ),
    TrainingMethod(
      title: 'Narrative Gestures',
      icon: 'fa-theater-masks',
      description:
          'Master the hand and face gestures used to represent characters like Kings, Demons, or Gods in the Therukoothu tradition.',
    ),
  ],
  'Kummi': [
    TrainingMethod(
      title: 'Rhythmic Clap',
      icon: 'fa-hands',
      description:
          'Learn the essential synchronized clapping patterns performed in a circle. Clap with a cupped hand for a fuller sound.',
    ),
    TrainingMethod(
      title: 'Circling Walk',
      icon: 'fa-walking',
      description:
          'Practice the rhythmic side-stepping movement while maintaining the circle formation with your fellow dancers.',
    ),
    TrainingMethod(
      title: 'Song Coordination',
      icon: 'fa-music',
      description:
          'Learn to coordinate hand claps with the traditional folk songs sung by the performers. The rhythm tells you when to clap.',
    ),
    TrainingMethod(
      title: 'Tempo Increase',
      icon: 'fa-tachometer-alt',
      description:
          'Practice maintaining perfect clap synchronization as the song\'s tempo gradually increases towards the climax.',
    ),
  ],
  'Oyillattam': [
    TrainingMethod(
      title: 'Kerchief Waves',
      icon: 'fa-mitten',
      description:
          'Learn the rhythmic waving of colorful kerchiefs in each hand. The kerchief should flow gracefully, not be swung aggressively.',
    ),
    TrainingMethod(
      title: 'Graceful Row Walk',
      icon: 'fa-walking',
      description: 'Practice moving in a row with elegant and synchronized steps. All performers must move as one unit.',
    ),
    TrainingMethod(
      title: 'Drum Coordination',
      icon: 'fa-drum',
      description: 'Master the coordination between foot steps and the heavy drum beats of the Udukku and Parai instruments.',
    ),
    TrainingMethod(
      title: 'Group Weave',
      icon: 'fa-object-group',
      description:
          'Learn how the rows of dancers weave through each other without breaking the rhythmic flow — a mesmerizing visual pattern.',
    ),
  ],
  'Bommalattam': [
    TrainingMethod(
      title: 'Basic Manipulation',
      icon: 'fa-fingerprint',
      description:
          'Learn how to control puppet strings for basic arm and head movements. Use your fingers independently, not your whole hand.',
    ),
    TrainingMethod(
      title: 'Puppet Walking',
      icon: 'fa-shoe-prints',
      description: 'Master the art of making the puppet appear to walk rhythmically on stage using alternating string pulls.',
    ),
    TrainingMethod(
      title: 'Storytelling Poses',
      icon: 'fa-theater-masks',
      description:
          'Learn static poses that represent different emotions for the puppets — joy, sorrow, anger, and devotion.',
    ),
    TrainingMethod(
      title: 'Voice Modulation',
      icon: 'fa-microphone',
      description: 'Practice modulating your voice to match different puppet characters and their unique personalities.',
    ),
  ],
  'Villu Paatu': [
    TrainingMethod(
      title: 'Bow Striking',
      icon: 'fa-hands',
      description:
          'Learn the rhythmic striking of the long bow string with small sticks. The sound changes depending on where on the bow you strike.',
    ),
    TrainingMethod(
      title: 'Narrative Flow',
      icon: 'fa-mouth',
      description: 'Coordinate the rhythm of the bow with the pace of historical storytelling — slow for sad scenes, fast for battles.',
    ),
    TrainingMethod(
      title: 'Ensemble Timing',
      icon: 'fa-users',
      description: 'Practice timing with other percussionists in the Villu Paatu group. Everyone must start and stop together.',
    ),
    TrainingMethod(
      title: 'Emotional Pitch',
      icon: 'fa-grin-stars',
      description: 'Practice changing your vocal pitch to match the dramatic turns in the villu story for full audience impact.',
    ),
  ],
  'Kolattam': [
    TrainingMethod(
      title: 'Basic Strike',
      icon: 'fa-magic',
      description:
          'Learn the synchronized striking of wooden sticks with a partner. Strike firmly but do not overpower your partner\'s stick.',
    ),
    TrainingMethod(
      title: 'Weaving Movement',
      icon: 'fa-random',
      description:
          'Practice the complex movement of dancers weaving in and out of a circle while maintaining stick coordination.',
    ),
    TrainingMethod(
      title: 'High-Speed Rhythm',
      icon: 'fa-bolt',
      description:
          'Master the rapid-fire stick strikes as the drum tempo increases. Stay in sync with the beat, not just your partner.',
    ),
    TrainingMethod(
      title: 'Double Strike',
      icon: 'fa-sync',
      description: 'Learn to perform overhead and underhand double strikes while rotating positions within the circle formation.',
    ),
  ],
  'Poikkal Kuthirai Attam': [
    TrainingMethod(
      title: 'Stilt Walking',
      icon: 'fa-socks',
      description:
          'Practice walking on wooden stilts associated with the horse dance. Start on flat ground before attempting the full dance.',
    ),
    TrainingMethod(
      title: 'Equine Movement',
      icon: 'fa-horse',
      description:
          'Mimic the galloping and trotting movements of a horse through body language and the positioning of your arms as reins.',
    ),
    TrainingMethod(
      title: 'Balanced Dance',
      icon: 'fa-balance-scale',
      description: 'Maintain balance while performing rapid spins and steps on stilts. Engage your core throughout.',
    ),
    TrainingMethod(
      title: 'Heroic Poses',
      icon: 'fa-shield-alt',
      description:
          'Master the majestic and heroic stances that represent legendary horse riders and warriors in Tamil mythology.',
    ),
  ],
  'Mayil Aattam': [
    TrainingMethod(
      title: 'Plumage Display',
      icon: 'fa-feather-alt',
      description:
          'Master the poses that mimic the opening of a peacock\'s feathers. Spread your arms wide and slowly to create the visual effect.',
    ),
    TrainingMethod(
      title: 'Elegant Pecking',
      icon: 'fa-walking',
      description:
          'Practice the gentle, bird-like head movements and picking steps of a peacock searching for food.',
    ),
    TrainingMethod(
      title: 'The Peacock Spright',
      icon: 'fa-music',
      description: 'Coordinate graceful peacock movements with the rhythm of pipes and drums for a flowing, harmonious dance.',
    ),
    TrainingMethod(
      title: 'Foraging Flow',
      icon: 'fa-seedling',
      description:
          'Mimic a peacock searching for food with delicate and rhythmic floor movements — a series of slow bends and lifts.',
    ),
  ],
  'Devaraattam': [
    TrainingMethod(
      title: 'Dundubi Rhythm',
      icon: 'fa-drum',
      description:
          'Learn to step in sync with the high-speed Deva Dundubi drum beats. Each beat corresponds to a precise foot placement.',
    ),
    TrainingMethod(
      title: 'Group Rotations',
      icon: 'fa-sync',
      description: 'Practice fast-paced circular movements as a synchronized group. Maintain equal spacing between all performers.',
    ),
    TrainingMethod(
      title: 'Majestic Stances',
      icon: 'fa-shield-alt',
      description: 'Master the powerful and regal poses unique to this celestial dance that celebrates divine warriors.',
    ),
    TrainingMethod(
      title: 'Warrior Spirits',
      icon: 'fa-fist-raised',
      description:
          'Embody the fierce and ancient warrior spirits through aggressive yet rhythmic limb movements and battle poses.',
    ),
  ],
  'Paampu Attam': [
    TrainingMethod(
      title: 'Slithering Flow',
      icon: 'fa-snake',
      description:
          'Practice the fluid, wave-like body movements on the ground floor. Keep your spine flexible and your movements continuous.',
    ),
    TrainingMethod(
      title: 'Cobra Hood Poses',
      icon: 'fa-user-ninja',
      description:
          'Learn the hand and body gestures mimicking a cobra with a raised hood. Rise slowly from a low position for full effect.',
    ),
    TrainingMethod(
      title: 'Magudi Response',
      icon: 'fa-undo',
      description: 'Coordinate full-body flexibility with the hypnotic notes of the magudi pipe — sway as if charmed.',
    ),
    TrainingMethod(
      title: 'The Coil & Strike',
      icon: 'fa-grip-lines',
      description:
          'Master the sudden coiling and defensive striking movements characteristic of a guardian snake — rapid and precise.',
    ),
  ],
  'Paraiattam': [
    TrainingMethod(
      title: 'Parai Striking',
      icon: 'fa-drum',
      description:
          'Learn the basic techniques for holding and striking the ancient Parai drum. The drum is held at a slight angle for the best tone.',
    ),
    TrainingMethod(
      title: 'Energetic Footwork',
      icon: 'fa-shoe-prints',
      description: 'Practice the leaps and energetic steps performed while drumming. The body and the drumbeat must move as one.',
    ),
    TrainingMethod(
      title: 'Ensemble Roar',
      icon: 'fa-users',
      description: 'Coordinate rhythmic patterns with a large group of fellow Parai drummers for a thunderous collective sound.',
    ),
    TrainingMethod(
      title: 'Sonic Resilience',
      icon: 'fa-volume-up',
      description:
          'Learn to maintain complex rhythmic variants while maintaining extreme physical intensity throughout the performance.',
    ),
  ],
};
