import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../data/app_state.dart';
import 'theme/kids_theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _isLoading = false;
  bool _showPass = false;
  bool _showConfirm = false;
  String? _errorText;
  String? _selectedGender; // 'Male' or 'Female'
  DateTime? _dateOfBirth;

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    // Basic validation
    if (_nameCtrl.text.trim().isEmpty) {
      setState(() => _errorText = 'Please enter your full name.');
      return;
    }
    if (_emailCtrl.text.trim().isEmpty || !_emailCtrl.text.contains('@')) {
      setState(() => _errorText = 'Please enter a valid email address.');
      return;
    }
    if (_passCtrl.text.length < 6) {
      setState(() => _errorText = 'Password must be at least 6 characters.');
      return;
    }
    if (_passCtrl.text != _confirmCtrl.text) {
      setState(() => _errorText = 'Passwords do not match.');
      return;
    }
    if (_selectedGender == null) {
      setState(() => _errorText = 'Please select your gender.');
      return;
    }
    if (_dateOfBirth == null) {
      setState(() => _errorText = 'Please select your date of birth.');
      return;
    }

    setState(() { _isLoading = true; _errorText = null; });
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;

    // ── Auto-save signup info to profile ──────────────────────────────────
    final dob = _dateOfBirth!;
    final dobStr =
        '${dob.day.toString().padLeft(2, '0')} / '
        '${dob.month.toString().padLeft(2, '0')} / '
        '${dob.year}';
    await AppStateService.instance.saveProfile(
      name:   _nameCtrl.text.trim(),
      email:  _emailCtrl.text.trim(),
      gender: _selectedGender ?? '',
      dob:    dobStr,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    // Navigate to app shell
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, a1, a2) => const AppShell(),
        transitionsBuilder: (_, a1, a2, child) => FadeTransition(
          opacity: a1,
          child: ScaleTransition(
            scale: Tween(begin: 0.97, end: 1.0).animate(a1), child: child),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final su = ScreenUtils(context);

    return Scaffold(
      backgroundColor: KidsColors.backgroundDark,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Ambient glow orbs ────────────────────────────────────────────
          Positioned(
            top: -60, left: -60,
            child: Container(
              width: 220, height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: KidsColors.teal.withAlpha(18),
              ),
            ),
          ),
          Positioned(
            bottom: -80, right: -60,
            child: Container(
              width: 250, height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: KidsColors.saffron.withAlpha(14),
              ),
            ),
          ),

          // ── Main content ─────────────────────────────────────────────────
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: su.horizontalPad + 8, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: KidsColors.surfaceDark,
                          shape: BoxShape.circle,
                          border: Border.all(color: KidsColors.borderFaint),
                        ),
                        child: const Icon(Icons.arrow_back_ios_rounded,
                            color: KidsColors.textPrimary, size: 16),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Header ──────────────────────────────────────────────
                    SlideTransition(
                      position: _slideAnim,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create Account',
                            style: GoogleFonts.poppins(
                              fontSize: su.fluid(26.0, 30.0, 34.0, 38.0),
                              fontWeight: FontWeight.w800,
                              color: KidsColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Join the Tamil Heritage Codex today',
                            style: GoogleFonts.nunito(
                              fontSize: 14, fontWeight: FontWeight.w600,
                              color: KidsColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          // Gold accent underline
                          Container(
                            width: 50, height: 3,
                            decoration: BoxDecoration(
                              gradient: KidsColors.saffronGrad,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ── Form Card ────────────────────────────────────────────
                    SlideTransition(
                      position: _slideAnim,
                      child: Container(
                        decoration: BoxDecoration(
                          color: KidsColors.surfaceDark,
                          borderRadius: BorderRadius.circular(su.cardRadius),
                          border: Border.all(color: KidsColors.borderFaint),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withAlpha(80),
                                blurRadius: 30,
                                offset: const Offset(0, 12)),
                          ],
                        ),
                        padding: EdgeInsets.all(su.fluid(20.0, 24.0, 28.0, 32.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Full Name
                            _FieldLabel(icon: Icons.person_rounded, text: 'Full Name'),
                            const SizedBox(height: 8),
                            _DarkField(
                              controller: _nameCtrl,
                              hint: 'Your full name',
                              icon: Icons.person_outline_rounded,
                              keyboardType: TextInputType.name,
                            ),
                            const SizedBox(height: 18),

                            // Email
                            _FieldLabel(icon: Icons.email_rounded, text: 'Email Address'),
                            const SizedBox(height: 8),
                            _DarkField(
                              controller: _emailCtrl,
                              hint: 'your@email.com',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 18),

                            // Password
                            _FieldLabel(icon: Icons.lock_rounded, text: 'Password'),
                            const SizedBox(height: 8),
                            _DarkField(
                              controller: _passCtrl,
                              hint: '• • • • • • • •',
                              icon: Icons.lock_outline_rounded,
                              obscure: !_showPass,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showPass ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                  color: KidsColors.textSecondary, size: 20,
                                ),
                                onPressed: () => setState(() => _showPass = !_showPass),
                              ),
                            ),
                            const SizedBox(height: 18),

                            // Gender
                            _FieldLabel(icon: Icons.people_rounded, text: 'Gender'),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _GenderChip(
                                  label: 'Male',
                                  icon: Icons.male_rounded,
                                  isSelected: _selectedGender == 'Male',
                                  onTap: () => setState(() => _selectedGender = 'Male'),
                                ),
                                const SizedBox(width: 12),
                                _GenderChip(
                                  label: 'Female',
                                  icon: Icons.female_rounded,
                                  isSelected: _selectedGender == 'Female',
                                  onTap: () => setState(() => _selectedGender = 'Female'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),

                            // Date of Birth
                            _FieldLabel(icon: Icons.cake_rounded, text: 'Date of Birth'),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2000),
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
                                if (picked != null) {
                                  setState(() => _dateOfBirth = picked);
                                }
                              },
                              child: Container(
                                height: 52,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 14),
                                decoration: BoxDecoration(
                                  color: KidsColors.surfaceMid,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: _dateOfBirth != null
                                        ? KidsColors.saffron
                                        : KidsColors.borderFaint,
                                    width: _dateOfBirth != null ? 1.5 : 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_month_rounded,
                                        color: KidsColors.saffron, size: 20),
                                    const SizedBox(width: 12),
                                    Text(
                                      _dateOfBirth == null
                                          ? 'Select your date of birth'
                                          : '${_dateOfBirth!.day.toString().padLeft(2,'0')} / '
                                            '${_dateOfBirth!.month.toString().padLeft(2,'0')} / '
                                            '${_dateOfBirth!.year}',
                                      style: GoogleFonts.nunito(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: _dateOfBirth == null
                                            ? KidsColors.textSecondary
                                            : KidsColors.textPrimary,
                                      ),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: KidsColors.textSecondary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            _DarkField(
                              controller: _confirmCtrl,
                              hint: '• • • • • • • •',
                              icon: Icons.lock_outline_rounded,
                              obscure: !_showConfirm,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showConfirm ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                  color: KidsColors.textSecondary, size: 20,
                                ),
                                onPressed: () => setState(() => _showConfirm = !_showConfirm),
                              ),
                            ),

                            // Error message
                            if (_errorText != null) ...[
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.red.withAlpha(20),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.red.withAlpha(60)),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.error_outline_rounded,
                                        color: Colors.redAccent, size: 16),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(_errorText!,
                                          style: GoogleFonts.nunito(
                                            fontSize: 12, fontWeight: FontWeight.w700,
                                            color: Colors.redAccent)),
                                    ),
                                  ],
                                ),
                              ),
                            ],

                            const SizedBox(height: 24),

                            // Create Account button
                            GestureDetector(
                              onTap: _isLoading ? null : _signUp,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                height: su.buttonHeight,
                                decoration: BoxDecoration(
                                  gradient: _isLoading
                                      ? LinearGradient(colors: [
                                          KidsColors.surfaceLight,
                                          KidsColors.surfaceLight
                                        ])
                                      : KidsColors.saffronGrad,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: _isLoading
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: KidsColors.saffron.withAlpha(80),
                                            blurRadius: 20,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                ),
                                child: Center(
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 24, height: 24,
                                          child: CircularProgressIndicator(
                                              color: Colors.white, strokeWidth: 2.5))
                                      : Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.auto_awesome_rounded,
                                                color: Colors.white, size: 20),
                                            const SizedBox(width: 10),
                                            Text('Create Account',
                                                style: GoogleFonts.poppins(
                                                  fontSize: su.fluid(15.0, 16.0, 17.0, 18.0),
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Already have account ──────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: GoogleFonts.nunito(
                            fontSize: 13, fontWeight: FontWeight.w600,
                            color: KidsColors.textSecondary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.nunito(
                              fontSize: 13, fontWeight: FontWeight.w800,
                              color: KidsColors.saffron,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ── Footer ────────────────────────────────────────────
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.temple_hindu_rounded,
                              color: KidsColors.gold, size: 13),
                          const SizedBox(width: 6),
                          Text(
                            'Tamil Heritage Codex',
                            style: GoogleFonts.nunito(
                              fontSize: 11, fontWeight: FontWeight.w700,
                              color: KidsColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GENDER CHIP
// ─────────────────────────────────────────────────────────────────────────────
class _GenderChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  const _GenderChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 52,
          decoration: BoxDecoration(
            color: isSelected
                ? KidsColors.saffron.withAlpha(30)
                : KidsColors.surfaceMid,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? KidsColors.saffron : KidsColors.borderFaint,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: isSelected ? KidsColors.saffron : KidsColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? KidsColors.saffron : KidsColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// REUSABLE DARK TEXT FIELD
// ─────────────────────────────────────────────────────────────────────────────
class _DarkField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  const _DarkField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: GoogleFonts.nunito(
        fontSize: 15, fontWeight: FontWeight.w600,
        color: KidsColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: KidsColors.saffron, size: 20),
        hintStyle: GoogleFonts.nunito(color: KidsColors.textSecondary, fontSize: 14),
        suffixIcon: suffixIcon,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FIELD LABEL
// ─────────────────────────────────────────────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  final IconData icon;
  final String text;
  const _FieldLabel({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 13, color: KidsColors.textSecondary),
        const SizedBox(width: 6),
        Text(text,
            style: GoogleFonts.nunito(
              fontSize: 12, fontWeight: FontWeight.w800,
              color: KidsColors.textSecondary, letterSpacing: 0.3,
            )),
      ],
    );
  }
}
