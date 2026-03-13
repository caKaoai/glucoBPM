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

import '../../meal_scan/recent_meal/recent_meal_widget.dart';
import '../../meal_scan/text_meal/text_meal_widget.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:camera/camera.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:image_picker/image_picker.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';
import '../../backend/api_requests/api_manager.dart';
import '../../flutter_flow/flutter_flow_animations.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';

Future<String?> customCamera(BuildContext context) async {
  // Add your function code here!
  final result = await showModalBottomSheet<String>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: false,
    enableDrag: false,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: const SizedBox(
            height: double.infinity,
            child: CustomCamara(
              width: double.infinity,
              height: 600,
            ),
          ),
        ),
      );
    },
  );

  return result;
}

class CustomCamara extends StatefulWidget {
  const CustomCamara({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<CustomCamara> createState() => _CustomCamaraState();
}

class _CustomCamaraState extends State<CustomCamara>
    with TickerProviderStateMixin {
  bool isDataUploading2 = false;
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _isFlashOn = false;
  bool isCamarShow = false;
  String? publicUrl = '';
  final animationsMap = <String, AnimationInfo>{};
  File? _previewFile;
  String? localFile;
  int currentType = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      displayCamera(); // Call after build completes to avoid layout issues
    });
    animationsMap.addAll({
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 120.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containserOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.linear,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: Offset(
                0.0,
                valueOrDefault<double>(
                  600.0,
                  600.0,
                )),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'containserOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: null,
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  displayCamera() async {
    await _initCamera(); // Wait for the camera to initialize
    safeSetState(() {
      isCamarShow = true;
    });
  }

  _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _controller = CameraController(
          cameras[0],
          ResolutionPreset.high,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.jpeg,
        );
        _initializeControllerFuture = _controller!.initialize().then((_) {
          _controller?.lockCaptureOrientation(DeviceOrientation.portraitUp);
        });
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  Future<void> _toggleFlash() async {
    if (_controller != null) {
      _isFlashOn = !_isFlashOn;
      await _controller!.setFlashMode(
        _isFlashOn ? FlashMode.torch : FlashMode.off,
      );
      setState(() {});
    }
  }

  Future<File?> pickImageFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return null;
    return await _resizeImage(File(picked.path), context, source: 'gallery');
  }

  Future<File?> _captureImage() async {
    try {
      await _initializeControllerFuture;
      final XFile xfile = await _controller!.takePicture();
      final file =
          await _resizeImage(File(xfile.path), context, source: 'captured');
      if (_isFlashOn) await _toggleFlash();
      return file;
    } catch (e) {
      debugPrint('❌ Capture error: $e');
      customTostNotification(
          context, 'Capture failed', FlutterFlowTheme.of(context).error, 1);
      return null;
    }
  }

  Future<File?> _resizeImage(File file, BuildContext context,
      {required String source}) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) {
      debugPrint('❌ Failed to decode $source image');
      return null;
    }

    // Resize image to exactly 1000px height, maintaining aspect ratio
    final resized = img.copyResize(image, height: 1000);

    // Encode resized image as JPEG with 90% quality
    final resizedBytes =
        Uint8List.fromList(img.encodeJpg(resized, quality: 90));

    // Save to temporary file
    final tempDir = await getTemporaryDirectory();
    final fileName = '${source}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final resizedFile = File('${tempDir.path}/$fileName')
      ..writeAsBytesSync(resizedBytes);

