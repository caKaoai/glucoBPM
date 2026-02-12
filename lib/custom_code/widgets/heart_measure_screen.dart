// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../../auth/supabase_auth/auth_util.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'dart:io';
import 'dart:math' as math;
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class HeartMeasureScreen extends StatefulWidget {
  const HeartMeasureScreen({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<HeartMeasureScreen> createState() => _HeartMeasureScreenState();
}

class _HeartMeasureScreenState extends State<HeartMeasureScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  CameraController? _controller;
  bool _hasPermission = false;
  bool _loadingCamera = true;
  bool _torchSupported = false;

  // --- Heart Rate Measurement State
  static const int measurementSeconds = 30;
  double _progress = 0.0;
  Timer? _progressTimer;
  bool _measuring = false;
  bool _paused = false;
  bool _navigatingAway = false;
  bool _measurementComplete = false;
  int? _currentBpm;
  int? _finalBpm;

  // 🔔 HAPTIC
  Timer? _hapticTimer;

  // --- Heart Rate Signal Processing
  List<double> _brightnessHistory = []; // ANDROID brightness history
  List<double> _waveformPoints = [];
  List<int> _pulseTimestamps = [];
  bool _fingerDetected = false;
  bool _validPulse = false;
  int _steadyPulseCount = 0;

  // ✅ iOS-only HR finger detection
  static const int _recentWindow = 30;
  static const int _requiredHold = 20;
  static const double _darkThreshold = 110;
  static const double _varThreshold = 40;
  final List<double> _recent = [];
  int _holdFrames = 0;

  // --- HRV Metrics ---
  double? _rmssd; // ms
  double? _sdnn; // ms
  double? _stressScore; // 0 - 100
  double? _energyScore; // 0 - 100
  double? _heartScore; // 0 - 100

  // 🔴 RED detection – only start measurement when preview is red-ish
  bool _redDetected = false;
  int _redDebugCounter = 0;

  // --- Animation Controllers
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _initAnimations();
    _initCamera();
    WakelockPlus.enable();
  }

  void _initAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("🔄 App resumed — checking camera permission");

      _handlePermissionOnResume();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _progressTimer?.cancel();
    _stopHaptics();
    try {
      _controller?.dispose();
    } catch (_) {}
    _controller = null;
    _fadeController.dispose();
    _scaleController.dispose();
    WakelockPlus.disable();
    super.dispose();
  }

  Future<void> _handlePermissionOnResume() async {
    if (!mounted) return;

    final status = await Permission.camera.status;

    print("📷 Resume permission status: $status");

    if (status.isGranted) {
      // If camera not initialized, re-init
      if (_controller == null || !_controller!.value.isInitialized) {
        print("📷 Re-initializing camera after settings");

        setState(() {
          _loadingCamera = true;
          _hasPermission = true;
        });

        await _initCamera();
      }
    } else {
      setState(() {
        _hasPermission = false;
        _loadingCamera = false;
      });
    }
  }

  Future<void> _initCamera() async {
    if (!mounted) return;

    setState(() {
      _loadingCamera = true;
    });

    print("🔍 Checking camera permission...");

    var status = await Permission.camera.status;

    if (status.isDenied) {
      status = await Permission.camera.request();
    }

    // 🚨 If still denied → go to settings
    if (status.isDenied) {
      print("❌ Permission denied — redirecting to settings");
      _redirectToSettings();
      return;
    }

    if (status.isPermanentlyDenied) {
      print("❌ Permission permanently denied — redirecting to settings");
      _redirectToSettings();
      return;
    }

    if (!status.isGranted) {
      setState(() {
        _hasPermission = false;
        _loadingCamera = false;
      });
      return;
    }

    print("✅ Permission granted — initializing camera");

    await _initializeCameraController();
  }

  void _redirectToSettings() async {
    setState(() {
      _hasPermission = false;
      _loadingCamera = false;
    });

    await openAppSettings();

    if (!mounted) return;

    // When user comes back, lifecycle will re-check permission
  }

  Future<void> _initializeCameraController() async {
    try {
      final cameras = await availableCameras();
      CameraDescription? camera;

      for (final cam in cameras) {
        if (cam.lensDirection == CameraLensDirection.back) {
          camera = cam;
          break;
        }
      }
      camera ??= cameras.isNotEmpty ? cameras.first : null;

      if (camera == null) {
        throw Exception("No camera found");
      }

      final controller = CameraController(
        camera,
        ResolutionPreset.low,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      await controller.initialize();

      _addCameraListeners();

      try {
        await controller.setFlashMode(FlashMode.torch);
        _torchSupported = true;
      } catch (_) {
        _torchSupported = false;
      }

      setState(() {
        _controller = controller;
        _hasPermission = true;
        _loadingCamera = false;
      });

      await _controller?.startImageStream(_processImage);

      print("✅ Camera fully ready");
    } catch (e) {
      print("❌ Camera init error: $e");
      setState(() {
        _hasPermission = false;
        _loadingCamera = false;
      });
    }
  }

  void _addCameraListeners() {
    _controller?.addListener(() {
      // Called on orientation changes and session interruptions
      if (_controller?.value.isInitialized == true &&
          _controller?.value.isStreamingImages == true) {
        if (_torchSupported &&
            _controller!.value.flashMode != FlashMode.torch) {
          _controller!.setFlashMode(FlashMode.torch);
        }
      }
    });
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.camera_alt, color: Colors.pink, size: 28),
            SizedBox(width: 12),
            Text('Camera Permission Required'),
          ],
        ),
        content: const Text(
          'This app needs camera access to measure your heart rate and SpO₂ using the camera flash and lens. '
          'Please enable camera permission in Settings.',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _processImage(CameraImage image) {
    if (_navigatingAway) return;

    _processHeartRateImage(image);
  }

  // ======================= RGB / RED detection ======================= //
  bool _updateRedDetection(CameraImage image) {
    try {
      if (image.planes.isEmpty) return false;

      final int width = image.width;
      final int height = image.height;

      // Y plane
      final Plane yPlane = image.planes[0];
      final Uint8List yBytes = yPlane.bytes;
      final int yRowStride = yPlane.bytesPerRow;
      final int yPixelStride = yPlane.bytesPerPixel ?? 1;

      // UV planes
      Uint8List? uBytes;
      Uint8List? vBytes;
      int uRowStride = 0, vRowStride = 0;
      int uPixelStride = 0, vPixelStride = 0;

      if (Platform.isAndroid && image.planes.length >= 3) {
        final Plane uPlane = image.planes[1];
        final Plane vPlane = image.planes[2];
        uBytes = uPlane.bytes;
        vBytes = vPlane.bytes;
        uRowStride = uPlane.bytesPerRow;
        vRowStride = vPlane.bytesPerRow;
        uPixelStride = uPlane.bytesPerPixel ?? 1;
        vPixelStride = vPlane.bytesPerPixel ?? 1;
      } else if (Platform.isIOS && image.planes.length >= 2) {
        final Plane uvPlane = image.planes[1];
        uBytes = uvPlane.bytes;
        vBytes = uvPlane.bytes;
        uRowStride = uvPlane.bytesPerRow;
        vRowStride = uvPlane.bytesPerRow;
        uPixelStride = (uvPlane.bytesPerPixel ?? 2);
        vPixelStride = (uvPlane.bytesPerPixel ?? 2);
      } else {
        return false;
      }

      // Sample the ENTIRE circular area densely
      final int centerX = width ~/ 2;
      final int centerY = height ~/ 2;
      final int minDim = width < height ? width : height;
      final double radius = minDim * 0.42; // Match your camera circle UI

      int redOrangeSamples = 0; // Count pixels that are red/orange
      int totalSamples = 0;

      double sumR = 0, sumG = 0, sumB = 0;

      // Dense sampling - step of 6 for thorough coverage
      const int step = 6;

      for (int y = 0; y < height; y += step) {
        for (int x = 0; x < width; x += step) {
          // Only sample points inside the circle
          final dx = (x - centerX).toDouble();
          final dy = (y - centerY).toDouble();
          final distanceSquared = dx * dx + dy * dy;

          if (distanceSquared > radius * radius) continue;

          final int yIndex = y * yRowStride + x * yPixelStride;
          if (yIndex < 0 || yIndex >= yBytes.length) continue;
          final int Y = yBytes[yIndex];

          int U = 128;
          int V = 128;

          if (Platform.isAndroid && image.planes.length >= 3) {
            final int uvRow = (y ~/ 2);
            final int uvCol = (x ~/ 2);
            final int uIndex = uvRow * uRowStride + uvCol * uPixelStride;
            final int vIndex = uvRow * vRowStride + uvCol * vPixelStride;
            if (uIndex >= 0 && uIndex < uBytes!.length) U = uBytes[uIndex];
            if (vIndex >= 0 && vIndex < vBytes!.length) V = vBytes[vIndex];
          } else if (Platform.isIOS && image.planes.length >= 2) {
            final int uvRow = (y ~/ 2);
            final int uvCol = (x ~/ 2);
            final int baseIndex = uvRow * uRowStride + uvCol * uPixelStride;
            if (baseIndex + 1 < uBytes!.length) {
              U = uBytes[baseIndex];
              V = vBytes![baseIndex + 1];
            }
          }

          // Convert YUV to RGB
          final double yf = Y.toDouble();
          final double uf = U.toDouble() - 128.0;
          final double vf = V.toDouble() - 128.0;

          double r = yf + 1.402 * vf;
          double g = yf - 0.344136 * uf - 0.714136 * vf;
          double b = yf + 1.772 * uf;

          r = r.clamp(0.0, 255.0);
          g = g.clamp(0.0, 255.0);
          b = b.clamp(0.0, 255.0);

          sumR += r;
          sumG += g;
          sumB += b;
          totalSamples++;

          // STRICT RED/ORANGE CHECK:
          // 1. Red must be dominant: R > G and R > B
          // 2. Must have warm tone: R - B > 20 (clear separation)
          // 3. Not too dark: R > 60
          // 4. Not too bright/washed out: R < 240
          // 5. Green should be less than red: G < R (avoids yellow/white)

          final bool isRedOrOrange = (r > g) &&
              (r > b) &&
              (r - b > 20.0) &&
              (r > 60.0) &&
              (r < 240.0) &&
              (g < r * 0.9); // G must be at least 10% less than R

          if (isRedOrOrange) {
            redOrangeSamples++;
          }
        }
      }

      if (totalSamples == 0) return false;

      final double avgR = sumR / totalSamples;
      final double avgG = sumG / totalSamples;
      final double avgB = sumB / totalSamples;
      final double coveragePercent = (redOrangeSamples / totalSamples) * 100.0;

      // STRICT REQUIREMENT:
      // - At least 85% of the circle must be red/orange
      // - Overall average must also be red-dominant
      // - Clear warm tone in averages
      final bool isFullyCovered = coveragePercent >= 85.0 &&
          avgR > avgG &&
          avgR > avgB &&
          (avgR - avgB) > 15.0;

      // Debug output every 20 frames
      if (_redDebugCounter++ % 20 == 0) {
        print(
            '🔴 RED COVERAGE: ${coveragePercent.toStringAsFixed(1)}% ($redOrangeSamples/$totalSamples) '
            '| avgRGB: R=${avgR.toStringAsFixed(0)} G=${avgG.toStringAsFixed(0)} B=${avgB.toStringAsFixed(0)} '
            '| R-B=${(avgR - avgB).toStringAsFixed(0)} '
            '| COVERED=$isFullyCovered');
      }

      return isFullyCovered;
    } catch (e) {
      print('⚠️ Red detection error: $e');
      return false;
    }
  }

  // ======================= HEART RATE ======================= //
  void _processHeartRateImage(CameraImage image) {
    if (_measurementComplete) return;

    // 🔴 Update red detection for this frame
    _redDetected = _updateRedDetection(image);

    // ⚠️ CRITICAL: If red is not detected, immediately stop/prevent finger detection
    if (!_redDetected) {
      if (_fingerDetected) {
        print('❌ RED COVERAGE LOST - stopping measurement');
        setState(() {
          _fingerDetected = false;
          _validPulse = false;
          _currentBpm = null;
          _steadyPulseCount = 0;
          _progress = 0.0; // 👈 RESET progress completely (optional)
        });
        _stopProgress(
            pause: false); // 👈 pause: false = complete stop, not pause
        _pulseTimestamps.clear();
        _waveformPoints.clear();
        _brightnessHistory.clear(); // Android
        _recent.clear(); // iOS
        _holdFrames = 0; // iOS
        _stopHaptics();
      }
      return; // Exit early - no red means no processing
    }

    // Calculate brightness
    double brightness;

    if (Platform.isIOS) {
      // iOS: sample every 20th byte
      final bytes = image.planes.first.bytes;
      double sum = 0;
      const step = 20;
      for (int i = 0; i < bytes.length; i += step) {
        sum += bytes[i];
      }
      brightness = sum / (bytes.length / step);
    } else {
      // Android: full average of Y plane
      double total = 0;
      int n = 0;
      for (final plane in image.planes) {
        final bytes = plane.bytes;
        for (int i = 0; i < bytes.length; i++) {
          total += bytes[i];
          n++;
        }
        break;
      }
      if (n == 0) return;
      brightness = total / n;
    }

    final bool isIOS = Platform.isIOS;
    bool fingerNow = false;

    if (isIOS) {
      // ============== iOS finger detection ==============
      _recent.add(brightness);
      if (_recent.length > _recentWindow) _recent.removeAt(0);

      if (_recent.length < _recentWindow) {
        return;
      }

      final mean = _recent.reduce((a, b) => a + b) / _recent.length;
      double variance = 0;
      for (final v in _recent) {
        variance += (v - mean) * (v - mean);
      }
      variance /= _recent.length;

      // Check if finger is detected based on darkness and low variance
      fingerNow = mean < _darkThreshold && variance < _varThreshold;

      if (fingerNow) {
        _holdFrames++;
        if (_holdFrames >= _requiredHold && !_fingerDetected) {
          setState(() {
            _fingerDetected = true;
            _steadyPulseCount = 0;
            _validPulse = false;
          });
          print(
              '👉 [iOS] HR finger CONFIRMED (mean=$mean, var=$variance, bright=$brightness, red=$_redDetected)');
        }
      } else {
        if (_fingerDetected) {
          print(
              '👋 [iOS] HR finger LOST (mean=$mean, var=$variance, bright=$brightness, red=$_redDetected)');
          _stopProgress(pause: true);
          _pulseTimestamps.clear();
          _waveformPoints.clear();
          setState(() {
            _fingerDetected = false;
            _validPulse = false;
            _currentBpm = null;
          });
        }
        _holdFrames = 0;
      }
    } else {
      // ============== Android finger detection ==============
      _brightnessHistory.add(brightness);
      if (_brightnessHistory.length > 50) _brightnessHistory.removeAt(0);

      if (_brightnessHistory.length < 25) {
        return; // Need minimum samples
      }

      final double avg = _brightnessHistory.reduce((a, b) => a + b) /
          _brightnessHistory.length;
      final double std = math.sqrt(
        _brightnessHistory.fold(
                0.0, (sum, val) => sum + math.pow(val - avg, 2)) /
            _brightnessHistory.length,
      );

      final double avgThreshold = _torchSupported ? 85.0 : 120.0;
      final double stdThreshold = _torchSupported ? 8.0 : 15.0;

      fingerNow = avg < avgThreshold && std < stdThreshold;

      if (fingerNow != _fingerDetected) {
        setState(() => _fingerDetected = fingerNow);

        if (fingerNow) {
          print(
              "👉 [Android] HR FINGER DETECTED! avg=$avg std=$std red=$_redDetected");
          _steadyPulseCount = 0;
          _validPulse = false;
        } else {
          print(
              "👋 [Android] HR FINGER REMOVED! avg=$avg std=$std red=$_redDetected");
          _validPulse = false;
          _steadyPulseCount = 0;
          _stopProgress(pause: true);
          _pulseTimestamps.clear();
          _waveformPoints.clear();
        }
      }
    }

    // If finger is not detected, reset everything and exit
    if (!_fingerDetected) {
      setState(() {
        _validPulse = false;
        _steadyPulseCount = 0;
        _currentBpm = null;
      });
      return;
    }

    // ============== Pulse Detection & BPM Calculation ==============

    // Add brightness to waveform for pulse detection
    _waveformPoints.add(brightness);
    if (_waveformPoints.length > 150) _waveformPoints.removeAt(0);

    // Detect pulse peaks/valleys
    bool foundPulse = false;
    if (_waveformPoints.length > 12) {
      int idx = _waveformPoints.length - 6;
      if (idx > 2 && idx + 2 < _waveformPoints.length) {
        double pre1 = _waveformPoints[idx - 2];
        double pre0 = _waveformPoints[idx - 1];
        double cur = _waveformPoints[idx];
        double nxt0 = _waveformPoints[idx + 1];
        double nxt1 = _waveformPoints[idx + 2];

        // Detect local minimum = pulse valley
        if (cur < pre1 && cur < pre0 && cur < nxt0 && cur < nxt1) {
          final now = DateTime.now().millisecondsSinceEpoch;
          if (_pulseTimestamps.isEmpty || now - _pulseTimestamps.last > 400) {
            _pulseTimestamps.add(now);
            if (_pulseTimestamps.length > 20) {
              _pulseTimestamps.removeAt(0);
            }
            foundPulse = true;
          }
        }
      }
    }

    // Handle pulse detection
    if (foundPulse) {
      if (!_validPulse) {
        // Need steady pulses before starting measurement
        _steadyPulseCount++;
        if (_steadyPulseCount >= 3) {
          setState(() => _validPulse = true);
          print("✅ Valid HR pulse found, starting HR progress");
          _startProgress();
        }
      } else {
        // ✅ Calculate realtime BPM using trimmed mean of RR intervals
        if (_pulseTimestamps.length >= 6) {
          final intervals = <int>[];
          for (int i = 1; i < _pulseTimestamps.length; i++) {
            intervals.add(_pulseTimestamps[i] - _pulseTimestamps[i - 1]);
          }

          if (intervals.isNotEmpty) {
            final sorted = [...intervals]..sort();

            // Use trimmed mean (remove outliers)
            int start = (sorted.length * 0.25).floor();
            int end = (sorted.length * 0.75).ceil();
            if (end <= start) {
              start = 0;
              end = sorted.length;
            }
            final trimmed = sorted.sublist(start, end);

            final avgInterval =
                trimmed.reduce((a, b) => a + b) / trimmed.length;
            final bpm = (60000 / avgInterval).round();

            // Validate BPM range
            if (bpm > 40 && bpm < 200) {
              setState(() {
                _currentBpm = bpm;
              });
            }

            // Debug output every 5 pulses
            if (_pulseTimestamps.length % 5 == 0) {
              print(
                  '📈 HR realtime -> intervals=$intervals trimmed=$trimmed bpm=$bpm');
            }
          }
        }
      }
    }

    // Stop progress if finger is detected but pulse is not valid
    if (_measuring && (!_fingerDetected || !_validPulse)) {
      _stopProgress(pause: true);
    }
  }

  // ======================= HAPTIC HELPERS ======================= //

  void _startHaptics() {
    _hapticTimer?.cancel();

    if (!_fingerDetected || !_validPulse) {
      return;
    }

    const duration = Duration(milliseconds: 700);

    _hapticTimer = Timer.periodic(duration, (timer) {
      if (!_measuring ||
          !_fingerDetected ||
          !_validPulse ||
          _measurementComplete ||
          _navigatingAway) {
        _stopHaptics();
        return;
      }

      HapticFeedback.heavyImpact();
    });

    print("🔔 Haptics started");
  }

  void _stopHaptics() {
    if (_hapticTimer != null) {
      _hapticTimer?.cancel();
      _hapticTimer = null;
      print("🔕 Haptics stopped");
    }
  }

  // ======================= HR PROGRESS ======================= //

  void _startProgress() {
    if (_measuring) return;
    setState(() {
      _measuring = true;
      _paused = false;
    });

    _startHaptics();

    _progressTimer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
      if (!_fingerDetected || !_validPulse || !_measuring) return;
      setState(() {
        _progress += 0.8 / (measurementSeconds * 12.5);
        if (_progress >= 1.0) {
          _progress = 1.0;
          _progressTimer?.cancel();
          _finalBpm = _currentBpm;
          _showResult();
        }
      });
    });
  }

  void _stopProgress({bool pause = false}) {
    _progressTimer?.cancel();
    _stopHaptics();
    setState(() {
      _measuring = !pause;
      if (!pause) _progress = 0.0;
      _paused = pause;
    });
  }

  // ======================= HRV HELPERS ======================= //

  List<double> _getRrIntervalsMs(List<int> timestamps) {
    if (timestamps.length < 2) return [];
    final rr = <double>[];
    for (int i = 1; i < timestamps.length; i++) {
      rr.add((timestamps[i] - timestamps[i - 1]).toDouble());
    }
    return rr;
  }

  double _computeRmssd(List<double> rr) {
    if (rr.length < 3) return 0.0;
    final diffsSq = <double>[];
    for (int i = 1; i < rr.length; i++) {
      final d = rr[i] - rr[i - 1];
      diffsSq.add(d * d);
    }
    if (diffsSq.isEmpty) return 0.0;
    final meanSq = diffsSq.reduce((a, b) => a + b) / diffsSq.length;
    return math.sqrt(meanSq);
  }

  double _computeSdnn(List<double> rr) {
    if (rr.length < 2) return 0.0;
    final mean = rr.reduce((a, b) => a + b) / rr.length;
    final varSum = rr.fold<double>(
      0.0,
      (sum, v) => sum + math.pow(v - mean, 2),
    );
    final variance = varSum / rr.length;
    return math.sqrt(variance);
  }

  Map<String, double> _deriveStressEnergy(double rmssd) {
    final r = rmssd.clamp(15.0, 120.0);
    final norm = ((r - 15.0) / (120.0 - 15.0)).clamp(0.0, 1.0);

    final energy = norm * 100.0;
    final stress = (1.0 - norm) * 100.0;

    return {
      'stress': stress,
      'energy': energy,
    };
  }

  double _computeHeartScore(int bpm, double stress, double energy) {
    double bpmScore;
    if (bpm <= 0) {
      bpmScore = 50.0;
    } else {
      final diff = (bpm - 70).abs().toDouble();
      bpmScore = (100.0 - diff * 1.2).clamp(40.0, 100.0);
    }

    final stressComponent = (100.0 - stress).clamp(0.0, 100.0);
    final energyComponent = energy.clamp(0.0, 100.0);

    final score =
        bpmScore * 0.4 + stressComponent * 0.3 + energyComponent * 0.3;

    return score.clamp(0.0, 100.0);
  }

  // ======================= RESULTS ======================= //

  void _openResultBottomSheet() {
    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      isDismissible: false,
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return Container(
          height: size.height * 0.96,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: _buildResultScreen(size),
        );
      },
    );
  }

  List<double> _filterRr(List<double> rr) {
    if (rr.isEmpty) return [];

    final mean = rr.reduce((a, b) => a + b) / rr.length;

    return rr.where((r) {
      return r > mean * 0.6 && r < mean * 1.4;
    }).toList();
  }

  void _showResult() async {
    _progressTimer?.cancel();
    _stopHaptics();
    setState(() {
      _measurementComplete = true;
    });

    int bpmToShow = _currentBpm ?? 0;

    // same trimmed-mean RR logic for final BPM
    if (_pulseTimestamps.length > 5) {
      final intervals = <int>[];
      for (int i = 1; i < _pulseTimestamps.length; i++) {
        intervals.add(_pulseTimestamps[i] - _pulseTimestamps[i - 1]);
      }

      if (intervals.isNotEmpty) {
        final sorted = [...intervals]..sort();

        int start = (sorted.length * 0.25).floor();
        int end = (sorted.length * 0.75).ceil();
        if (end <= start) {
          start = 0;
          end = sorted.length;
        }
        final trimmed = sorted.sublist(start, end);

        final avgInterval = trimmed.reduce((a, b) => a + b) / trimmed.length;

        bpmToShow = (60000 / avgInterval).round();

        if (bpmToShow < 40 || bpmToShow > 200) {
          bpmToShow = 0;
        }

        print(
            '📊 HR final -> intervals=$intervals trimmed=$trimmed avgInterval=$avgInterval bpm=$bpmToShow');
      }
    }

    final rrRaw = _getRrIntervalsMs(_pulseTimestamps);
    final rr = _filterRr(rrRaw);

    double rmssd = 0.0;
    double sdnn = 0.0;

    // Default neutral scores if not enough data
    double stress = 50.0;
    double energy = 50.0;

    if (rr.length >= 3) {
      rmssd = _computeRmssd(rr);
      sdnn = _computeSdnn(rr);

      if (rmssd > 0) {
        final scores = _deriveStressEnergy(rmssd);
        stress = scores['stress'] ?? 50.0;
        energy = scores['energy'] ?? 50.0;
      }
    } else {
      print('⚠️ Not enough RR intervals for HRV, using neutral stress/energy.');
    }

    final double heartScore = _computeHeartScore(bpmToShow, stress, energy);

    setState(() {
      _finalBpm = bpmToShow;
      _rmssd = rmssd;
      _sdnn = sdnn;
      _stressScore = stress;
      _energyScore = energy;
      _heartScore = heartScore;
    });

    print(
        '✅ RESULT -> BPM=$_finalBpm, RMSSD=$_rmssd ms, SDNN=$_sdnn ms, stress=$_stressScore, energy=$_energyScore, heartScore=$_heartScore');

    await _fadeController.forward();

    try {
      await _controller?.stopImageStream();
    } catch (e) {
      print("Error stopping image stream HR: $e");
    }

    if (_torchSupported) {
      try {
        await _controller?.setFlashMode(FlashMode.off);
      } catch (e) {
        print("Error turning off torch HR: $e");
      }
    }

    WakelockPlus.disable();
    _scaleController.forward();
    // 🔥 OPEN RESULT SCREEN
    if (loggedIn) {
      FFAppState().updateUserTrackingStruct(
        (e) => e
          ..date = DateTime.now().toUtc()
          ..bpmTrackToday = true,
      );
    }
    _openResultBottomSheet();
    if (loggedIn) {
      await UserBPMTable().insert({
        'pluse': _finalBpm,
        'hrv': rmssd.toStringAsFixed(0),
        'user_id': currentUserUid,
        'created_at': supaSerialize<DateTime>(DateTime.now().toUtc()),
      });
      await action_blocks.bpmInfo(context);
    }
  }

  // ======================= UI ======================= //

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size / 1;
    final circleSize = size.width * 0.7;

    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: _loadingCamera
          ? _buildLoadingScreen()
          : !_hasPermission
              ? _buildPermissionDeniedScreen()
              : Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: _buildMeasurementScreen(circleSize),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildLoadingScreen() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
            strokeWidth: 3,
          ),
          SizedBox(height: 24),
          Text(
            'Initializing camera...',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionDeniedScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.camera_alt_outlined, color: Colors.pink, size: 80),
            const SizedBox(height: 24),
            const Text(
              'Camera Permission Denied',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Please enable camera permission in your device settings.',
              style: TextStyle(color: Colors.black, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurementScreen(double circleSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            width: circleSize,
            height: circleSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // CAMERA CIRCLE

                ClipOval(
                  child: SizedBox(
                    width: circleSize * 0.8,
                    height: circleSize * 0.8,
                    child: (_controller != null &&
                            _controller!.value.isInitialized)
                        ? CameraPreview(_controller!)
                        : Container(
                            color: Colors.grey[900],
                            child: const Center(
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                                size: 60,
                              ),
                            ),
                          ),
                  ),
                ),

                // BPM TEXT
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: circleSize * 0.75,
                    height: circleSize * 0.75,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: _currentBpm == null
                          ? const SizedBox(key: ValueKey('empty'))
                          : Center(
                              key: const ValueKey('bpm'),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '$_currentBpm',
                                    style: const TextStyle(
                                      fontSize: 56,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  const Text(
                                    '🩷 BPM',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      letterSpacing: 3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
                CustomPaint(
                  size: Size(250, 250),
                  painter: ProgressArcPainter(
                    progress: _progress,
                    color: Colors.pink,
                  ),
                ),
                // OUTER PROGRESS RING
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                _getStatusText(),
                key: ValueKey(_getStatusText()),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _measuring
              ? Lottie.asset(
                  'assets/jsons/ECG.json',
                  key: const ValueKey('ecg_lottie'),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.contain,
                  animate: true,
                )
              : SizedBox(
                  key: ValueKey('ecg_hidden'),
                  child: Image(
                    image: NetworkImage(
                        'https://tmypgcoijrkezcsmuogy.supabase.co/storage/v1/object/public/user/plan_faq/guid.png'),
                  ),
                ),
        ),
      ],
    );
  }

  Widget heartResultSummaryCard({
    required int bpm,
    required double rmssd,
    required double stress,
  }) {
    // Status logic (simple + readable)
    String status;
    if (stress <= 35) {
      status = 'GOOD';
    } else if (stress <= 65) {
      status = 'MODERATE';
    } else {
      status = 'HIGH';
    }

    final String dateText = DateFormat('dd MMM').format(DateTime.now());

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF13AD59),
            Color(0xFF0B7737),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Heart Data',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 18,
                      letterSpacing: 0.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
              Text(
                dateText,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 14,
                      letterSpacing: 0.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Message
          Text(
            'Normal heart rate—a positive sign.\n'
            'Continue the good work to maintain a healthy heart!',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                  fontSize: 14,
                  letterSpacing: 0.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                ),
          ),

          const SizedBox(height: 16),

          // ── Divider
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.4),
          ),

          const SizedBox(height: 16),

          // ── Metrics Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _heartMetric(
                  label: 'HRV',
                  value: rmssd > 0 ? rmssd.toStringAsFixed(0) : '--',
                  unit: 'ms',
                ),
              ),
              _verticalDivider(),
              Expanded(
                flex: 2,
                child: _heartMetric(
                  label: 'STATUS',
                  value: status,
                  unit: '',
                  highlight: true,
                ),
              ),
              _verticalDivider(),
              Expanded(
                child: _heartMetric(
                  label: 'PULSE',
                  value: bpm > 0 ? bpm.toString() : '--',
                  unit: 'bpm',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heartMetric({
    required String label,
    required String value,
    required String unit,
    bool highlight = false,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                fontSize: 12,
                letterSpacing: 0.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                useGoogleFonts:
                    !FlutterFlowTheme.of(context).bodyMediumIsCustom,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                fontSize: highlight ? 16 : 14,
                letterSpacing: 0.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                useGoogleFonts:
                    !FlutterFlowTheme.of(context).bodyMediumIsCustom,
              ),
        ),
        if (unit.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            unit,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                  fontSize: 12,
                  letterSpacing: 0.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                ),
          ),
        ],
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 48,
      color: Colors.white.withOpacity(0.4),
    );
  }

  Widget _buildResultScreen(Size screenSize) {
    final Color bpmColor = (_finalBpm ?? 0) < 55 || (_finalBpm ?? 0) > 120
        ? Colors.orange
        : Colors.pink;

    final double rmssd = _rmssd ?? 0.0;
    final double sdnn = _sdnn ?? 0.0;
    final double stress = _stressScore ?? 0.0;
    final double energy = _energyScore ?? 0.0;
    final double heartScore = _heartScore ?? 0.0;

    String stressLabel;
    if (stress <= 0) {
      stressLabel = 'Not enough data';
    } else if (stress < 30) {
      stressLabel = 'Low stress';
    } else if (stress < 60) {
      stressLabel = 'Moderate stress';
    } else {
      stressLabel = 'High stress';
    }

    return ScaleTransition(
      scale: _scaleAnimation,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Generated code for this Row Widget...
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8,
                            buttonSize: 40,
                            icon: Icon(
                              Icons.clear,
                              color: FlutterFlowTheme.of(context).customColor1,
                              size: 30,
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                          Expanded(
                            child: Text(
                              'Measure Result',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    fontSize: 20,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8,
                            buttonSize: 40,
                            icon: Icon(
                              Icons.clear,
                              color: FlutterFlowTheme.of(context).secondary,
                              size: 24,
                            ),
                            onPressed: null,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      heartResultSummaryCard(
                        bpm: _finalBpm ?? 0,
                        rmssd: _rmssd ?? 0,
                        stress: _stressScore ?? 50,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _getStatusText() {
    if (!_fingerDetected) {
      return 'Put your index finger on one of the back camera until the circle turns red.';
    } else if (!_validPulse) {
      return 'Hold still... calibrating your pulse.';
    } else if (_paused) {
      return 'Progress paused – keep your finger steady.';
    } else if (_measuring) {
      return 'Measuring your heart rate...';
    }
    return 'Ready to measure.';
  }
}

// ======================= DRAWING WIDGETS ======================= //

class ProgressArcPainter extends CustomPainter {
  final double progress;
  final Color color;

  ProgressArcPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = 10.0;
    final center = size.center(Offset.zero);
    final radius = (size.width / 2) - stroke / 2;

    final bg = Paint()
      ..color = Colors.black.withOpacity(0.08)
      ..strokeWidth = stroke
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bg);

    final fg = Paint()
      ..shader = LinearGradient(
        colors: [color.withOpacity(0.9), color],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final sweep = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweep,
      false,
      fg,
    );
  }

  @override
  bool shouldRepaint(covariant ProgressArcPainter old) =>
      old.progress != progress || old.color != color;
}
