import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/app_state.dart';
import 'theme/kids_theme.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  final bool darkMode;
  final ValueChanged<bool> onDarkModeChanged;

  const SettingsScreen({
    super.key,
    required this.darkMode,
    required this.onDarkModeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _notifications;
  late bool _soundEffects;
  late bool _bgMusic;
  late bool _dataSaver;

  @override
  void initState() {
    super.initState();
    final s = AppStateService.instance;
    _notifications = s.notifications;
    _soundEffects  = s.soundEffects;
    _bgMusic       = s.bgMusic;
    _dataSaver     = s.dataSaver;
  }

  Future<void> _save() async {
    await AppStateService.instance.saveSettings(
      notifications: _notifications,
      soundEffects: _soundEffects,
      bgMusic: _bgMusic,
      dataSaver: _dataSaver,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('✅ Settings saved!',
            style: GoogleFonts.nunito(fontWeight: FontWeight.w700)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: KidsColors.teal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final service = AppStateService.instance;
    final hasProfile = service.userName.isNotEmpty;

    return Scaffold(
      backgroundColor: isDark ? KidsColors.backgroundDark : KidsColors.backgroundLight,
      appBar: AppBar(
        title: Text('Settings', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ── Profile Info Card ─────────────────────────────────────────────
          _sectionHeader('Profile', isDark),
          _buildCard(isDark, [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: KidsColors.saffron.withAlpha(20),
                child: Icon(Icons.person_rounded, color: KidsColors.saffron),
              ),
              title: Text(
                hasProfile ? service.userName : 'Not set',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    color: isDark ? KidsColors.textPrimary : KidsColors.dark),
              ),
              subtitle: Text(
                hasProfile ? service.userEmail : 'Tap to edit your profile',
                style: GoogleFonts.nunito(
                    color: KidsColors.textSecondary, fontSize: 12),
              ),
              trailing: const Icon(Icons.edit_rounded, color: KidsColors.saffron, size: 18),
              onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const EditProfileScreen())),
            ),
            if (service.userGender.isNotEmpty || service.userDob.isNotEmpty) ...[
              const Divider(height: 1, indent: 72),
              Padding(
                padding: const EdgeInsets.fromLTRB(72, 8, 16, 12),
                child: Row(
                  children: [
                    if (service.userGender.isNotEmpty) ...[
                      Icon(
                        service.userGender == 'Male'
                            ? Icons.male_rounded
                            : Icons.female_rounded,
                        size: 16, color: KidsColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(service.userGender,
                          style: GoogleFonts.nunito(
                              fontSize: 12, color: KidsColors.textSecondary)),
                      const SizedBox(width: 16),
                    ],
                    if (service.userDob.isNotEmpty) ...[
                      const Icon(Icons.cake_rounded, size: 16, color: KidsColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(service.userDob,
                          style: GoogleFonts.nunito(
                              fontSize: 12, color: KidsColors.textSecondary)),
                    ],
                  ],
                ),
              ),
            ],
          ]),
          const SizedBox(height: 14),

          // ── Appearance ───────────────────────────────────────────────────
          _sectionHeader('Appearance', isDark),
          _buildCard(isDark, [
            SwitchListTile(
              value: widget.darkMode,
              onChanged: widget.onDarkModeChanged,
              secondary: _iconAvatar(Icons.dark_mode, Colors.indigo),
              title: _tileTitle('Dark Mode', isDark),
              subtitle: _tileSubtitle('Switch to dark theme'),
              activeThumbColor: KidsColors.saffron,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
            ),
          ]),
          const SizedBox(height: 14),

          // ── Audio ────────────────────────────────────────────────────────
          _sectionHeader('Audio & Notifications', isDark),
          _buildCard(isDark, [
            SwitchListTile(
              value: _notifications,
              onChanged: (v) => setState(() => _notifications = v),
              secondary: _iconAvatar(Icons.notifications_active, Colors.orange),
              title: _tileTitle('Notifications', isDark),
              subtitle: _tileSubtitle('App reminders & updates'),
              activeThumbColor: KidsColors.saffron,
            ),
            const Divider(height: 1, indent: 72),
            SwitchListTile(
              value: _soundEffects,
              onChanged: (v) => setState(() => _soundEffects = v),
              secondary: _iconAvatar(Icons.volume_up, Colors.green),
              title: _tileTitle('Sound Effects', isDark),
              subtitle: _tileSubtitle('Quiz feedback sounds'),
              activeThumbColor: KidsColors.saffron,
            ),
            const Divider(height: 1, indent: 72),
            SwitchListTile(
              value: _bgMusic,
              onChanged: (v) => setState(() => _bgMusic = v),
              secondary: _iconAvatar(Icons.music_note, Colors.blue),
              title: _tileTitle('Background Music', isDark),
              subtitle: _tileSubtitle('Classical music while exploring'),
              activeThumbColor: KidsColors.saffron,
            ),
          ]),
          const SizedBox(height: 14),

          // ── Data ─────────────────────────────────────────────────────────
          _sectionHeader('Data', isDark),
          _buildCard(isDark, [
            SwitchListTile(
              value: _dataSaver,
              onChanged: (v) => setState(() => _dataSaver = v),
              secondary: _iconAvatar(Icons.data_saver_on, Colors.teal),
              title: _tileTitle('Data Saver Mode', isDark),
              subtitle: _tileSubtitle('Reduce data usage'),
              activeThumbColor: KidsColors.saffron,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
            ),
          ]),
          const SizedBox(height: 24),

          // ── Save button ──────────────────────────────────────────────────
          GestureDetector(
            onTap: _save,
            child: Container(
              height: 54,
              decoration: BoxDecoration(
                gradient: KidsColors.saffronGrad,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: KidsColors.saffron.withAlpha(80),
                    blurRadius: 16, offset: const Offset(0, 6)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.save_rounded, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Text('Save Settings',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCard(bool isDark, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? KidsColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isDark ? Border.all(color: KidsColors.borderFaint) : null,
        boxShadow: isDark ? [] : [
          BoxShadow(color: Colors.black.withAlpha(8), blurRadius: 10, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _iconAvatar(IconData icon, Color color) => CircleAvatar(
    backgroundColor: color.withAlpha(20),
    child: Icon(icon, color: color),
  );

  Widget _tileTitle(String text, bool isDark) => Text(text,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w700, fontSize: 14,
        color: isDark ? KidsColors.textPrimary : KidsColors.dark));

  Widget _tileSubtitle(String text) => Text(text,
      style: GoogleFonts.nunito(color: KidsColors.textSecondary, fontSize: 12));

  Widget _sectionHeader(String title, bool isDark) => Padding(
    padding: const EdgeInsets.only(left: 4, bottom: 8),
    child: Text(title.toUpperCase(),
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700, fontSize: 11,
            color: isDark ? KidsColors.textSecondary : Colors.grey.shade600,
            letterSpacing: 0.8)),
  );
}
