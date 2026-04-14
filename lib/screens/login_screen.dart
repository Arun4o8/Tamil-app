import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import 'signup_screen.dart';
import '../screens/theme/kids_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _isLoading = false;
  bool _showPass = false;

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim =
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn);
    _slideAnim =
        Tween<Offset>(begin: const Offset(0, 0.18), end: Offset.zero).animate(
            CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  void _login() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, a1, a2) => const AppShell(),
        transitionsBuilder: (_, a1, a2, child) => FadeTransition(
          opacity: a1,
          child: ScaleTransition(
            scale: Tween(begin: 0.97, end: 1.0).animate(a1),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final su = ScreenUtils(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Full-screen background image ──────────────────────────────────
          Image.asset(
            'assets/login_bg.png',
            fit: BoxFit.cover,
            width: size.width,
            height: size.height,
          ),

          // ── Dark gradient overlay (bottom-heavy, navy #3D405B) ───────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x6625273A), // darkest navy at top
                  Color(0xDD25273A), // stronger navy mid
                  Color(0xF225273A), // near-opaque navy at bottom
                ],
                stops: [0.0, 0.42, 1.0],
              ),
            ),
          ),

          // ── Content ───────────────────────────────────────────────────────
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: su.horizontalPad + 4, vertical: 0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ── Logo + Title (top brand area) ─────────────────────
                      SlideTransition(
                        position: _slideAnim,
                        child: Column(
                          children: [
                            // Tamil letter badge
                            Container(
                              width: 76,
                              height: 76,
                              decoration: BoxDecoration(
                                gradient: KidsColors.saffronGrad,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: KidsColors.saffron.withAlpha(120),
                                    blurRadius: 28,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'த',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    height: 1.1,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'வணக்கம்',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: KidsColors.gold,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tamil Heritage Codex',
                              style: GoogleFonts.poppins(
                                fontSize: su.fluid(22.0, 26.0, 28.0, 32.0),
                                fontWeight: FontWeight.w800,
                                color: KidsColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 36),

                      // ── Glassmorphism Login Card ──────────────────────────
                      SlideTransition(
                        position: _slideAnim,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xCC2E3048),
                            borderRadius:
                                BorderRadius.circular(su.cardRadius + 4),
                            border: Border.all(
                                color: Color(0xFFF4F1DE).withAlpha(35), width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(100),
                                blurRadius: 40,
                                offset: const Offset(0, 16),
                              ),
                              BoxShadow(
                                color: KidsColors.saffron.withAlpha(14),
                                blurRadius: 30,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.fromLTRB(
                              su.fluid(20.0, 24.0, 28.0, 32.0),
                              28,
                              su.fluid(20.0, 24.0, 28.0, 32.0),
                              28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Card heading
                              Text(
                                'Sign In',
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: KidsColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Welcome back to the Codex',
                                style: GoogleFonts.nunito(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: KidsColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Email field
                              _FieldLabel(
                                  text: 'Email Address',
                                  icon: Icons.email_rounded),
                              const SizedBox(height: 8),
                              _GlassField(
                                controller: _emailCtrl,
                                hint: 'your@email.com',
                                icon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 18),

                              // Password field
                              _FieldLabel(
                                  text: 'Password', icon: Icons.lock_rounded),
                              const SizedBox(height: 8),
                              _GlassField(
                                controller: _passCtrl,
                                hint: '• • • • • • • •',
                                icon: Icons.lock_outline_rounded,
                                obscure: !_showPass,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _showPass
                                        ? Icons.visibility_off_rounded
                                        : Icons.visibility_rounded,
                                    color: KidsColors.textSecondary,
                                    size: 20,
                                  ),
                                  onPressed: () =>
                                      setState(() => _showPass = !_showPass),
                                ),
                              ),

                              // Forgot password
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      padding: const EdgeInsets.only(top: 4)),
                                  child: Text(
                                    'Forgot Password?',
                                    style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: KidsColors.saffron,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              // Sign In button
                              GestureDetector(
                                onTap: _isLoading ? null : _login,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  height: su.buttonHeight,
                                  decoration: BoxDecoration(
                                    gradient: _isLoading
                                        ? LinearGradient(colors: [
                                            KidsColors.surfaceLight,
                                            KidsColors.surfaceLight,
                                          ])
                                        : KidsColors.saffronGrad,
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: _isLoading
                                        ? []
                                        : [
                                            BoxShadow(
                                              color: KidsColors.saffron
                                                  .withAlpha(90),
                                              blurRadius: 22,
                                              offset: const Offset(0, 8),
                                            ),
                                          ],
                                  ),
                                  child: Center(
                                    child: _isLoading
                                        ? const SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2.5),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.login_rounded,
                                                  color: Colors.white,
                                                  size: 20),
                                              const SizedBox(width: 10),
                                              Text(
                                                'Sign In',
                                                style: GoogleFonts.poppins(
                                                  fontSize: su.fluid(
                                                      15.0, 16.0, 17.0, 18.0),
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
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

                      // ── Sign Up link ──────────────────────────────────────
                      SlideTransition(
                        position: _slideAnim,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: GoogleFonts.nunito(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: KidsColors.textSecondary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => const SignUpScreen()),
                              ),
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.nunito(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: KidsColors.saffron,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Field Label Widget ────────────────────────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  final String text;
  final IconData icon;
  const _FieldLabel({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 13, color: KidsColors.textSecondary),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.nunito(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: KidsColors.textSecondary,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

// ── Glass Text Field ──────────────────────────────────────────────────────────
class _GlassField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  const _GlassField({
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
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: KidsColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: KidsColors.saffron, size: 20),
        hintStyle:
            GoogleFonts.nunito(color: KidsColors.textSecondary, fontSize: 14),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0x303D405B),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              BorderSide(color: Color(0xFFF4F1DE).withAlpha(40), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: KidsColors.saffron, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
