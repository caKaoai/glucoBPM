import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'test_model.dart';
export 'test_model.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  late TestModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TestModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            final selectedMedia = await selectMediaWithSourceBottomSheet(
              context: context,
              storageFolderPath: 'food_img',
              maxWidth: 200.00,
              maxHeight: 200.00,
              allowPhoto: true,
            );
            if (selectedMedia != null &&
                selectedMedia
                    .every((m) => validateFileFormat(m.storagePath, context))) {
              safeSetState(() => _model.isDataUploading_uploadDataHjn = true);
              var selectedUploadedFiles = <FFUploadedFile>[];

              var downloadUrls = <String>[];
              try {
                selectedUploadedFiles = selectedMedia
                    .map((m) => FFUploadedFile(
                          name: m.storagePath.split('/').last,
                          bytes: m.bytes,
                          height: m.dimensions?.height,
                          width: m.dimensions?.width,
                          blurHash: m.blurHash,
                          originalFilename: m.originalFilename,
                        ))
                    .toList();

                downloadUrls = await uploadSupabaseStorageFiles(
                  bucketName: 'user',
                  selectedFiles: selectedMedia,
                );
              } finally {
                _model.isDataUploading_uploadDataHjn = false;
              }
              if (selectedUploadedFiles.length == selectedMedia.length &&
                  downloadUrls.length == selectedMedia.length) {
                safeSetState(() {
                  _model.uploadedLocalFile_uploadDataHjn =
                      selectedUploadedFiles.first;
                  _model.uploadedFileUrl_uploadDataHjn = downloadUrls.first;
                });
              } else {
                safeSetState(() {});
                return;
              }
            }
          },
          child: Lottie.asset(
            'assets/jsons/scanning.json',
            width: 200.0,
            height: 200.0,
            fit: BoxFit.contain,
            animate: true,
          ),
        ),
      ],
    );
  }
}
