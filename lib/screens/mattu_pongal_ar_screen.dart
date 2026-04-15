import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ar_flutter_plugin_2/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_2/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin_2/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_2/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin_2/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_2/models/ar_anchor.dart';
import 'package:ar_flutter_plugin_2/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin_2/models/ar_node.dart';
import 'package:vector_math/vector_math_64.dart' as vm;
import 'package:saver_gallery/saver_gallery.dart';
import 'package:permission_handler/permission_handler.dart';

class MattuPongalARScreen extends StatefulWidget {
  const MattuPongalARScreen({super.key});

  @override
  State<MattuPongalARScreen> createState() => _MattuPongalARScreenState();
}

class _MattuPongalARScreenState extends State<MattuPongalARScreen>
    with SingleTickerProviderStateMixin {
  ARSessionManager? _sessionMgr;
  ARObjectManager? _objMgr;
  ARAnchorManager? _anchorMgr;

  final List<ARNode> _nodes = [];
  final List<ARAnchor> _anchors = [];

  static const _kTeal      = Color(0xFF00C9A7);
  static const _kTealLight = Color(0xFF1DE9B6);
  static const _kPanel     = Color(0xFF0D1117);

  static const _bulls = [
    _BullDef(
      name: 'Astronaut',
      nameTamil: 'சோதனை',
      asset: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
      icon: Icons.rocket_launch_rounded,
      isWeb: true,
    ),
    _BullDef(
      name: 'Kangayam Bull',
      nameTamil: 'காங்கேயம் காளை',
      asset: 'assets/models/bull.glb',
      imagePath: 'assets/images/jallikattu_bull_ar.jpg',
    ),
    _BullDef(
      name: 'Majestic Bull',
      nameTamil: 'கம்பீரமான காளை',
      asset: 'assets/models/majestic_horned_bull.glb',
      icon: Icons.auto_awesome_rounded,
    ),
  ];

  late _BullDef _bull = _bulls[1]; // Default to Kangayam Bull
  bool _placing = false;
  String _hint = 'Scan floor until purple grids appear...';
  String _statusMessage = 'Engine: Initializing';

  // Scale & elevation tracking
  double _scale = 0.5;
  double _baseScale = 0.5;
  double _yOffset = 0.0; // Elevation tracking
  ARNode? _activeNode;

  // Flash effect for snapshot
  bool _showFlash = false;

  // Manual pinch to zoom
  final Map<int, Offset> _activePointers = {};
  double _initialPinchDistance = 0.0;
  double _pinchBaseScale = 0.5;

  void _onPointerDown(PointerDownEvent event) {
    _activePointers[event.pointer] = event.position;
    if (_activePointers.length == 2) {
      _initialPinchDistance = _calculateDistance();
      _pinchBaseScale = _scale;
    }
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (_activePointers.containsKey(event.pointer)) {
      _activePointers[event.pointer] = event.position;
    }
    if (_activePointers.length == 2 && _activeNode != null) {
      final currentDistance = _calculateDistance();
      if (_initialPinchDistance > 0) {
        final zoomFactor = currentDistance / _initialPinchDistance;
        setState(() {
          _scale = (_pinchBaseScale * zoomFactor).clamp(0.05, 5.0);
        });
        _applyScaleToNode();
      }
    }
  }

  void _onPointerUp(PointerEvent event) {
    _activePointers.remove(event.pointer);
    if (_activePointers.length < 2) {
      _initialPinchDistance = 0.0;
    }
  }

  double _calculateDistance() {
    final positions = _activePointers.values.toList();
    if (positions.length < 2) return 0.0;
    final dx = positions[0].dx - positions[1].dx;
    final dy = positions[0].dy - positions[1].dy;
    return math.sqrt(dx * dx + dy * dy);
  }

  @override
  void dispose() {
    _sessionMgr?.dispose();
    super.dispose();
  }

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
      showFeaturePoints: false,
      showPlanes: true,
      showWorldOrigin: false,
      handlePans: true,
      handleRotation: true,
    );
    objMgr.onInitialize();
    sessionMgr.onPlaneOrPointTap = _onPlaneTapped;

    setState(() {
      _hint = 'Grids visible! SELECT MODEL and TAP THE GRID.';
      _statusMessage = 'Engine: Tracking Active';
    });
  }

  /// Returns the corrected rotation quaternion so GLB models stand upright.
  /// bull.glb is often exported lying flat → rotate 90° around X axis.
  vm.Vector4 _getUprightRotation(_BullDef bull) {
    if (bull.isWeb) {
      // Astronaut is fine as-is
      return vm.Vector4(0.0, 0.0, 0.0, 0.0);
    }
    // ARNode rotation requires an Axis-Angle representation -> Vector4(x, y, z, angle)
    // Rotate 90 degrees around X axis to stand the model upright
    const angle = -math.pi / 2; // -90° to stand up
    return vm.Vector4(
      1.0, // x axis
      0.0, // y axis
      0.0, // z axis
      angle,
    );
  }

  Future<void> _onPlaneTapped(List<ARHitTestResult> hits) async {
    if (_placing || _sessionMgr == null) return;

    final hit = hits.firstWhere(
      (h) => h.type == ARHitTestResultType.plane,
      orElse: () => hits.first,
    );

    setState(() {
      _placing = true;
      _hint = 'Loading 3D Object on Grid... ⏳';
    });

    final anchor = ARPlaneAnchor(transformation: hit.worldTransform);
    final added = await _anchorMgr!.addAnchor(anchor);
    if (added != true) {
      setState(() {
        _placing = false;
        _hint = 'Anchor Fail. Try another spot.';
      });
      return;
    }
    _anchors.add(anchor);

    final node = ARNode(
      type: _bull.isWeb ? NodeType.webGLB : NodeType.localGLTF2,
      uri: _bull.asset,
      scale: vm.Vector3(_scale, _scale, _scale),
      // Fix flat model: rotate upright
      rotation: _getUprightRotation(_bull),
    );

    final success = await _objMgr!.addNode(node, planeAnchor: anchor);

    if (success == true) {
      _nodes.add(node);
      _activeNode = node;
      setState(() {
        _placing = false;
        _hint = '✅ ${_bull.name} placed!\nPinch to zoom and Pan to move';
        _statusMessage = 'Last Node: SUCCESS';
      });
    } else {
      _anchorMgr!.removeAnchor(anchor);
      setState(() {
        _placing = false;
        _hint = '❌ LOAD FAILED! Try Diagnostic model.';
        _statusMessage = 'Last Node: FAILED';
      });
    }
  }

  void _forcePlace() async {
    if (_sessionMgr == null) return;
    setState(() {
      _hint = 'Force placing model 1m in front...';
      _placing = true;
    });

    final node = ARNode(
      type: _bull.isWeb ? NodeType.webGLB : NodeType.localGLTF2,
      uri: _bull.asset,
      scale: vm.Vector3(_scale, _scale, _scale),
      position: vm.Vector3(0, 0, -1.0),
      rotation: _getUprightRotation(_bull),
    );

    final success = await _objMgr!.addNode(node);
    if (success == true) {
      _nodes.add(node);
      _activeNode = node;
      setState(() {
        _placing = false;
        _hint = '✅ Force Load Success!\nPinch to zoom and Pan to move';
        _statusMessage = 'Force Node: SUCCESS';
      });
    } else {
      setState(() {
        _placing = false;
        _hint = '❌ Force Load Failed!';
        _statusMessage = 'Force Node: FAILED';
      });
    }
  }

  /// Apply current scale to the active node
  void _applyScaleToNode() {
    if (_activeNode == null) return;
    _activeNode!.scale = vm.Vector3(_scale, _scale, _scale);
  }

  void _clearAll() {
    for (var a in _anchors) {
      _anchorMgr?.removeAnchor(a);
    }
    _anchors.clear();
    _nodes.clear();
    _activeNode = null;
    setState(() {
      _hint = 'Cleared! Tap the grid again.';
      _statusMessage = 'Engine: Ready';
      _scale = 0.5;
      _yOffset = 0.0;
    });
  }

  void _applyElevation() {
    if (_activeNode != null) {
      final pos = _activeNode!.position;
      _activeNode!.position = vm.Vector3(pos.x, _yOffset, pos.z);
    }
  }

  // ── Screenshot helper ─────────────────────────────────────────────────
  void _showSnack(String msg, {Color bg = Colors.black87}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: bg,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _takeScreenshot() async {
    if (_sessionMgr == null) {
      _showSnack('❌ AR session not ready', bg: Colors.red);
      return;
    }

    try {
      // ── 1. Flash effect ───────────────────────────────────────────
      setState(() => _showFlash = true);
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted) setState(() => _showFlash = false);
      });

      // ── 2. Request Permissions ─────────────────────────────────────
      bool granted = false;
      if (Platform.isAndroid) {
        final sdkInt = await _androidSdkVersion();
        if (sdkInt >= 33) {
          granted = (await Permission.photos.request()).isGranted;
        } else {
          granted = (await Permission.storage.request()).isGranted;
        }
      } else {
        granted = true;
      }

      if (!granted) {
        _showSnack('❌ Permission denied', bg: Colors.red);
        return;
      }

      // ── 3. Capture Snapshot ────────────────────────────────────────
      final dynamic result = await _sessionMgr!.snapshot();
      Uint8List? bytes;

      if (result is Uint8List) {
        bytes = result;
      } else if (result is ImageProvider) {
        final Completer<ui.Image> completer = Completer<ui.Image>();
        (result as ImageProvider).resolve(const ImageConfiguration()).addListener(
          ImageStreamListener(
            (ImageInfo info, bool _) => completer.complete(info.image),
            onError: (e, st) => completer.completeError(e),
          ),
        );
        final ui.Image image = await completer.future;
        final bd = await image.toByteData(format: ui.ImageByteFormat.png);
        bytes = bd?.buffer.asUint8List();
      }

      if (bytes == null || bytes.isEmpty) {
        _showSnack('❌ Capture failed', bg: Colors.red);
        return;
      }

      // ── 4. Snap Preview (Snap Not Save) ────────────────────────────
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF1A1D21),
          title: Text('📸 Snap Captured', 
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.memory(bytes!),
              ),
              const SizedBox(height: 16),
              Text('Keep this memory in your gallery?', 
                style: GoogleFonts.inter(color: Colors.white70, fontSize: 13)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Discard', style: TextStyle(color: Colors.white38)),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(ctx);
                _showSnack('💾 Saving...');
                final fileName = 'mattu_pongal_${DateTime.now().millisecondsSinceEpoch}';
                await SaverGallery.saveImage(
                  bytes!,
                  quality: 95,
                  fileName: fileName,
                  skipIfExists: false,
                  androidRelativePath: 'Pictures/TamilCulture',
                );
                _showSnack('✅ Saved to Gallery!', bg: Colors.green);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _kTeal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Save Photo'),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('_takeScreenshot error: $e');
      _showSnack('❌ Error: $e', bg: Colors.red);
    }
  }

  /// Returns the Android SDK version integer (e.g. 33 for Android 13).
  Future<int> _androidSdkVersion() async {
    try {
      const ch = MethodChannel('flutter/platform');
      final info = await ch.invokeMethod<Map>('getOperatingSystemVersion');
      // Fallback: assume modern
      return int.tryParse(info?['sdkInt']?.toString() ?? '33') ?? 33;
    } catch (_) {
      // Use permission_handler introspection instead
      if (await Permission.photos.status != PermissionStatus.denied ||
          await Permission.photos.isGranted) {
        return 33; // photos permission exists → API 33+
      }
      return 28;
    }
  }

  @override
  Widget build(BuildContext context) {
    const teal      = _kTeal;
    const tealLight = _kTealLight;
    const panelBg   = _kPanel;

    final bool isActive = _statusMessage.contains('Active') ||
        _statusMessage.contains('SUCCESS');

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ── AR view ─────────────────────────────────
          Listener(
            onPointerDown: _onPointerDown,
            onPointerMove: _onPointerMove,
            onPointerUp: _onPointerUp,
            onPointerCancel: _onPointerUp,
            child: ARView(
              onARViewCreated: _onARViewCreated,
              planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
            ),
          ),

          // ── Center Reticle (Aiming Grid) ──────────────────────────────
          Center(
            child: Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24, width: 1.0),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),

          // ── Flash effect overlay ──────────────────────────────────────
          if (_showFlash)
            Positioned.fill(
              child: Container(color: Colors.white),
            ),

          // ── Placing overlay ──────────────────────────────────────────
          if (_placing)
            Container(
              color: Colors.black54,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 56, height: 56,
                      child: CircularProgressIndicator(
                        color: teal, strokeWidth: 2.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Placing model…',
                      style: GoogleFonts.inter(
                        color: Colors.white70, fontSize: 13,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // ── Top bar ──────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      // Back button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 42, height: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black54,
                            border: Border.all(color: Colors.white12),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white, size: 17,
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Status pill
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: isActive
                              ? teal.withOpacity(0.15)
                              : Colors.red.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isActive ? teal : Colors.red,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6, height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isActive ? tealLight : Colors.red,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _statusMessage,
                              style: GoogleFonts.inter(
                                color: isActive ? tealLight : Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Hint card with teal left accent
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 3, height: 36,
                          decoration: BoxDecoration(
                            color: teal,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _hint,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // UI overlays (Removed manual zoom/drag buttons)

          // ── Vertical Elevation Slider (Left side) ──────────────────────
          if (_activeNode != null)
            Positioned(
              left: 14,
              top: 180,
              bottom: 240,
              child: Column(
                children: [
                   const Icon(Icons.arrow_upward_rounded, color: Colors.white38, size: 20),
                   Expanded(
                     child: RotatedBox(
                       quarterTurns: 3,
                       child: SliderTheme(
                         data: SliderThemeData(
                           activeTrackColor: teal,
                           inactiveTrackColor: Colors.white10,
                           thumbColor: Colors.white,
                           trackHeight: 3,
                         ),
                         child: Slider(
                           value: _yOffset,
                           min: -2.0,
                           max: 2.0,
                           onChanged: (v) {
                             setState(() => _yOffset = v);
                             _applyElevation();
                           },
                         ),
                       ),
                     ),
                   ),
                   const Icon(Icons.arrow_downward_rounded, color: Colors.white38, size: 20),
                ],
              ),
            ),

          // ── Bottom panel ─────────────────────────────────────────────
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: panelBg.withOpacity(0.65),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                    border: Border(
                      top: BorderSide(color: teal.withOpacity(0.35), width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 34),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                  // drag handle
                  Container(
                    width: 36, height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // (Removed scale slider)

                  // Model picker
                  SizedBox(
                    height: 90,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _bulls.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      itemBuilder: (ctx, i) {
                        final b = _bulls[i];
                        final isSel = _bull == b;
                        return GestureDetector(
                          onTap: () => setState(() => _bull = b),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            width: 90,
                            decoration: BoxDecoration(
                              color: isSel
                                  ? teal.withOpacity(0.10)
                                  : Colors.white.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSel ? teal : Colors.white10,
                                width: isSel ? 1.5 : 1,
                              ),
                              boxShadow: isSel
                                  ? [
                                      BoxShadow(
                                        color: teal.withOpacity(0.18),
                                        blurRadius: 12,
                                      )
                                    ]
                                  : [],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Badge / Thumbnail
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 220),
                                  width: 44, height: 44,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: (isSel && b.imagePath == null)
                                        ? const LinearGradient(
                                            colors: [
                                              Color(0xFF00C9A7),
                                              Color(0xFF009688),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          )
                                        : null,
                                    color: isSel && b.imagePath == null
                                        ? null
                                        : Colors.white.withOpacity(0.06),
                                    border: Border.all(
                                      color: isSel
                                          ? teal
                                          : Colors.white12,
                                      width: isSel ? 2 : 1,
                                    ),
                                    image: b.imagePath != null
                                        ? DecorationImage(
                                            image: AssetImage(b.imagePath!),
                                            fit: BoxFit.cover,
                                            colorFilter: isSel 
                                                ? null 
                                                : ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                                          )
                                        : null,
                                  ),
                                  child: b.imagePath == null
                                      ? Icon(
                                          b.icon,
                                          color: isSel
                                              ? Colors.white
                                              : Colors.white30,
                                          size: 22,
                                        )
                                      : null,
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  b.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    color: isSel
                                        ? Colors.white
                                        : Colors.white30,
                                    fontSize: 9,
                                    fontWeight: isSel
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Action row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Force Load
                      GestureDetector(
                        onTap: () {
                           _forcePlace();
                           _showSnack('🎯 Aim center at floor and PLACE!');
                        },
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: teal.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: teal.withOpacity(0.5)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add_location_alt_rounded, color: teal, size: 18),
                              const SizedBox(width: 6),
                              Text(
                                'PLACE MANUALLY',
                                style: GoogleFonts.inter(
                                  color: teal,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Shutter button
                      GestureDetector(
                        onTap: _takeScreenshot,
                        child: Container(
                          width: 68, height: 68,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: teal, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: teal.withOpacity(0.4),
                                blurRadius: 20,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: teal, size: 28,
                          ),
                        ),
                      ),

                      // Reset
                      GestureDetector(
                        onTap: _clearAll,
                        child: Container(
                          width: 48, height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.08),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: const Icon(
                            Icons.refresh_rounded,
                            color: Colors.white, size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
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

// ── Small teal circle icon button ────────────────────────────────────
class _TealCircleBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TealCircleBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF00C9A7);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42, height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: teal.withOpacity(0.12),
          border: Border.all(color: teal.withOpacity(0.45)),
        ),
        child: Icon(icon, color: teal, size: 20),
      ),
    );
  }
}

class _BullDef {
  final String name, nameTamil, asset;
  final IconData? icon;
  final String? imagePath;
  final bool isWeb;

  const _BullDef({
    required this.name,
    required this.nameTamil,
    required this.asset,
    this.icon,
    this.imagePath,
    this.isWeb = false,
  });
}
