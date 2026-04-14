import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'theme/kids_theme.dart';

/// A self-contained audio narration card that can play
/// English or Tamil audio files from the assets folder.
///
/// File naming convention:
///   assets/audio/en/<cultureName>.mp3   (e.g. assets/audio/en/bharatanatyam.mp3)
///   assets/audio/ta/<cultureName>.mp3   (e.g. assets/audio/ta/bharatanatyam.mp3)
///
/// If a file doesn't exist yet, the player shows a graceful "coming soon" state.
class AudioNarrationCard extends StatefulWidget {
  final String cultureName; // e.g. "Bharatanatyam"
  final String currentLanguage; // "English" or "Tamil"

  const AudioNarrationCard({
    super.key,
    required this.cultureName,
    required this.currentLanguage,
  });

  @override
  State<AudioNarrationCard> createState() => _AudioNarrationCardState();
}

class _AudioNarrationCardState extends State<AudioNarrationCard>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _player = AudioPlayer();

  PlayerState _playerState = PlayerState.stopped;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _hasError = false;
  late String _selectedLang;

  late AnimationController _waveCtrl;
  late Animation<double> _waveAnim;

  @override
  void initState() {
    super.initState();
    _selectedLang = widget.currentLanguage;

    _waveCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _waveAnim = CurvedAnimation(parent: _waveCtrl, curve: Curves.easeInOut);

    _player.onPlayerStateChanged.listen((state) {
      if (mounted) setState(() => _playerState = state);
    });
    _player.onDurationChanged.listen((dur) {
      if (mounted) setState(() => _duration = dur);
    });
    _player.onPositionChanged.listen((pos) {
      if (mounted) setState(() => _position = pos);
    });
    _player.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          _position = Duration.zero;
          _playerState = PlayerState.stopped;
        });
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    _waveCtrl.dispose();
    super.dispose();
  }

  /// Converts culture name to a safe filename key.
  /// e.g. "Bharatanatyam" → "bharatanatyam", "Kummi Dance" → "kummi_dance"
  String get _fileKey =>
      widget.cultureName.toLowerCase().replaceAll(' ', '_').replaceAll('-', '_');

  bool get _isPlaying => _playerState == PlayerState.playing;

  String? _errorMessage;

  Future<void> _togglePlay() async {
    try {
      if (_isPlaying) {
        await _player.pause();
      } else {
        setState(() { _hasError = false; _errorMessage = null; });
        final path = 'audio/${_selectedLang == 'Tamil' ? 'ta' : 'en'}/$_fileKey.mp3';
        debugPrint('[AudioCard] Playing: $path');
        await _player.play(AssetSource(path));
      }
    } catch (e) {
      debugPrint('[AudioCard] Error: $e');
      setState(() { _hasError = true; _errorMessage = e.toString(); });
    }
  }

  Future<void> _seek(double value) async {
    final pos = Duration(milliseconds: value.toInt());
    await _player.seek(pos);
  }

  Future<void> _switchLanguage(String lang) async {
    await _player.stop();
    setState(() {
      _selectedLang = lang;
      _position = Duration.zero;
      _duration = Duration.zero;
      _hasError = false;
    });
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? KidsColors.surfaceDark : Colors.white;
    final borderColor = isDark
        ? KidsColors.teal.withAlpha(60)
        : KidsColors.teal.withAlpha(80);

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: isDark
            ? [
                BoxShadow(color: KidsColors.teal.withAlpha(20), blurRadius: 16),
                BoxShadow(color: Colors.black.withAlpha(60), blurRadius: 20, offset: const Offset(0, 6)),
              ]
            : [
                BoxShadow(color: Colors.black.withAlpha(8), blurRadius: 12, offset: const Offset(0, 4)),
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header Row ───────────────────────────────────────────────
            Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: KidsColors.teal.withAlpha(isDark ? 30 : 20),
                    shape: BoxShape.circle,
                    border: Border.all(color: KidsColors.teal.withAlpha(60)),
                  ),
                  child: const Icon(Icons.headphones_rounded,
                      color: KidsColors.teal, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Audio Narration',
                        style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w700,
                          color: isDark ? KidsColors.textPrimary : KidsColors.dark,
                        ),
                      ),
                      Text(
                        'Listen to the story of ${widget.cultureName}',
                        style: GoogleFonts.nunito(
                          fontSize: 11, fontWeight: FontWeight.w600,
                          color: KidsColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Language toggle (EN / தமிழ்)
                _LangToggle(
                  selected: _selectedLang,
                  onChanged: _switchLanguage,
                  isDark: isDark,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ── Error / Coming Soon state ─────────────────────────────────
            if (_hasError)
              _ComingSoonBanner(isDark: isDark, lang: _selectedLang,
                  errorMessage: _errorMessage, onRetry: _togglePlay)
            else ...[

              // ── Waveform visualizer (animated bars) ──────────────────────
              AnimatedBuilder(
                animation: _waveAnim,
                builder: (_, __) => _WaveVisualizer(
                  isPlaying: _isPlaying,
                  animValue: _waveAnim.value,
                  isDark: isDark,
                ),
              ),
              const SizedBox(height: 12),

              // ── Progress slider ──────────────────────────────────────────
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 3,
                  activeTrackColor: KidsColors.teal,
                  inactiveTrackColor: isDark
                      ? KidsColors.surfaceLight
                      : Colors.grey.shade200,
                  thumbColor: KidsColors.teal,
                  overlayColor: KidsColors.teal.withAlpha(30),
                ),
                child: Slider(
                  value: _duration.inMilliseconds > 0
                      ? _position.inMilliseconds
                          .toDouble()
                          .clamp(0.0, _duration.inMilliseconds.toDouble())
                      : 0.0,
                  min: 0,
                  max: _duration.inMilliseconds > 0
                      ? _duration.inMilliseconds.toDouble()
                      : 1,
                  onChanged: _duration.inMilliseconds > 0 ? _seek : null,
                ),
              ),

              // ── Time labels ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formatDuration(_position),
                        style: GoogleFonts.nunito(
                          fontSize: 11, fontWeight: FontWeight.w700,
                          color: KidsColors.textSecondary)),
                    Text(_formatDuration(_duration),
                        style: GoogleFonts.nunito(
                          fontSize: 11, fontWeight: FontWeight.w700,
                          color: KidsColors.textSecondary)),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // ── Controls ─────────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Rewind 10s
                  _ControlBtn(
                    icon: Icons.replay_10_rounded,
                    size: 26,
                    color: isDark ? KidsColors.textSecondary : KidsColors.grey,
                    onTap: () => _seek(
                        (_position.inMilliseconds - 10000).clamp(0, double.maxFinite).toDouble()),
                  ),
                  const SizedBox(width: 20),

                  // Play / Pause main button
                  GestureDetector(
                    onTap: _togglePlay,
                    child: Container(
                      width: 56, height: 56,
                      decoration: BoxDecoration(
                        gradient: KidsColors.tealGrad,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: KidsColors.teal.withAlpha(80),
                            blurRadius: 16, offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Icon(
                        _isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: Colors.white, size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Forward 10s
                  _ControlBtn(
                    icon: Icons.forward_10_rounded,
                    size: 26,
                    color: isDark ? KidsColors.textSecondary : KidsColors.grey,
                    onTap: () => _seek(
                        (_position.inMilliseconds + 10000)
                            .clamp(0, _duration.inMilliseconds.toDouble()).toDouble()),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LANGUAGE TOGGLE
// ─────────────────────────────────────────────────────────────────────────────
class _LangToggle extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;
  final bool isDark;
  const _LangToggle({required this.selected, required this.onChanged, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? KidsColors.surfaceMid : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: KidsColors.borderFaint),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Tab(label: 'EN', isSelected: selected == 'English',
              onTap: () => onChanged('English'), isDark: isDark),
          _Tab(label: 'தமிழ்', isSelected: selected == 'Tamil',
              onTap: () => onChanged('Tamil'), isDark: isDark),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;
  const _Tab({required this.label, required this.isSelected, required this.onTap, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? KidsColors.teal : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 12, fontWeight: FontWeight.w800,
            color: isSelected ? Colors.white
                : (isDark ? KidsColors.textSecondary : KidsColors.grey),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ANIMATED WAVEFORM VISUALIZER
// ─────────────────────────────────────────────────────────────────────────────
class _WaveVisualizer extends StatelessWidget {
  final bool isPlaying;
  final double animValue;
  final bool isDark;
  static const _barCount = 28;

  const _WaveVisualizer({required this.isPlaying, required this.animValue, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(_barCount, (i) {
          // Create a wavy pattern: each bar has a different height
          final phase = (i / _barCount) * 3.14159 * 2;
          final heightFactor = isPlaying
              ? (0.3 + 0.7 * ((1 + (animValue * 2 - 1) * _sinApprox(phase)) / 2))
              : 0.15;
          return Container(
            width: 3,
            height: 36 * heightFactor,
            decoration: BoxDecoration(
              color: isPlaying
                  ? KidsColors.teal.withAlpha((180 * heightFactor).toInt() + 50)
                  : (isDark ? KidsColors.surfaceLight : Colors.grey.shade300),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
      ),
    );
  }

  double _sinApprox(double x) {
    // Simple sine approximation
    x = x % (2 * 3.14159);
    return x < 3.14159 ? (4 * x * (3.14159 - x)) / (3.14159 * 3.14159) - 1
        : -((4 * (x - 3.14159) * (2 * 3.14159 - x)) / (3.14159 * 3.14159) - 1);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// COMING SOON / ERROR BANNER
// ─────────────────────────────────────────────────────────────────────────────
class _ComingSoonBanner extends StatelessWidget {
  final bool isDark;
  final String lang;
  final String? errorMessage;
  final VoidCallback? onRetry;
  const _ComingSoonBanner({
    required this.isDark,
    required this.lang,
    this.errorMessage,
    this.onRetry,
  });

  bool get _hasFile => errorMessage != null;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? KidsColors.surfaceMid : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _hasFile
              ? Colors.red.withAlpha(80)
              : (isDark ? KidsColors.borderFaint : Colors.grey.shade200)),
      ),
      child: Column(
        children: [
          Icon(
            _hasFile ? Icons.error_outline_rounded : Icons.audio_file_rounded,
            size: 32,
            color: _hasFile ? Colors.redAccent : (isDark ? KidsColors.surfaceLight : Colors.grey.shade300),
          ),
          const SizedBox(height: 8),
          Text(
            _hasFile
                ? 'Could not play audio'
                : (lang == 'Tamil' ? 'தமிழ் ஒலி விரைவில் வரும்...' : 'Audio coming soon...'),
            style: GoogleFonts.nunito(
              fontSize: 13, fontWeight: FontWeight.w700,
              color: _hasFile ? Colors.redAccent : KidsColors.textSecondary,
            ),
          ),
          if (_hasFile && errorMessage != null) ...[
            const SizedBox(height: 4),
            Text(
              errorMessage!.length > 80
                  ? '${errorMessage!.substring(0, 80)}...'
                  : errorMessage!,
              style: GoogleFonts.nunito(
                fontSize: 10, color: KidsColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
          if (!_hasFile) ...[
            const SizedBox(height: 4),
            Text(
              'Drop ${lang == 'Tamil' ? 'ta' : 'en'}/<name>.mp3 in assets/audio/',
              style: GoogleFonts.nunito(
                fontSize: 10, fontWeight: FontWeight.w600,
                color: KidsColors.textSecondary.withAlpha(150),
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (_hasFile && onRetry != null) ...[
            const SizedBox(height: 12),
            GestureDetector(
              onTap: onRetry,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: KidsColors.teal.withAlpha(20),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: KidsColors.teal.withAlpha(80)),
                ),
                child: Text('Retry', style: GoogleFonts.nunito(
                  fontSize: 12, fontWeight: FontWeight.w800, color: KidsColors.teal)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CONTROL BUTTON
// ─────────────────────────────────────────────────────────────────────────────
class _ControlBtn extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  final VoidCallback onTap;
  const _ControlBtn({required this.icon, required this.size, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, size: size, color: color),
      ),
    );
  }
}
