import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/app_state.dart';
import 'theme/kids_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameCtrl  = TextEditingController();
  final _emailCtrl = TextEditingController();
  String _gender = '';
  DateTime? _dob;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final s = AppStateService.instance;
    _nameCtrl.text  = s.userName;
    _emailCtrl.text = s.userEmail;
    _gender = s.userGender;
    // Parse saved DOB (format: DD / MM / YYYY)
    if (s.userDob.isNotEmpty) {
      try {
        final parts = s.userDob.replaceAll(' ', '').split('/');
        if (parts.length == 3) {
          _dob = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
        }
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  String _formatDob(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')} / '
      '${d.month.toString().padLeft(2, '0')} / '
      '${d.year}';

  Future<void> _saveProfile() async {
    if (_nameCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter your name.',
            style: GoogleFonts.nunito(fontWeight: FontWeight.w700)),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ));
      return;
    }
    setState(() => _saving = true);
    await AppStateService.instance.saveProfile(
      name:   _nameCtrl.text.trim(),
      email:  _emailCtrl.text.trim(),
      gender: _gender,
      dob:    _dob != null ? _formatDob(_dob!) : '',
    );
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('✅ Profile saved!',
          style: GoogleFonts.nunito(fontWeight: FontWeight.w700)),
      backgroundColor: KidsColors.teal,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? KidsColors.backgroundDark : KidsColors.backgroundLight,
      appBar: AppBar(
        title: Text('Edit Profile', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        actions: [
          TextButton(
            onPressed: _saving ? null : _saveProfile,
            child: Text('Save',
                style: GoogleFonts.poppins(
                    color: KidsColors.saffron, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ── Avatar ────────────────────────────────────────────────────────
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 90, height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isDark
                        ? const RadialGradient(colors: [Color(0xFF2A2240), Color(0xFF1A1230)])
                        : RadialGradient(colors: [KidsColors.saffron.withAlpha(40), KidsColors.saffron.withAlpha(10)]),
                    border: Border.all(color: KidsColors.saffron.withAlpha(100), width: 2.5),
                  ),
                  child: Icon(Icons.person, size: 50,
                      color: isDark ? KidsColors.saffron.withAlpha(180) : KidsColors.saffron),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: KidsColors.saffron,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.camera_alt, size: 12, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // ── Name ─────────────────────────────────────────────────────────
          _label('Full Name', Icons.person_rounded, isDark),
          const SizedBox(height: 8),
          _field(controller: _nameCtrl, hint: 'Your full name',
              icon: Icons.person_outline_rounded, isDark: isDark),
          const SizedBox(height: 18),

          // ── Email ─────────────────────────────────────────────────────────
          _label('Email Address', Icons.email_rounded, isDark),
          const SizedBox(height: 8),
          _field(controller: _emailCtrl, hint: 'your@email.com',
              icon: Icons.email_outlined, isDark: isDark,
              keyboard: TextInputType.emailAddress),
          const SizedBox(height: 18),

          // ── Gender ───────────────────────────────────────────────────────
          _label('Gender', Icons.people_rounded, isDark),
          const SizedBox(height: 10),
          Row(children: [
            _genderChip('Male',   Icons.male_rounded,   isDark),
            const SizedBox(width: 12),
            _genderChip('Female', Icons.female_rounded, isDark),
          ]),
          const SizedBox(height: 18),

          // ── Date of Birth ────────────────────────────────────────────────
          _label('Date of Birth', Icons.cake_rounded, isDark),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _dob ?? DateTime(2000),
                firstDate: DateTime(1940),
                lastDate: DateTime.now(),
                builder: (ctx, child) => Theme(
                  data: Theme.of(ctx).copyWith(
                    colorScheme: const ColorScheme.dark(
                      primary: KidsColors.saffron,
                      onPrimary: Colors.white,
                      surface: KidsColors.surfaceDark,
                      onSurface: KidsColors.textPrimary,
                    ),
                    dialogTheme: const DialogThemeData(
                        backgroundColor: KidsColors.surfaceMid),
                  ),
                  child: child!,
                ),
              );
              if (picked != null) setState(() => _dob = picked);
            },
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isDark ? KidsColors.surfaceMid : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: _dob != null ? KidsColors.saffron : (isDark ? KidsColors.borderFaint : Colors.grey.shade300),
                  width: _dob != null ? 1.5 : 1,
                ),
              ),
              child: Row(children: [
                const Icon(Icons.calendar_month_rounded, color: KidsColors.saffron, size: 20),
                const SizedBox(width: 12),
                Text(
                  _dob == null ? 'Select date of birth' : _formatDob(_dob!),
                  style: GoogleFonts.nunito(
                    fontSize: 14, fontWeight: FontWeight.w600,
                    color: _dob == null ? KidsColors.textSecondary : (isDark ? KidsColors.textPrimary : KidsColors.dark),
                  ),
                ),
                const Spacer(),
                Icon(Icons.arrow_drop_down_rounded, color: KidsColors.textSecondary),
              ]),
            ),
          ),
          const SizedBox(height: 32),

          // ── Save button ──────────────────────────────────────────────────
          GestureDetector(
            onTap: _saving ? null : _saveProfile,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 54,
              decoration: BoxDecoration(
                gradient: _saving
                    ? LinearGradient(colors: [KidsColors.surfaceLight, KidsColors.surfaceLight])
                    : KidsColors.saffronGrad,
                borderRadius: BorderRadius.circular(14),
                boxShadow: _saving ? [] : [
                  BoxShadow(color: KidsColors.saffron.withAlpha(80),
                      blurRadius: 16, offset: const Offset(0, 6)),
                ],
              ),
              child: Center(
                child: _saving
                    ? const SizedBox(width: 22, height: 22,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                    : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        const Icon(Icons.save_rounded, color: Colors.white, size: 20),
                        const SizedBox(width: 10),
                        Text('Save Profile',
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                      ]),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _label(String text, IconData icon, bool isDark) => Row(children: [
    Icon(icon, size: 13, color: KidsColors.textSecondary),
    const SizedBox(width: 6),
    Text(text.toUpperCase(),
        style: GoogleFonts.poppins(
            fontSize: 11, fontWeight: FontWeight.w700,
            color: KidsColors.textSecondary, letterSpacing: 0.5)),
  ]);

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool isDark,
    TextInputType keyboard = TextInputType.text,
  }) =>
      TextField(
        controller: controller,
        keyboardType: keyboard,
        style: GoogleFonts.nunito(
            fontSize: 15, fontWeight: FontWeight.w600,
            color: isDark ? KidsColors.textPrimary : KidsColors.dark),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: KidsColors.saffron, size: 20),
          hintStyle: GoogleFonts.nunito(color: KidsColors.textSecondary, fontSize: 14),
          filled: true,
          fillColor: isDark ? KidsColors.surfaceMid : Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
                color: isDark ? KidsColors.borderFaint : Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: KidsColors.saffron, width: 1.5),
          ),
        ),
      );

  Widget _genderChip(String label, IconData icon, bool isDark) {
    final selected = _gender == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _gender = label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 52,
          decoration: BoxDecoration(
            color: selected ? KidsColors.saffron.withAlpha(30) : (isDark ? KidsColors.surfaceMid : Colors.grey.shade50),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? KidsColors.saffron : (isDark ? KidsColors.borderFaint : Colors.grey.shade300),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, size: 22, color: selected ? KidsColors.saffron : KidsColors.textSecondary),
            const SizedBox(width: 8),
            Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w700,
                    color: selected ? KidsColors.saffron : KidsColors.textSecondary)),
          ]),
        ),
      ),
    );
  }
}
