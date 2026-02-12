// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'dart:io';
import 'dart:math' as math;
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

Future bpmTracking(BuildContext context) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black87,
    builder: (context) => const HeartMeasureScreen(),
  );
}

class HeartMeasureScreen extends StatefulWidget {
  const HeartMeasureScreen({super.key});

  @override
  State<HeartMeasureScreen> createState() => _HeartMeasureScreenState();
}

class _HeartMeasureScreenState extends State<HeartMeasureScreen>
    with TickerProviderStateMixin {
  CameraController? _controller;
  bool _hasPermission = false;
  bool _loadingCamera = true;
  bool _torchSupported = false;

  // Tab control: 0 = Heart Rate, 1 = SpO2
  int _selectedTab = 0;

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

  // --- SpO2 Measurement State
  static const int spo2MeasurementSeconds = 15;
  double _spo2Progress = 0.0;
  Timer? _spo2ProgressTimer;
  bool _spo2Measuring = false;
  bool _spo2Paused = false;
  bool _spo2MeasurementComplete = false;
  int? _currentSpO2;
  int? _finalSpO2;

  // --- SpO2 Signal Processing
  List<double> _redValues = [];
  List<double> _irValues = []; // Simulated IR values
  bool _spo2FingerDetected = false;
  bool _spo2ValidSignal = false;
  int _spo2SteadyCount = 0;
  List<int> _spo2History = []; // for smoothing SpO2

  // 🔴 RED detection – only start measurement when preview is red-ish
  bool _redDetected = false;
  int _redDebugCounter = 0;

  // --- Animation Controllers
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _tabController = TabController(length: 1, vsync: this);
    _tabController.addListener(_handleTabChange);
    _initAnimations();
    _initCamera();
    WakelockPlus.enable();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _selectedTab = _tabController.index;

        // Reset measurement states
        _resetHeartRateState();
        _resetSpO2State();

        _fadeController.reset();
        _scaleController.reset();
      });
    }
  }

  void _resetHeartRateState() {
    _progressTimer?.cancel();
    _progress = 0.0;
    _measuring = false;
    _paused = false;
    _measurementComplete = false;
    _currentBpm = null;
    _finalBpm = null;
    _fingerDetected = false;
    _validPulse = false;
    _steadyPulseCount = 0;
    _pulseTimestamps.clear();
    _waveformPoints.clear();

    _brightnessHistory.clear(); // Android
    _recent.clear(); // iOS
    _holdFrames = 0; // iOS

    _rmssd = null;
    _sdnn = null;
    _stressScore = null;
    _energyScore = null;
    _heartScore = null;

    _stopHaptics();
  }

  void _resetSpO2State() {
    _spo2ProgressTimer?.cancel();
    _spo2Progress = 0.0;
    _spo2Measuring = false;
    _spo2Paused = false;
    _spo2MeasurementComplete = false;
    _currentSpO2 = null;
    _finalSpO2 = null;
    _spo2FingerDetected = false;
    _spo2ValidSignal = false;
    _spo2SteadyCount = 0;
    _redValues.clear();
    _irValues.clear();
    _spo2History.clear();
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
  void dispose() {
    _progressTimer?.cancel();
    _spo2ProgressTimer?.cancel();
    _stopHaptics();
    try {
      _controller?.dispose();
    } catch (_) {}
    _controller = null;
    _fadeController.dispose();
    _scaleController.dispose();
    _tabController.dispose();
    WakelockPlus.disable();
    super.dispose();
  }

  Future<void> _initCamera() async {
    print("🔍 Starting camera initialization...");

    var perm = await Permission.camera.status;
    print("🔍 Initial camera permission status: $perm");

    if (!perm.isGranted) {
      print("📱 Requesting camera permission...");
      perm = await Permission.camera.request();
      print("📱 Permission after request: $perm");
    }

    if (perm.isDenied || perm.isPermanentlyDenied) {
      setState(() {
        _hasPermission = false;
        _loadingCamera = false;
      });

      if (perm.isPermanentlyDenied) {
        _showPermissionDialog();
      }
      return;
    }

    if (perm.isGranted) {
      print("✅ Camera permission granted, initializing camera...");

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
          print("❌ No camera found on device");
          setState(() {
            _hasPermission = false;
            _loadingCamera = false;
          });
          return;
        }

        final controller = CameraController(
          camera,
          ResolutionPreset.low,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.yuv420,
        );

        await controller.initialize();
        _addCameraListeners();
        print("✅ Camera initialized");

        try {
          await controller.setFlashMode(FlashMode.torch);
          _torchSupported = true;
          print("✅ Torch mode enabled");
        } catch (e) {
          print("⚠️ Torch mode not supported on this device: $e");
          _torchSupported = false;
        }

        setState(() {
          _controller = controller;
          _hasPermission = true;
          _loadingCamera = false;
        });

        _controller?.startImageStream(_processImage);
        print("✅ Camera stream started");
      } catch (e) {
        print("❌ Camera initialization error: $e");
        setState(() {
          _hasPermission = false;
          _loadingCamera = false;
        });
      }
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

    if (_selectedTab == 0 && !_measurementComplete) {
      _processHeartRateImage(image);
    } else if (_selectedTab == 1 && !_spo2MeasurementComplete) {
      _processSpO2Image(image);
    }
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
  /*bool _updateRedDetection(CameraImage image) {
    try {
      if (image.planes.isEmpty) return false;

      final int width = image.width;
      final int height = image.height;

      // Y plane
      final Plane yPlane = image.planes[0];
      final Uint8List yBytes = yPlane.bytes;
      final int yRowStride = yPlane.bytesPerRow;
      final int yPixelStride = yPlane.bytesPerPixel ?? 1;

      // UV planes differ by platform.
      Uint8List? uBytes;
      Uint8List? vBytes;
      int uRowStride = 0, vRowStride = 0;
      int uPixelStride = 0, vPixelStride = 0;

      if (Platform.isAndroid && image.planes.length >= 3) {
        // Android: planes[1] = U, planes[2] = V
        final Plane uPlane = image.planes[1];
        final Plane vPlane = image.planes[2];
        uBytes = uPlane.bytes;
        vBytes = vPlane.bytes;
        uRowStride = uPlane.bytesPerRow;
        vRowStride = vPlane.bytesPerRow;
        uPixelStride = uPlane.bytesPerPixel ?? 1;
        vPixelStride = vPlane.bytesPerPixel ?? 1;
      } else if (Platform.isIOS && image.planes.length >= 2) {
        // iOS: planes[1] = interleaved UV (CbCr)
        final Plane uvPlane = image.planes[1];
        uBytes = uvPlane.bytes;
        vBytes = uvPlane.bytes; // same buffer, offset by 1
        uRowStride = uvPlane.bytesPerRow;
        vRowStride = uvPlane.bytesPerRow;
        uPixelStride = (uvPlane.bytesPerPixel ?? 2);
        vPixelStride = (uvPlane.bytesPerPixel ?? 2);
      } else {
        return false;
      }

      double sumR = 0, sumG = 0, sumB = 0;
      int sampleCount = 0;

      // Sample a coarse grid in middle area
      const int step = 12;
      final int startX = width ~/ 4;
      final int endX = width * 3 ~/ 4;
      final int startY = height ~/ 4;
      final int endY = height * 3 ~/ 4;

      for (int y = startY; y < endY; y += step) {
        for (int x = startX; x < endX; x += step) {
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

            if (uIndex >= 0 && uIndex < uBytes!.length) {
              U = uBytes[uIndex];
            }
            if (vIndex >= 0 && vIndex < vBytes!.length) {
              V = vBytes[vIndex];
            }
          } else if (Platform.isIOS && image.planes.length >= 2) {
            final int uvRow = (y ~/ 2);
            final int uvCol = (x ~/ 2);

            final int baseIndex = uvRow * uRowStride + uvCol * uPixelStride;

            if (baseIndex + 1 < uBytes!.length) {
              U = uBytes[baseIndex];
              V = vBytes![baseIndex + 1];
            }
          }

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
          sampleCount++;
        }
      }

      if (sampleCount == 0) return false;

      final double avgR = sumR / sampleCount;
      final double avgG = sumG / sampleCount;
      final double avgB = sumB / sampleCount;
      final double avgGB = (avgG + avgB) / 2.0;

      // "Red-ish": red clearly dominates & not too dark/bright
      final double redRatio = avgR / (avgGB + 1.0);
      final bool isRed = avgR > 60.0 && redRatio > 1.10;

      _redDebugCounter++;
      if (_redDebugCounter % 30 == 0) {
        print(
            '🎨 [${Platform.isIOS ? 'iOS' : 'Android'}] avgR=$avgR avgG=$avgG avgB=$avgB redRatio=$redRatio isRed=$isRed');
      }

      return isRed;
    } catch (e) {
      print('⚠️ RGB / red detection error: $e');
      return false;
    }
  }*/

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
  /*void _processHeartRateImage(CameraImage image) {
    if (_measurementComplete) return;

    // 🔴 Update red detection for this frame
    _redDetected = _updateRedDetection(image);

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

    bool fingerNow;

    if (isIOS) {
      // iOS finger detection
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

      fingerNow = mean < _darkThreshold && variance < _varThreshold;

      // gate new detection by red frame
      if (!_fingerDetected && !_redDetected) {
        fingerNow = false;
      }

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
          setState(() {
            _fingerDetected = false;
            _validPulse = false;
            _currentBpm = null;
          });
        }
        _holdFrames = 0;
      }
    } else {
      // Android HR detection
      _brightnessHistory.add(brightness);
      if (_brightnessHistory.length > 50) _brightnessHistory.removeAt(0);

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

      // gate new detection by red frame
      if (!_fingerDetected && !_redDetected) {
        fingerNow = false;
      }

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
        }
      }
    }

    if (!_fingerDetected) {
      setState(() {
        _validPulse = false;
        _steadyPulseCount = 0;
        _currentBpm = null;
      });
      return;
    }

    _waveformPoints.add(brightness);
    if (_waveformPoints.length > 150) _waveformPoints.removeAt(0);

    bool foundPulse = false;
    if (_waveformPoints.length > 12) {
      int idx = _waveformPoints.length - 6;
      if (idx > 2 && idx + 2 < _waveformPoints.length) {
        double pre1 = _waveformPoints[idx - 2];
        double pre0 = _waveformPoints[idx - 1];
        double cur = _waveformPoints[idx];
        double nxt0 = _waveformPoints[idx + 1];
        double nxt1 = _waveformPoints[idx + 2];

        // local minimum = pulse valley
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

    if (foundPulse) {
      if (!_validPulse) {
        _steadyPulseCount++;
        if (_steadyPulseCount >= 3) {
          setState(() => _validPulse = true);
          print("✅ Valid HR pulse found, starting HR progress");
          _startProgress();
        }
      } else {
        // ✅ Robust realtime BPM: trimmed mean of RR intervals
        if (_pulseTimestamps.length >= 6) {
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

            final avgInterval =
                trimmed.reduce((a, b) => a + b) / trimmed.length;
            final bpm = (60000 / avgInterval).round();

            if (bpm > 40 && bpm < 200) {
              setState(() {
                _currentBpm = bpm;
              });
            }

            if (_pulseTimestamps.length % 5 == 0) {
              print(
                  '📈 HR realtime -> intervals=$intervals trimmed=$trimmed bpm=$bpm');
            }
          }
        }
      }
    }

    if (_measuring && (!_fingerDetected || !_validPulse)) {
      _stopProgress(pause: true);
    }
  }*/

  // ======================= SpO₂ ======================= //

  void _processSpO2Image(CameraImage image) {
    if (_spo2MeasurementComplete) return;

    // 🔴 Update red detection for this frame
    _redDetected = _updateRedDetection(image);

    double redTotal = 0;
    int n = 0;

    for (final plane in image.planes) {
      final bytes = plane.bytes;
      for (int i = 0; i < bytes.length; i++) {
        redTotal += bytes[i];
        n++;
      }
      break;
    }
    if (n == 0) return;

    final double redValue = redTotal / n;

    // Simulate IR value (NOT medical)
    final double irValue =
        redValue * (0.85 + math.Random().nextDouble() * 0.15);

    _redValues.add(redValue);
    _irValues.add(irValue);
    if (_redValues.length > 60) {
      _redValues.removeAt(0);
      _irValues.removeAt(0);
    }

    if (_redValues.length < 25) return;

    final double avgRed =
        _redValues.reduce((a, b) => a + b) / _redValues.length;
    final double stdRed = math.sqrt(
      _redValues.fold(0.0, (sum, val) => sum + math.pow(val - avgRed, 2)) /
          _redValues.length,
    );

    final bool isIOS = Platform.isIOS;
    bool fingerNow;

    if (isIOS) {
      const double spo2DarkThreshold = 140.0;
      fingerNow = avgRed < spo2DarkThreshold;
    } else {
      final double avgThreshold = _torchSupported ? 85.0 : 120.0;
      final double stdThreshold = _torchSupported ? 8.0 : 15.0;
      fingerNow = avgRed < avgThreshold && stdRed < stdThreshold;
    }

    // gate new detection by red frame
    if (!_spo2FingerDetected && !_redDetected) {
      fingerNow = false;
    }

    if (fingerNow != _spo2FingerDetected) {
      setState(() => _spo2FingerDetected = fingerNow);

      if (fingerNow) {
        print(
            "👉 SpO₂ FINGER DETECTED! avgRed=$avgRed stdRed=$stdRed red=$_redDetected");
        _spo2SteadyCount = 0;
        _spo2ValidSignal = false;
      } else {
        print(
            "👋 SpO₂ FINGER REMOVED! avgRed=$avgRed stdRed=$stdRed red=$_redDetected");
        _spo2ValidSignal = false;
        _spo2SteadyCount = 0;
        _stopSpO2Progress(pause: true);
      }
    }

    if (_spo2FingerDetected) {
      _spo2SteadyCount++;

      if (_spo2SteadyCount >= 25) {
        if (!_spo2ValidSignal) {
          setState(() => _spo2ValidSignal = true);
          print("✅ Valid SpO₂ signal found, starting SpO₂ progress");
          _startSpO2Progress();
        }

        if (_redValues.length >= 35 && _irValues.length >= 35) {
          double acRed = _calculateAC(_redValues);
          double dcRed = avgRed;
          double acIR = _calculateAC(_irValues);
          double dcIR = _irValues.reduce((a, b) => a + b) / _irValues.length;

          if (dcRed > 0 && dcIR > 0 && acIR > 0) {
            double ratio = (acRed / dcRed) / (acIR / dcIR);

            int spo2 = (110 - 25 * ratio).round();
            spo2 = spo2.clamp(85, 100);

            _spo2History.add(spo2);
            if (_spo2History.length > 15) {
              _spo2History.removeAt(0);
            }

            int displaySpO2 = spo2;
            if (_spo2History.length >= 5) {
              final sorted = [..._spo2History]..sort();
              displaySpO2 = sorted[sorted.length ~/ 2];
            }

            setState(() {
              _currentSpO2 = displaySpO2;
            });

            if (_spo2History.length % 5 == 0) {
              print(
                  '📊 SpO₂ raw=$spo2, median=$displaySpO2, ratio=$ratio, acR=$acRed acIR=$acIR');
            }
          }
        }
      }
    } else {
      setState(() {
        _spo2ValidSignal = false;
        _spo2SteadyCount = 0;
        _currentSpO2 = null;
      });
    }

    if (_spo2Measuring && (!_spo2FingerDetected || !_spo2ValidSignal)) {
      _stopSpO2Progress(pause: true);
    }
  }

  double _calculateAC(List<double> values) {
    if (values.isEmpty) return 0;
    double max = values.reduce((a, b) => a > b ? a : b);
    double min = values.reduce((a, b) => a < b ? a : b);
    return (max - min) / 2;
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

  // ======================= SpO₂ PROGRESS ======================= //

  void _startSpO2Progress() {
    if (_spo2Measuring) return;
    setState(() {
      _spo2Measuring = true;
      _spo2Paused = false;
    });

    _spo2ProgressTimer =
        Timer.periodic(const Duration(milliseconds: 80), (timer) {
      if (!_spo2FingerDetected || !_spo2ValidSignal || !_spo2Measuring) {
        return;
      }
      setState(() {
        _spo2Progress += 0.8 / (spo2MeasurementSeconds * 12.5);
        if (_spo2Progress >= 1.0) {
          _spo2Progress = 1.0;
          _spo2ProgressTimer?.cancel();
          _finalSpO2 = _currentSpO2;
          _showSpO2Result();
        }
      });
    });
  }

  void _stopSpO2Progress({bool pause = false}) {
    _spo2ProgressTimer?.cancel();
    setState(() {
      _spo2Measuring = !pause;
      if (!pause) _spo2Progress = 0.0;
      _spo2Paused = pause;
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

    final rr = _getRrIntervalsMs(_pulseTimestamps);

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
  }

  void _showSpO2Result() async {
    _spo2ProgressTimer?.cancel();
    setState(() {
      _spo2MeasurementComplete = true;
    });

    int spo2ToShow = _currentSpO2 ?? 0;
    if (_spo2History.length >= 5) {
      final sorted = [..._spo2History]..sort();
      spo2ToShow = sorted[sorted.length ~/ 2];
    }

    setState(() {
      _finalSpO2 = spo2ToShow;
    });

    print('✅ SpO₂ RESULT -> SpO2=$_finalSpO2%');

    await _fadeController.forward();

    try {
      await _controller?.stopImageStream();
    } catch (e) {
      print("Error stopping image stream SpO₂: $e");
    }

    if (_torchSupported) {
      try {
        await _controller?.setFlashMode(FlashMode.off);
      } catch (e) {
        print("Error turning off torch SpO₂: $e");
      }
    }

    WakelockPlus.disable();
    _scaleController.forward();
  }

  void _handleDone() {
    _navigatingAway = true;
    _stopHaptics();
    try {
      _controller?.dispose();
    } catch (_) {}
    _controller = null;

    if (_selectedTab == 0) {
      Navigator.of(context).pop(_finalBpm);
    } else {
      Navigator.of(context).pop(_finalSpO2);
    }
  }

  // ======================= UI ======================= //

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final circleSize = size.width * 0.7;

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: FlutterFlowTheme.of(context).customColor3,
            ),
            child: Icon(
              Icons.close,
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          onPressed: _handleDone,
        ),
        centerTitle: true,
        title: Text(
          'Measure Heart',
          style: const TextStyle(
            color: Colors.pink,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
        ),
        child: _loadingCamera
            ? _buildLoadingScreen()
            : !_hasPermission
                ? _buildPermissionDeniedScreen()
                : Column(
                    children: [
                      _buildTabBar(),
                      Expanded(
                        child: Stack(
                          children: [
                            if (_selectedTab == 0 && !_measurementComplete)
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: _buildMeasurementScreen(circleSize),
                              ),
                            if (_selectedTab == 0 && _measurementComplete)
                              _buildResultScreen(size),
                            if (_selectedTab == 1 && !_spo2MeasurementComplete)
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: _buildSpO2MeasurementScreen(circleSize),
                              ),
                            if (_selectedTab == 1 && _spo2MeasurementComplete)
                              _buildSpO2ResultScreen(size),
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 16, right: 16, left: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(30),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black87,
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite, size: 20),
                SizedBox(width: 8),
                Text('Heart Rate'),
              ],
            ),
          ),
          // SpO₂ tab hidden for now (length=1)
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
      mainAxisAlignment: MainAxisAlignment.center,
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
                    width: circleSize * 0.9,
                    height: circleSize * 0.9,
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
                    width: circleSize * 0.85,
                    height: circleSize * 0.85,
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

                // OUTER PROGRESS RING
                CustomPaint(
                  size: Size(circleSize, circleSize),
                  painter: ProgressArcPainter(
                    progress: _progress,
                    color: Colors.pink,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
              left: 24.0, right: 24.0, top: 35.0, bottom: 20.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                _getStatusText(),
                key: ValueKey(_getStatusText()),
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
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
              : Image(
                  image: NetworkImage(
                      'https://tmypgcoijrkezcsmuogy.supabase.co/storage/v1/object/public/user/plan_faq/guid.png'),
                  height: 300,
                ),
        ),
      ],
    );
  }

  Widget _buildSpO2MeasurementScreen(double circleSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              _getSpO2StatusText(),
              key: ValueKey(_getSpO2StatusText()),
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Center(
          child: SizedBox(
            width: circleSize,
            height: circleSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipOval(
                  child: SizedBox(
                    width: circleSize * 0.85,
                    height: circleSize * 0.85,
                    child: (_controller != null &&
                            _controller!.value.isInitialized)
                        ? CameraPreview(_controller!)
                        : Container(
                            color: Colors.grey[900],
                            child: const Center(
                              child: Icon(Icons.air,
                                  color: Colors.black, size: 60),
                            ),
                          ),
                  ),
                ),
                CustomPaint(
                  size: Size(circleSize, circleSize),
                  painter: ProgressArcPainter(
                    progress: _spo2Progress,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Container(
          height: 90,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: CustomPaint(
            painter: SpO2WavePainter(points: _redValues),
          ),
        ),
        const SizedBox(height: 24),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: _currentSpO2 == null
              ? const SizedBox(height: 50, key: ValueKey('empty_spo2'))
              : Column(
                  children: [
                    Text(
                      '$_currentSpO2%',
                      key: ValueKey(_currentSpO2),
                      style: const TextStyle(
                        fontSize: 56,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const Text(
                      'SpO₂',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
        ),
        const Spacer(),
        Text(
          '${(_spo2Progress * spo2MeasurementSeconds).round()} / $spo2MeasurementSeconds seconds',
          style: const TextStyle(color: Colors.black87, fontSize: 16),
        ),
        const SizedBox(height: 32),
      ],
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
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_rounded, color: bpmColor, size: 80),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${_finalBpm ?? 0}',
                            style: TextStyle(
                              fontSize: 50,
                              color: bpmColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          Text(
                            'BPM',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[600],
                              letterSpacing: 4,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Normal HR Range',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '55 – 120 BPM',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'at rest',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.pink.withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Heart Rate Variability (HRV)',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _metricTile(
                                  label: 'RMSSD',
                                  value: rmssd > 0
                                      ? '${rmssd.toStringAsFixed(0)} ms'
                                      : '--',
                                ),
                                _metricTile(
                                  label: 'SDNN',
                                  value: sdnn > 0
                                      ? '${sdnn.toStringAsFixed(0)} ms'
                                      : '--',
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Higher HRV (RMSSD, SDNN) is usually associated with better recovery and lower stress.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // 📊 Stress / Energy / Heart Score card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Stress, Energy & Heart Score',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _metricTile(
                                  label: 'STRESS',
                                  value: stress > 0
                                      ? '${stress.toStringAsFixed(0)}%'
                                      : '--',
                                ),
                                _metricTile(
                                  label: 'ENERGY',
                                  value: energy > 0
                                      ? '${energy.toStringAsFixed(0)}%'
                                      : '--',
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'HEART SCORE',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  heartScore > 0
                                      ? '${heartScore.toStringAsFixed(0)}/100'
                                      : '--',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              stressLabel,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: bpmColor,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 18),
                          elevation: 4,
                        ),
                        onPressed: _handleDone,
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
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

  Widget _metricTile({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSpO2ResultScreen(Size screenSize) {
    final spo2 = _finalSpO2 ?? 0;

    String status;
    Color statusColor;

    if (spo2 >= 95) {
      status = 'Normal';
      statusColor = Colors.green;
    } else if (spo2 >= 92) {
      status = 'Slightly Low';
      statusColor = Colors.orangeAccent;
    } else {
      status = 'Low';
      statusColor = Colors.redAccent;
    }

    final Color spo2Color = spo2 < 95 ? Colors.orange : Colors.blue;

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
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.air, color: spo2Color, size: 100),
                      const SizedBox(height: 15),
                      Text(
                        '$spo2%',
                        style: TextStyle(
                          fontSize: 70,
                          color: spo2Color,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'SpO₂',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey[600],
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Blood Oxygen Level',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Normal Range',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '95% – 100%',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'at rest in healthy adults',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: statusColor.withOpacity(0.5)),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: statusColor,
                              child: const Icon(Icons.circle,
                                  size: 12, color: Colors.white),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Status: $status',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: spo2Color,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 18),
                          elevation: 4,
                        ),
                        onPressed: _handleDone,
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
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
      return 'Place your finger gently on the camera and cover the flash.';
    } else if (!_validPulse) {
      return 'Hold still... calibrating your pulse.';
    } else if (_paused) {
      return 'Progress paused – keep your finger steady.';
    } else if (_measuring) {
      return 'Measuring your heart rate...';
    }
    return 'Ready to measure.';
  }

  String _getSpO2StatusText() {
    if (!_spo2FingerDetected) {
      return 'Place your finger on the camera and cover the flash.';
    } else if (!_spo2ValidSignal) {
      return 'Hold still... detecting oxygen signal.';
    } else if (_spo2Paused) {
      return 'Progress paused – keep your finger steady.';
    } else if (_spo2Measuring) {
      return 'Measuring blood oxygen...';
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
    final stroke = 12.0;
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

class SpO2WavePainter extends CustomPainter {
  final List<double> points;

  SpO2WavePainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blueAccent, Colors.blue[300]!],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final min = points.reduce((a, b) => a < b ? a : b);
    final max = points.reduce((a, b) => a > b ? a : b);
    final span = (max - min).abs() < 1 ? 1.0 : (max - min);

    final double dx =
        points.length > 1 ? size.width / (points.length - 1) : size.width;
    final double cy = size.height / 2;

    final path = Path();
    for (int i = 0; i < points.length; i++) {
      final norm = (points[i] - min) / span;
      final y = cy - ((norm - 0.5) * cy * 1.6);
      final x = i * dx;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SpO2WavePainter old) => true;
}
