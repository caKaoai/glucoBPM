import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'privacy_policy_model.dart';
export 'privacy_policy_model.dart';

class PrivacyPolicyWidget extends StatefulWidget {
  const PrivacyPolicyWidget({super.key});

  static String routeName = 'PrivacyPolicy';
  static String routePath = '/privacyPolicy';

  @override
  State<PrivacyPolicyWidget> createState() => _PrivacyPolicyWidgetState();
}

class _PrivacyPolicyWidgetState extends State<PrivacyPolicyWidget>
    with TickerProviderStateMixin {
  late PrivacyPolicyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrivacyPolicyModel());

    animationsMap.addAll({
      'webViewOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeOut,
            delay: 120.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.chevron_left_sharp,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Privacy Policy',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).headlineMediumIsCustom,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: FlutterFlowWebView(
            content:
                '<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n  <meta charset=\"UTF-8\" />\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\n  <title>Privacy Policy</title>\n\n  <style>\n    body {\n      margin: 0;\n      padding: 0;\n      font-family: -apple-system, BlinkMacSystemFont, \"Segoe UI\",\n                   Roboto, Helvetica, Arial, sans-serif;\n      background-color: #f4f6fa;\n      color: #222;\n    }\n\n    .container {\n      max-width: 720px;\n      margin: 0 auto;\n      padding: 0px 16px 32px;\n    }\n\n    /* Top title like app header */\n    .page-title {\n      text-align: center;\n      font-size: 16px;\n      font-weight: 600;\n      padding: 12px 0;\n      border-bottom: 1px solid #eaeaea;\n      margin-bottom: 20px;\n    }\n\n    /* Section headers (Roman numerals) */\n    h2 {\n      font-size: 14px;\n      font-weight: 600;\n      margin: 22px 0 8px;\n    }\n\n    /* Sub-section headers (2.1, 2.2 etc.) */\n    h3 {\n      font-size: 12.5px;\n      font-weight: 600;\n      margin: 16px 0 6px;\n    }\n\n    p {\n      font-size: 12px;\n      line-height: 1.5;\n      margin: 0 0 12px;\n    }\n\n    ul {\n      padding-left: 18px;\n      margin: 6px 0 14px;\n    }\n\n    li {\n      font-size: 12px;\n      line-height: 1.5;\n      margin-bottom: 6px;\n    }\n\n    .contact {\n      margin-top: 24px;\n      font-size: 12px;\n      font-weight: 500;\n    }\n  </style>\n</head>\n\n<body>\n  <div class=\"container\">\n\n    <h2>I. GENERAL PROVISIONS</h2>\n    <p>\n      We kindly request that you thoroughly read this privacy statement.\n      It provides important information about how your personal data may be handled.\n      When you use the App, you confirm that you have read, understood, and agreed\n      to these terms. By accessing or using the App, you consent to the processing\n      of your personal data in accordance with this Privacy Policy.\n    </p>\n\n    <p>\n      At Begamob Global (referred to as “our company”, “we”, or “us”), we prioritize\n      your privacy. This Privacy Policy outlines our commitment to safeguarding your\n      data and describes the types of information we may collect when you use our\n      mobile applications (referred to as the “App”).\n    </p>\n\n    <h2>II. INFORMATION COLLECTION</h2>\n\n    <h3>2.1 Data You Provide</h3>\n    <p>\n      When you interact with our App, we may request and collect certain personal\n      information. This information is necessary to properly provide our services.\n    </p>\n\n    <ul>\n      <li>\n        <strong>Personal Details:</strong> Voluntarily provided data for tracking,\n        storing, and record management.\n      </li>\n      <li>\n        <strong>Registration / Account Details:</strong> Email address, Facebook ID,\n        or Google ID depending on the App configuration.\n      </li>\n      <li>\n        <strong>Content Details:</strong> Photos, images, videos, audio files,\n        documents, and other uploaded content.\n      </li>\n    </ul>\n\n    <h3>2.2 Automatically Processed Data</h3>\n    <p>\n      While using the App, certain information related to your device and usage\n      patterns may be automatically processed. This data is generally non-personal\n      and is used to improve app performance.\n    </p>\n\n    <ul>\n      <li>Advertising ID, device brand/model, browser type and version</li>\n      <li>IP address, MAC address, IMEI, OS version, and locale data</li>\n      <li>Cookies and similar tracking technologies</li>\n    </ul>\n\n    <h2>III. DISCLOSURE OF YOUR INFORMATION</h2>\n\n    <h3>3.1 Third-Party Channels</h3>\n    <p>\n      We do not sell or lease your personal data. However, limited information may\n      be shared with trusted third parties such as Google, Facebook, and Apple for\n      analytics and advertising purposes.\n    </p>\n\n    <h3>3.2 International Data Transfer</h3>\n    <p>\n      Due to our global operations, your data may be transferred to and processed\n      in other countries. We ensure appropriate security measures and compliance\n      with applicable data protection laws.\n    </p>\n\n    <h2>IV. EXERCISING YOUR RIGHTS</h2>\n\n    <h3>4.1 Data Processing Rights</h3>\n    <ul>\n      <li>Request access to or copies of your personal data</li>\n      <li>Request corrections or updates to inaccurate information</li>\n      <li>Request restriction of data processing in certain cases</li>\n      <li>Request deletion of your personal data</li>\n    </ul>\n\n    <h3>4.2 Security</h3>\n    <p>\n      We apply industry-standard security measures to protect your data.\n      However, no electronic transmission or storage method is completely secure.\n    </p>\n\n    <h3>4.3 Information Relating to Children</h3>\n    <p>\n      Our App is not intended for individuals under the age of 18.\n      We do not knowingly collect personal data from children.\n    </p>\n\n    <h2>V. PRIVACY POLICY MODIFICATIONS</h2>\n    <p>\n      We reserve the right to modify this Privacy Policy at any time.\n      Continued use of the App constitutes acceptance of any updates.\n    </p>\n\n    <h2>VI. HOW TO CONTACT US</h2>\n    <p class=\"contact\">\n      If you have any questions, please contact us at:<br/>\n      <strong>feedback@gmail.com</strong>\n    </p>\n\n  </div>\n</body>\n</html>\n',
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: MediaQuery.sizeOf(context).height * 1.0,
            verticalScroll: true,
            horizontalScroll: false,
            html: true,
          ).animateOnPageLoad(animationsMap['webViewOnPageLoadAnimation']!),
        ),
      ),
    );
  }
}
