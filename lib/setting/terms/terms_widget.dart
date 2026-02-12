import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'terms_model.dart';
export 'terms_model.dart';

class TermsWidget extends StatefulWidget {
  const TermsWidget({super.key});

  static String routeName = 'Terms';
  static String routePath = '/terms';

  @override
  State<TermsWidget> createState() => _TermsWidgetState();
}

class _TermsWidgetState extends State<TermsWidget>
    with TickerProviderStateMixin {
  late TermsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TermsModel());

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
            'Term of User',
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
                '<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n  <meta charset=\"UTF-8\" />\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n  <style>\n    body {\n      margin: 0;\n      padding: 0;\n      font-family: -apple-system, BlinkMacSystemFont, \"Segoe UI\", Roboto, Helvetica, Arial, sans-serif;\n      background-color: #f4f6fa;\n      color: #222;\n      line-height: 1.6;\n    }\n\n    .container {\n      max-width: 720px;\n      margin: 0 auto;\n     padding: 0px 16px 32px;\n    }\n\n    .header {\n      text-align: center;\n      font-size: 16px;\n      font-weight: 600;\n      padding: 12px 0;\n      border-bottom: 1px solid #eee;\n      margin-bottom: 12px;\n    }\n\n    h2 {\n      font-size: 14px;\n      font-weight: 600;\n      margin-top: 15px;\n      margin-bottom: 10px;\n    }\n\n    p {\n      font-size: 12px;\n      margin-bottom: 12px;\n    }\n\n    ul {\n      padding-left: 18px;\n      margin-bottom: 16px;\n    }\n\n    li {\n      font-size: 12px;\n      margin-bottom: 8px;\n    }\n\n    .contact {\n      margin-top: 15px;\n      font-size: 12px;\n      font-weight: 500;\n    }\n  </style>\n</head>\n<body>\n\n  <div class=\"container\">\n\n    <p>\n      Thank you for using our apps. We’re continuously improving and producing more innovative products to bring the best value to you.\n      These Terms of Service apply to all products of Bega Team. Please read them carefully before using our apps.\n    </p>\n\n    <p>\n      By using Bega Team products, you agree to be bound by these Terms. If you do not agree, please do not use our apps.\n      If you are using our products on behalf of an organization, you confirm that you have the authority to bind that organization.\n      In such cases, “you” and “your” refer to that organization.\n    </p>\n\n    <h2>Auto Renewing Subscriptions</h2>\n    <ul>\n      <li>Subscribed users have unlimited access to translation services including speech-to-text, translation, and text-to-speech.</li>\n      <li>Unsubscribed users can access these services with limited daily quotas.</li>\n      <li>Payment will be charged to the iTunes Account upon confirmation of purchase.</li>\n      <li>Subscriptions automatically renew unless auto-renew is turned off at least 24 hours before the end of the current period.</li>\n      <li>Accounts are charged for renewal within 24 hours prior to the end of the current period.</li>\n      <li>Subscriptions can be managed and auto-renewal disabled via Account Settings after purchase.</li>\n      <li>Any unused portion of a free trial will be forfeited upon subscription purchase.</li>\n    </ul>\n\n    <h2>General Prohibitions</h2>\n    <p>You agree not to do or attempt to do any of the following:</p>\n    <ul>\n      <li>Probe, scan, or test the vulnerability of any Bega Team system or network.</li>\n      <li>Access or use non-public areas of Bega Team systems.</li>\n      <li>Decompile, reverse engineer, or disassemble any software used by Bega Team.</li>\n      <li>Interfere with user access through viruses, spamming, or network abuse.</li>\n      <li>Access or extract data using unauthorized automated tools.</li>\n      <li>Plant malware or use the service to distribute malware.</li>\n      <li>Send unsolicited promotions, spam, or deceptive communications.</li>\n      <li>Impersonate others or misrepresent affiliations.</li>\n      <li>Violate privacy, laws, or regulations.</li>\n      <li>Encourage or enable others to violate these terms.</li>\n    </ul>\n\n    <p>\n      We reserve the right to monitor usage, remove content, investigate violations, and cooperate with law enforcement\n      when required by law.\n    </p>\n\n    <h2>DMCA / Copyright Policy</h2>\n    <p>\n      We respect copyright laws and expect users to do the same. Accounts that repeatedly infringe copyrights may be terminated.\n    </p>\n\n    <h2>AI-Generated Image Features</h2>\n\n    <p><strong>1. User Responsibility</strong></p>\n    <p>\n      You are solely responsible for the prompts and content you generate. You agree not to create content that infringes\n      intellectual property, imitates protected works, or bypasses restrictions.\n    </p>\n\n    <p><strong>2. Third-Party AI APIs</strong></p>\n    <p>\n      Image generation is powered by third-party AI APIs. We do not control the underlying models.\n    </p>\n\n    <p><strong>3. Disclaimer of Affiliation</strong></p>\n    <p>\n      We are not affiliated with or endorsed by any artist, brand, or intellectual property referenced through stylistic prompts.\n    </p>\n\n    <p><strong>4. Intellectual Property Rights</strong></p>\n    <p>\n      You retain rights to your prompts. Generated images are licensed for personal, non-commercial use unless otherwise stated.\n    </p>\n\n    <p><strong>5. Prohibited Uses</strong></p>\n    <ul>\n      <li>Commercial redistribution without rights</li>\n      <li>Impersonation, defamation, or misleading use</li>\n      <li>Training other AI models</li>\n      <li>Violating laws or platform policies</li>\n      <li>Bypassing geographic or technical restrictions</li>\n    </ul>\n\n    <p><strong>6. Limitation of Liability</strong></p>\n    <p>\n      We are not liable for legal consequences arising from AI-generated content.\n    </p>\n\n    <p><strong>7. Enforcement</strong></p>\n    <p>\n      We may suspend or terminate AI features if violations are detected or reported.\n    </p>\n\n    <p><strong>8. Modification of Terms</strong></p>\n    <p>\n      These terms may be updated periodically. Continued use constitutes acceptance.\n    </p>\n\n    <div class=\"contact\">\n      Contact Us: support@gmail.com\n    </div>\n\n  </div>\n\n</body>\n</html>\n',
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
