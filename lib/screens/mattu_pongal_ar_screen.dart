import 'dart:io';
import 'dart:ui' as ui;

import 'package:ar_flutter_plugin_2/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_2/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin_2/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin_2/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_2/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_2/models/ar_anchor.dart';
import 'package:ar_flutter_plugin_2/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin_2/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

// ─────────────────────────────────────────────────────────────────────────────
//  Mattu Pongal AR Screen
//  Native ARCore — no WebView, no external app.
//  • Camera opens inside this screen
//  • Detects real floor/walls
//  • Tap floor → 3D bull placed in real world
//  • Shutter button → screenshot saved directly to gallery
// ─────────────────────────────────────────────────────────────────────────────

class MattuPongalARScreen extends StatefulWidget {
  const MattuPongalARScreen({super.key});

  @override
  State<MattuPongalARScreen> createState() => _MattuPongalARScreenState();
}

class _MattuPongalARScreenState extends State<MattuPongalARScreen>
    with TickerProviderStateMixin {
  // ── AR Managers ────────────────────────────────────────────────────────────
  ARSessionManager? _sessionMgr;
  ARObjectManager? _objMgr;
  ARAnchorManager? _anchorMgr;

  final List<ARNode> _nodes = [];
  final List<ARAnchor> _anchors = [];

  // ── State ──────────────────────────────────────────────────────────────────
  bool _arReady = false;
  bool _bullPlaced = false;
  bool _capturing = false;
  bool _showFlash = false;
  String? _savedPath;
  String _hint = 'Point camera at the floor…\nARCore is detecting surfaces';
  int _selectedBull = 0;
  double _bullScale = 0.4;

  // ── Bull models ────────────────────────────────────────────────────────────
  // NodeType.localGLTF2 loads from assets (copied to temp dir by plugin)
  // We host bull.glb (3MB) for the fast tap, and expose majestic as well
  final List<_BullDef> _bulls = const [
    _BullDef(
      name: 'Jallikattu Bull',
      nameTamil: 'ஜல்லிக்கட்டு காளை',
      asset: 'assets/models/bull.glb',
      emoji: '🐂',
      primaryColor: Color(0xFFFF6B2B),
      accentColor: Color(0xFFFF9A00),
    ),
    _BullDef(
      name: 'Majestic Bull',
      nameTamil: 'கம்பீர காளை',
      asset: 'assets/models/majestic_horned_bull.glb',
      emoji: '🐄',
      primaryColor: Color(0xFFD4AF37),
      accentColor: Color(0xFFFF6B2B),
    ),
  ];

  _BullDef get _bull => _bulls[_selectedBull];

  // ── Animations ─────────────────────────────────────────────────────────────
  late AnimationController _pulseCtrl;
  late Animation<double> _pulse;
  late AnimationController _thumbCtrl;
  late Animation<double> _thumbScale;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    _pulseCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat(reverse: true);
    _pulse = Tween<double>(begin: 1.0, end: 1.08)
        .animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    _thumbCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _thumbScale = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _thumbCtrl, curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    _sessionMgr?.dispose();
    _pulseCtrl.dispose();
    _thumbCtrl.dispose();
    super.dispose();
  }

  // ── ARView callbacks ───────────────────────────────────────────────────────
  void _onARViewCreated(
    ARSessionManager sessionMgr,
    ARObjectManager objMgr,
    ARAnchorManager anchorMgr,
    ARLocationManager locationMgr,
  ) {
    _sessionMgr = sessionMgr;
    _objMgr = objMgr;
    _anchorMgr = anchorMgr;

    sessionMgr.onInitialize(
      showFeaturePoints: true,
      showPlanes: true,          // show detected floor/surface grids
      showWorldOrigin: false,
    );
    objMgr.onInitialize();

    // Tap on detected plane → place bull
    sessionMgr.onPlaneOrPointTap = _onPlaneTapped;

    setState(() {
      _arReady = true;
      _hint = 'Tap on the floor to\nplace the bull! 🐂';
    });
  }

  // ── Place bull on tapped plane ─────────────────────────────────────────────
  Future<void> _onPlaneTapped(List<ARHitTestResult> hits) async {
    if (hits.isEmpty) return;

    final hit = hits.firstWhere(
      (h) => h.type == ARHitTestResultType.plane,
      orElse: () => hits.first,
    );

    // Tell user it's loading (the 36MB model takes a second to extract)
    setState(() => _hint = 'Loading 3D Model...');

    // Copy GLB from assets → documents dir (ARCore plugin requires it there)
    final filename = await _extractAsset(_bull.asset);

    final anchor = ARPlaneAnchor(transformation: hit.worldTransform);
    final added = await _anchorMgr!.addAnchor(anchor);
    if (added != true) {
      setState(() => _hint = 'Could not anchor. Try another spot.');
      return;
    }
    _anchors.add(anchor);

    // Note: use fileSystemAppFolderGLB and just the filename!
    final node = ARNode(
      type: NodeType.fileSystemAppFolderGLB,
      uri: filename,
      scale: vm.Vector3(_bullScale, _bullScale, _bullScale),
      position: vm.Vector3(0, 0, 0),
      rotation: vm.Vector4(0, 0, 0, 1),
    );

    final addedNode = await _objMgr!.addNode(node, planeAnchor: anchor);
    if (addedNode == true) {
      _nodes.add(node);
      setState(() {
        _bullPlaced = true;
        _hint = '✅ Bull placed!\nPinch to resize • Tap again to move';
      });
    } else {
      setState(() => _hint = 'Failed to load model!');
    }
  }

  // ── Extract GLB from asset bundle to App Documents dir ─────────────────────
  Future<String> _extractAsset(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();
    final docDir = await getApplicationDocumentsDirectory();
    final filename = assetPath.split('/').last;
    final file = File('${docDir.path}/$filename');
    
    // Only write if not exists or size changed (saving I/O on 36MB file)
    if (!await file.exists() || (await file.length()) != bytes.length) {
      await file.writeAsBytes(bytes, flush: true);
    }
    return filename; // Returns bare filename for fileSystemAppFolderGLB
  }

  // ── Remove all bulls ───────────────────────────────────────────────────────
  Future<void> _clearAll() async {
    for (final anchor in _anchors) {
      _anchorMgr!.removeAnchor(anchor);
    }
    _anchors.clear();
    _nodes.clear();
    setState(() {
      _bullPlaced = false;
      _hint = 'Tap on the floor to\nplace the bull! 🐂';
    });
  }

  // ── Capture screenshot inside app ──────────────────────────────────────────
  Future<void> _capturePhoto() async {
    if (_capturing) return;
    setState(() {
      _capturing = true;
      _showFlash = true;
    });
    await Future.delayed(const Duration(milliseconds: 80));
    setState(() => _showFlash = false);

    try {
      // snapshot() returns an ImageProvider
      final imageProvider = await _sessionMgr!.snapshot();

      // Convert ImageProvider → bytes → save to gallery
      final imageStream = imageProvider.resolve(ImageConfiguration.empty);
      late ImageStreamListener listener;
      imageStream.addListener(
        listener = ImageStreamListener((info, _) async {
          imageStream.removeListener(listener);
          final byteData =
              await info.image.toByteData(format: ui.ImageByteFormat.png);
          if (byteData == null) return;
          final bytes = byteData.buffer.asUint8List();

          final tmpDir = await getTemporaryDirectory();
          final file = File(
              '${tmpDir.path}/mattu_pongal_ar_${DateTime.now().millisecondsSinceEpoch}.png');
          await file.writeAsBytes(bytes, flush: true);

          final result = await SaverGallery.saveFile(
            filePath: file.path,
            fileName: 'mattu_pongal_ar_${DateTime.now().millisecondsSinceEpoch}',
            androidRelativePath: 'Pictures/MattuPongalAR',
            skipIfExists: false,
          );

          if (result.isSuccess && mounted) {
            setState(() => _savedPath = file.path);
            _thumbCtrl.forward(from: 0);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: _bull.primaryColor,
                content: Row(children: [
                  const Icon(Icons.check_circle_rounded,
                      color: Colors.white, size: 18),
                  const SizedBox(width: 10),
                  const Text('AR Photo saved to Gallery! 📸',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700)),
                ]),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        }),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Screenshot error: $e')));
      }
    } finally {
      if (mounted) setState(() => _capturing = false);
    }
  }

  // ── Switch bull model (clear & re-place) ───────────────────────────────────
  void _switchBull(int i) {
    if (_selectedBull == i) return;
    _clearAll();
    setState(() => _selectedBull = i);
  }

  // ── BUILD ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Native ARCore camera view ─────────────────────────────────
          ARView(
            onARViewCreated: _onARViewCreated,
            planeDetectionConfig:
                PlaneDetectionConfig.horizontalAndVertical,
          ),

          // ── Flash effect on capture ───────────────────────────────────
          if (_showFlash)
            Container(color: Colors.white.withValues(alpha: 0.7)),

          // ── Top bar ────────────────────────────────────────────────────
          _buildTopBar(context),

          // ── Hint label ─────────────────────────────────────────────────
          Positioned(
            top: 110,
            left: 20,
            right: 20,
            child: AnimatedOpacity(
              opacity: _arReady ? 1.0 : 0.6,
              duration: const Duration(milliseconds: 400),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: _bull.primaryColor
                            .withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    _hint,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Scale slider (shown when bull is placed) ──────────────────
          if (_bullPlaced)
            Positioned(
              right: 16,
              top: 180,
              bottom: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.zoom_in_rounded,
                      color: Colors.white60, size: 18),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: _bullScale,
                      min: 0.1,
                      max: 1.5,
                      activeColor: _bull.primaryColor,
                      inactiveColor:
                          Colors.white.withValues(alpha: 0.2),
                      onChanged: (v) => setState(() => _bullScale = v),
                    ),
                  ),
                  Icon(Icons.zoom_out_rounded,
                      color: Colors.white60, size: 18),
                ],
              ),
            ),

          // ── Thumbnail of saved photo ──────────────────────────────────
          if (_savedPath != null)
            Positioned(
              bottom: 165,
              right: 18,
              child: ScaleTransition(
                scale: _thumbScale,
                child: GestureDetector(
                  onTap: () => setState(() => _savedPath = null),
                  child: Container(
                    width: 60,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Colors.black.withValues(alpha: 0.5),
                            blurRadius: 10)
                      ],
                      image: DecorationImage(
                        image: FileImage(File(_savedPath!)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // ── Bottom controls ───────────────────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomBar(),
          ),
        ],
      ),
    );
  }

  // ── Top bar ────────────────────────────────────────────────────────────────
  Widget _buildTopBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          right: 16,
          bottom: 14,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.8),
              Colors.transparent,
            ],
          ),
        ),
        child: Row(
          children: [
            _TopBtn(
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'மாட்டுப் பொங்கல் AR Camera',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _arReady
                              ? Colors.greenAccent
                              : Colors.orange,
                        ),
                      ),
                      Text(
                        _arReady
                            ? 'ARCore Active • Real World'
                            : 'Starting ARCore...',
                        style: GoogleFonts.nunito(
                          color: _arReady
                              ? Colors.greenAccent
                              : Colors.orange,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Clear button
            if (_bullPlaced)
              _TopBtn(
                icon: Icons.delete_outline_rounded,
                onTap: _clearAll,
                color: Colors.redAccent,
              ),
          ],
        ),
      ),
    );
  }

  // ── Bottom bar ─────────────────────────────────────────────────────────────
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withValues(alpha: 0.92),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Bull selector
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _bulls.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (ctx, i) {
                final b = _bulls[i];
                final sel = _selectedBull == i;
                return GestureDetector(
                  onTap: () => _switchBull(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: sel
                          ? b.primaryColor.withValues(alpha: 0.25)
                          : Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: sel
                            ? b.primaryColor
                            : Colors.white.withValues(alpha: 0.15),
                        width: sel ? 1.6 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(b.emoji,
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Text(
                              b.name,
                              style: GoogleFonts.nunito(
                                color: sel
                                    ? Colors.white
                                    : Colors.white60,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              b.nameTamil,
                              style: GoogleFonts.notoSerif(
                                color: sel
                                    ? b.primaryColor
                                    : Colors.white30,
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Shutter row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Clear
              _ActionBtn(
                icon: Icons.refresh_rounded,
                label: 'Clear',
                onTap: _clearAll,
                color: Colors.white54,
              ),
              const SizedBox(width: 28),

              // Shutter
              GestureDetector(
                onTap: _capturing ? null : _capturePhoto,
                child: ScaleTransition(
                  scale: _bullPlaced ? _pulse : const AlwaysStoppedAnimation(1.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: _capturing ? 68 : 76,
                    height: _capturing ? 68 : 76,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: _bull.primaryColor,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _bull.primaryColor
                              .withValues(alpha: 0.6),
                          blurRadius: 20,
                          spreadRadius: 3,
                        )
                      ],
                    ),
                    child: _capturing
                        ? Padding(
                            padding: const EdgeInsets.all(18),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: _bull.primaryColor,
                            ),
                          )
                        : Icon(
                            Icons.camera_alt_rounded,
                            color: _bull.primaryColor,
                            size: 32,
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 28),

              // Info
              _ActionBtn(
                icon: Icons.info_outline_rounded,
                label: 'ARCore',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '🐂 Tap the floor to place the bull.\n'
                        '📸 Hit the shutter to save to gallery.',
                        style: GoogleFonts.nunito(
                            color: Colors.white, fontSize: 12),
                      ),
                      backgroundColor: _bull.primaryColor,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
                color: Colors.white54,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Helper widgets
// ─────────────────────────────────────────────────────────────────────────────
class _TopBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  const _TopBtn(
      {required this.icon,
      required this.onTap,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(
                color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
      );
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  const _ActionBtn(
      {required this.icon,
      required this.label,
      required this.onTap,
      this.color = Colors.white54});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.09),
                shape: BoxShape.circle,
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.18)),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.nunito(
                  color: Colors.white54,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
//  Data model
// ─────────────────────────────────────────────────────────────────────────────
class _BullDef {
  final String name;
  final String nameTamil;
  final String asset;
  final String emoji;
  final Color primaryColor;
  final Color accentColor;

  const _BullDef({
    required this.name,
    required this.nameTamil,
    required this.asset,
    required this.emoji,
    required this.primaryColor,
    required this.accentColor,
  });
}