    return resizedFile;
  }

  Future<void> uploadToSupabase(File file) async {
    try {
      final storage = Supabase.instance.client.storage;
      final filePath = 'food_img/${file.uri.pathSegments.last}';
      final result = await storage
          .from('user')
          .upload(filePath, file, fileOptions: const FileOptions(upsert: true));
      if (result.isEmpty) {
        debugPrint('Upload failed');
        return;
      }

      final url = storage.from('user').getPublicUrl(filePath);
      setState(() => publicUrl = url);
      // debugPrint('✅ Uploaded image URL: $url');
    } catch (e) {
      debugPrint('❌ Upload error: $e');
      customTostNotification(
          context, 'Upload failed', FlutterFlowTheme.of(context).error, 1);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).customColor2,
      ),
      child: Stack(
        children: [
          if (isCamarShow) ...[
            customCamara(),
          ],
          if (_previewFile != null)
            Image.file(
              key: Key('${_previewFile}'),
              _previewFile!,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FlutterFlowIconButton(
                              borderRadius: 100,
                              showLoadingIndicator: true,
                              fillColor: Colors.black,
                              icon: Icon(
                                Icons.chevron_left_rounded,
                                color: FlutterFlowTheme.of(context).info,
                                size: 28,
                              ),
                              onPressed: () async {
                                Navigator.pop(context, () {
                                  return null;
                                }());
                              },
                            ),
                            if (isCamarShow == true)
                              FlutterFlowIconButton(
                                borderRadius: 100,
                                fillColor: Colors.black,
                                buttonSize: 40,
                                icon: Icon(
                                  Icons.flash_on,
                                  color: _isFlashOn
                                      ? FlutterFlowTheme.of(context).primary
                                      : FlutterFlowTheme.of(context).text1,
                                  size: 24,
                                ),
                                onPressed: _toggleFlash,
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 35, 0, 40),
                        child: (_previewFile == null)
                            ? Text(
                                languagefuncation(
                                        'ready_to_snap_your_meal',
                                        FFLocalizations.of(context)
                                            .languageCode,
                                        FFAppState().translationsCSV) ??
                                    'ready_to_snap_your_meal',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context).info,
                                      fontSize: 18,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              )
                            : const SizedBox.shrink(),
                      ),
                      if (_previewFile == null)
                        Container(
                          width: 288,
                          height: 288,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SvgPicture.asset(
                                  'assets/images/food_frame.svg',
                                  width: 288,
                                  height: 288,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Lottie.asset(
                                  'assets/jsons/scanning.json',
                                  width: 250.2,
                                  height: 250.1,
                                  fit: BoxFit.fill,
                                  animate: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: _previewFile == null ? null : 212,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: _previewFile == null
                      ? customImagePicker()
                      : revertImage(),
                ),
              ),
            ],
          ),
        ],
      ),
    )
        .animateOnPageLoad(animationsMap['containserOnPageLoadAnimation']!)
        .animateOnActionTrigger(
      animationsMap['containserOnActionTriggerAnimation']!,
      effects: [
        MoveEffect(
          curve: Curves.linear,
          delay: 0.0.ms,
          duration: 400.0.ms,
          begin: Offset(0.0, 0.0),
          end: Offset(
              0.0,
              valueOrDefault<double>(
                800.0,
                800.0,
              )),
        ),
      ],
    );
  }

  openCamera() async {
    HapticFeedback.heavyImpact();

    // Check permission first (blocking operation)
    final hasPermission = await Permission.camera.isGranted;
    if (!hasPermission) {
      await AppSettings.openAppSettings(
        type: AppSettingsType.camera,
      );
      return;
    }

    // Clear previous preview immediately
    setState(() {
      _previewFile = null;
    });

    if (!isCamarShow) {
      // Initialize and show camera
      await _initCamera();
      setState(() {
        isCamarShow = true;
      });
    } else {
      // Capture image
      final capturedFile = await _captureImage();

      if (capturedFile != null) {
        // Update UI with captured image and reset state in single setState
        setState(() {
          _previewFile = capturedFile;
          _isFlashOn = false;
          isCamarShow = false;
        });
      } else {
        // Reset state if capture failed
        setState(() {
          _isFlashOn = false;
          isCamarShow = false;
        });
      }
    }
  }

  Widget revertImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 27.0, right: 27.0, top: 39.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              FlutterFlowIconButton(
                icon: Icon(
                  Icons.refresh_sharp,
                ),
                borderRadius: 100.0,
                buttonSize: 56,
                fillColor: Color(0xFFF5F5F5),
                onPressed: openCamera,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                languagefuncation(
                        'retake',
                        FFLocalizations.of(context).languageCode,
                        FFAppState().translationsCSV) ??
                    "RETAKE",
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      color: Color(0xFF64748B),
                      fontSize: 10.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w700,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              )
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 58.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFEF4444).withOpacity(0.30),
                        offset: const Offset(0, 4),
                        blurRadius: 6,
                        spreadRadius: -4,
                      ),
                      BoxShadow(
                        color: const Color(0xFFEF4444).withOpacity(0.30),
                        offset: const Offset(0, 10),
                        blurRadius: 15,
                        spreadRadius: -3,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    await HapticFeedback.heavyImpact();

                    if (_previewFile != null) {
                      await uploadToSupabase(_previewFile!);
                    }
                    Future(() async {
                      await Future.delayed(const Duration(milliseconds: 1000));
                    });
                    if (animationsMap['containserOnActionTriggerAnimation'] !=
                        null) {
                      await animationsMap['containserOnActionTriggerAnimation']!
                          .controller
                          .forward(from: 0.0);
                    }
                    Navigator.pop(context, () {
                      if (publicUrl != null && publicUrl != '') {
                        localFile = _previewFile!.path;

                        return '${localFile}~${publicUrl}';
                      } else {
                        return null;
                      }
                    }());
                  },
                  text: languagefuncation(
                          'process_image',
                          FFLocalizations.of(context).languageCode,
                          FFAppState().translationsCSV) ??
                      "Process Image",
                  options: FFButtonOptions(
                    height: 58,
                    width: double.infinity,
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).info,
                          letterSpacing: 0.0,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                    elevation: 0,
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  icon: FaIcon(
                    FFIcons.kiI21,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        ].divide(SizedBox(width: 19)),
      ),
    );
  }

  Widget customImagePicker() {
    return Padding(
      padding: const EdgeInsets.only(left: 28, right: 28, top: 38, bottom: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await Future.wait([
                      Future(() async {
                        HapticFeedback.heavyImpact();
                        safeSetState(() {
                          isCamarShow = false;
                        });
                        final capturedFile =
                            await pickImageFromGallery(context);
                        if (capturedFile != null) {
                          setState(() {
                            _previewFile =
                                capturedFile; // show local image immediately
                          });
                        } else {
                          openCamera();
                        }
                      }),
                    ]);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: SvgPicture.asset(
                          'assets/images/gallery.svg',
                          width: 48,
                          height: 48,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Text(
                          languagefuncation(
                                  'gallery',
                                  FFLocalizations.of(context).languageCode,
                                  FFAppState().translationsCSV) ??
                              'Gallery',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 13,
                                    letterSpacing: 0.0,
                                    color: Color(0xCD0F0F0F),
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ].divide(SizedBox(height: 4)),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: openCamera,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.18),
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                      shape: BoxShape.circle,
                      color: FlutterFlowTheme.of(context).primary,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 3,
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                        child: Container(
                          height: 44,
                          width: 44,
                          margin: EdgeInsets.all(1.5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 66,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            height: 52,
            width: 342,
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        HapticFeedback.heavyImpact();

                        await Future.wait([
                          Future(() => setState(() => currentType = 1)),
                          Future(() => context.safePop()),
                        ]);

                        context.pushNamed(
                          TextMealWidget.routeName,
                        );
                      },
                      child: Container(
                        width: 100.0,
                        decoration: BoxDecoration(
                          color: valueOrDefault<Color>(
                            currentType == 1
                                ? FlutterFlowTheme.of(context).primary
                                : Color(0xFFF5F5F5),
                            FlutterFlowTheme.of(context).secondaryBackground,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: valueOrDefault<Color>(
                                currentType == 1
                                    ? Color(0x191C1C1C)
                                    : Colors.transparent,
                                Colors.transparent,
                              ),
                              offset: Offset(
                                -2.0,
                                2.0,
                              ),
                              spreadRadius: 0.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            languagefuncation(
                                    'text',
                                    FFLocalizations.of(context).languageCode,
                                    FFAppState().translationsCSV) ??
                                'Text',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: valueOrDefault<Color>(
                                    currentType == 1
                                        ? FlutterFlowTheme.of(context).info
                                        : Color(0xFF737373),
                                    FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  fontSize: 14,
                                  letterSpacing: 0.65,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        HapticFeedback.heavyImpact();
                        setState(() {
                          currentType = 0;
                        });
                      },
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: valueOrDefault<Color>(
                            currentType == 0
                                ? FlutterFlowTheme.of(context).primary
                                : Color(0xFFF5F5F5),
                            FlutterFlowTheme.of(context).secondaryBackground,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: valueOrDefault<Color>(
                                currentType == 0
                                    ? Color(0x191C1C1C)
                                    : Colors.transparent,
                                Colors.transparent,
                              ),
                              offset: Offset(
                                -2.0,
                                2.0,
                              ),
                              spreadRadius: 0.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            languagefuncation(
                                    'camera',
                                    FFLocalizations.of(context).languageCode,
                                    FFAppState().translationsCSV) ??
                                'CAMERA',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: valueOrDefault<Color>(
                                    currentType == 0
                                        ? FlutterFlowTheme.of(context).info
                                        : Color(0xFF737373),
                                    FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  fontSize: 14,
                                  letterSpacing: 0.65,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        HapticFeedback.heavyImpact();

                        await Future.wait([
                          Future(() => setState(() => currentType = 2)),
                          Future(() => context.safePop()),
                        ]);

                        context.pushNamed(
                          RecentMealWidget.routeName,
                        );
                      },
                      child: Container(
                        width: 100.0,
                        decoration: BoxDecoration(
                          color: valueOrDefault<Color>(
                            currentType == 2
                                ? FlutterFlowTheme.of(context).primary
                                : Color(0xFFF5F5F5),
                            FlutterFlowTheme.of(context).secondaryBackground,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: valueOrDefault<Color>(
                                currentType == 2
                                    ? Color(0x191C1C1C)
                                    : Colors.transparent,
                                Colors.transparent,
                              ),
                              offset: Offset(
                                -2.0,
                                2.0,
                              ),
                              spreadRadius: 0.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            languagefuncation(
                                    'recent',
                                    FFLocalizations.of(context).languageCode,
                                    FFAppState().translationsCSV) ??
                                'RECENT',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: valueOrDefault<Color>(
                                    currentType == 2
                                        ? FlutterFlowTheme.of(context).info
                                        : Color(0xFF737373),
                                    FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  fontSize: 14,
                                  letterSpacing: 0.65,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation']!),
    );
  }

  Widget customCamara() {
    {
      final previewWidth = double.infinity;
      final previewHeight = double.infinity;
      return _controller == null
          ? Center(
              child: CircularProgressIndicator(
              color: FlutterFlowTheme.of(context).primaryText,
            ))
          : FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    width: previewWidth,
                    height: previewHeight,
                    child: ClipRRect(
                      child: CameraPreview(_controller!),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  );
                }
              },
            ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation']!);
    }
  }
}
