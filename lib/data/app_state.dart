import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ACHIEVEMENT DEFINITIONS
// ─────────────────────────────────────────────────────────────────────────────
class Achievement {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

const List<Achievement> allAchievements = [
  Achievement(
    id: 'first_quiz',
    title: 'Quiz Initiate',
    description: 'Complete your first quiz',
    icon: Icons.quiz_rounded,
    color: Color(0xFF9B59F5),
  ),
  Achievement(
    id: 'perfect_score',
    title: 'Heritage Master',
    description: 'Score 100% on a quiz',
    icon: Icons.emoji_events_rounded,
    color: Color(0xFFFFD600),
  ),
  Achievement(
    id: 'explorer_3',
    title: 'Cultural Explorer',
    description: 'Explore 3 culture items',
    icon: Icons.explore_rounded,
    color: Color(0xFF00C9A7),
  ),
  Achievement(
    id: 'explorer_8',
    title: 'Heritage Wanderer',
    description: 'Explore 8 culture items',
    icon: Icons.travel_explore_rounded,
    color: Color(0xFF4D9FFF),
  ),
  Achievement(
    id: 'favorited_5',
    title: 'Connoisseur',
    description: 'Add 5 cultures to favorites',
    icon: Icons.favorite_rounded,
    color: Color(0xFFFF4D8D),
  ),
  Achievement(
    id: 'high_score',
    title: 'Star Performer',
    description: 'Score above 80% on any quiz',
    icon: Icons.star_rounded,
    color: Color(0xFFFF6B2B),
  ),
  Achievement(
    id: 'training_complete',
    title: 'Devoted Learner',
    description: 'Complete a step-by-step training',
    icon: Icons.school_rounded,
    color: Color(0xFF2ECC71),
  ),
  Achievement(
    id: 'all_categories',
    title: 'Codex Scholar',
    description: 'Explore all 3 culture categories',
    icon: Icons.auto_stories_rounded,
    color: Color(0xFFE91E63),
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// DAILY CULTURAL TIPS
// ─────────────────────────────────────────────────────────────────────────────
const List<Map<String, String>> culturalTips = [
  {
    'title': 'Did You Know?',
    'body': 'Bharatanatyam has over 2000 years of history and is one of the oldest surviving classical dance forms in the world.',
    'icon': 'temple',
  },
  {
    'title': 'Ancient Wisdom',
    'body': 'Silambattam, the ancient Tamil martial art, uses the bamboo staff (silam) and predates many modern martial arts by centuries.',
    'icon': 'scroll',
  },
  {
    'title': 'Cultural Fact',
    'body': 'The Therukoothu street theater tradition has been performed continuously for over 1,500 years in Tamil villages.',
    'icon': 'mask',
  },
  {
    'title': 'Heritage Insight',
    'body': 'Kummi is performed without instruments — the rhythm comes entirely from the clapping of hands, making it truly ancient.',
    'icon': 'hand',
  },
  {
    'title': 'Did You Know?',
    'body': 'Karakattam performers balance a decorated pot on their head while dancing — a skill that takes years to master.',
    'icon': 'pot',
  },
  {
    'title': 'Tamil Heritage',
    'body': 'Villu Paatu (Bow Song) uses a large decorated bow as a musical instrument while narrating epic tales and local legends.',
    'icon': 'bow',
  },
  {
    'title': 'Living Tradition',
    'body': 'Paraiattam uses the Parai drum — one of the oldest percussion instruments in India, dating back over 3,000 years.',
    'icon': 'drum',
  },
];

// ─────────────────────────────────────────────────────────────────────────────
// APP STATE SERVICE
// ─────────────────────────────────────────────────────────────────────────────
class AppStateService extends ChangeNotifier {
  static AppStateService? _instance;
  static AppStateService get instance => _instance ??= AppStateService._();
  AppStateService._();

  SharedPreferences? _prefs;

  // Favorites
  Set<String> _favorites = {};
  Set<String> get favorites => _favorites;

  // Progress (quiz scores per topic)
  Map<String, int> _quizScores = {};
  Map<String, int> get quizScores => _quizScores;

  // Explored cultures
  Set<String> _exploredCultures = {};
  Set<String> get exploredCultures => _exploredCultures;

  // Earned achievements
  Set<String> _earnedAchievements = {};
  Set<String> get earnedAchievements => _earnedAchievements;

  // Total quiz attempts
  int _quizAttempts = 0;
  int get quizAttempts => _quizAttempts;

  // Last unlocked achievement (for toast)
  Achievement? _lastUnlocked;
  Achievement? get lastUnlocked => _lastUnlocked;

  // Profile
  String _userName = '';
  String _userEmail = '';
  String _userGender = '';
  String _userDob = '';
  String get userName => _userName;
  String get userEmail => _userEmail;
  String get userGender => _userGender;
  String get userDob => _userDob;

  // Settings toggles
  bool _notifications = true;
  bool _soundEffects = true;
  bool _bgMusic = false;
  bool _dataSaver = false;
  bool get notifications => _notifications;
  bool get soundEffects => _soundEffects;
  bool get bgMusic => _bgMusic;
  bool get dataSaver => _dataSaver;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _favorites = (_prefs!.getStringList('favorites') ?? []).toSet();
    _exploredCultures = (_prefs!.getStringList('explored') ?? []).toSet();
    _earnedAchievements = (_prefs!.getStringList('achievements') ?? []).toSet();
    _quizAttempts = _prefs!.getInt('quiz_attempts') ?? 0;
    final scoresRaw = _prefs!.getStringList('quiz_scores') ?? [];
    _quizScores = {};
    for (final entry in scoresRaw) {
      final parts = entry.split(':');
      if (parts.length == 2) {
        _quizScores[parts[0]] = int.tryParse(parts[1]) ?? 0;
      }
    }
    // Profile
    _userName  = _prefs!.getString('profile_name')  ?? '';
    _userEmail = _prefs!.getString('profile_email') ?? '';
    _userGender = _prefs!.getString('profile_gender') ?? '';
    _userDob   = _prefs!.getString('profile_dob')   ?? '';
    // Settings
    _notifications = _prefs!.getBool('setting_notifications') ?? true;
    _soundEffects  = _prefs!.getBool('setting_sound')         ?? true;
    _bgMusic       = _prefs!.getBool('setting_bgMusic')       ?? false;
    _dataSaver     = _prefs!.getBool('setting_dataSaver')     ?? false;
  }

  // ── Profile Save ───────────────────────────────────────────────────────────
  Future<void> saveProfile({
    required String name,
    required String email,
    String gender = '',
    String dob = '',
  }) async {
    _userName  = name;
    _userEmail = email;
    _userGender = gender;
    _userDob   = dob;
    await _prefs?.setString('profile_name',   name);
    await _prefs?.setString('profile_email',  email);
    await _prefs?.setString('profile_gender', gender);
    await _prefs?.setString('profile_dob',    dob);
    notifyListeners();
  }

  // ── Settings Save ──────────────────────────────────────────────────────────
  Future<void> saveSettings({
    required bool notifications,
    required bool soundEffects,
    required bool bgMusic,
    required bool dataSaver,
  }) async {
    _notifications = notifications;
    _soundEffects  = soundEffects;
    _bgMusic       = bgMusic;
    _dataSaver     = dataSaver;
    await _prefs?.setBool('setting_notifications', notifications);
    await _prefs?.setBool('setting_sound',         soundEffects);
    await _prefs?.setBool('setting_bgMusic',       bgMusic);
    await _prefs?.setBool('setting_dataSaver',     dataSaver);
    notifyListeners();
  }

  // ── Favorites ──────────────────────────────────────────────────────────────
  bool isFavorite(String cultureName) => _favorites.contains(cultureName);

  Future<void> toggleFavorite(String cultureName) async {
    if (_favorites.contains(cultureName)) {
      _favorites.remove(cultureName);
    } else {
      _favorites.add(cultureName);
    }
    await _prefs?.setStringList('favorites', _favorites.toList());
    _checkAchievements();
    notifyListeners();
  }

  // ── Explored ───────────────────────────────────────────────────────────────
  Future<void> markExplored(String cultureName) async {
    if (_exploredCultures.contains(cultureName)) return;
    _exploredCultures.add(cultureName);
    await _prefs?.setStringList('explored', _exploredCultures.toList());
    _checkAchievements();
    notifyListeners();
  }

  // ── Quiz Scores ────────────────────────────────────────────────────────────
  Future<void> recordQuizScore(int score, int total) async {
    _quizAttempts++;
    final pct = (score / total * 100).round();
    _quizScores['latest'] = score;
    _quizScores['latest_pct'] = pct;
    final best = _quizScores['best_pct'] ?? 0;
    if (pct > best) _quizScores['best_pct'] = pct;
    _quizScores['total_correct'] = (_quizScores['total_correct'] ?? 0) + score;

    await _prefs?.setInt('quiz_attempts', _quizAttempts);
    final scoresList = _quizScores.entries.map((e) => '${e.key}:${e.value}').toList();
    await _prefs?.setStringList('quiz_scores', scoresList);
    _checkAchievements();
    notifyListeners();
  }

  // ── Achievements ───────────────────────────────────────────────────────────
  void _checkAchievements() {
    _lastUnlocked = null;

    void tryUnlock(String id) {
      if (!_earnedAchievements.contains(id)) {
        _earnedAchievements.add(id);
        _prefs?.setStringList('achievements', _earnedAchievements.toList());
        _lastUnlocked = allAchievements.firstWhere((a) => a.id == id, orElse: () => allAchievements.first);
      }
    }

    if (_quizAttempts >= 1) tryUnlock('first_quiz');
    if ((_quizScores['best_pct'] ?? 0) == 100) tryUnlock('perfect_score');
    if ((_quizScores['best_pct'] ?? 0) >= 80) tryUnlock('high_score');
    if (_exploredCultures.length >= 3) tryUnlock('explorer_3');
    if (_exploredCultures.length >= 8) tryUnlock('explorer_8');
    if (_favorites.length >= 5) tryUnlock('favorited_5');

    // Check categories explored
    // (requires knowing which cultures are in which category — simplified check)
    final exploreList = _exploredCultures.toList();
    if (exploreList.length >= 10) tryUnlock('all_categories');
  }

  void markTrainingComplete() {
    if (!_earnedAchievements.contains('training_complete')) {
      _earnedAchievements.add('training_complete');
      _prefs?.setStringList('achievements', _earnedAchievements.toList());
      _lastUnlocked = allAchievements.firstWhere((a) => a.id == 'training_complete');
      notifyListeners();
    }
  }

  void clearLastUnlocked() {
    _lastUnlocked = null;
  }

  // ── Stats ──────────────────────────────────────────────────────────────────
  int get totalExplored => _exploredCultures.length;
  int get bestQuizPct => _quizScores['best_pct'] ?? 0;
  int get totalCorrect => _quizScores['total_correct'] ?? 0;

  // ── Daily Tip ──────────────────────────────────────────────────────────────
  Map<String, String> get dailyTip {
    final day = DateTime.now().day;
    return culturalTips[day % culturalTips.length];
  }
}
