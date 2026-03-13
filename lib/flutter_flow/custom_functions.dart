import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

String? languagefuncation(
  String? text,
  String? languageCode,
  dynamic translationsCSV,
) {
  if (languageCode == null || text == null || text.isEmpty) return text;

  // ============================================
  // NORMALIZE LANGUAGE CODE
  // ============================================
  // Convert "zh-Hans" -> "zh_Hans"
  // Convert "zh-Hant" -> "zh_Hant"
  // Keep other formats as-is but lowercase
  String cleanedLang = languageCode.trim().toLowerCase();

  // Handle Chinese variants specifically
  if (cleanedLang.contains('-')) {
    // Replace hyphen with underscore for lookup
    cleanedLang = cleanedLang.replaceAll('-', '_');
  }

  final cleanedKey = text.trim();

  // ============================================
  // STEP 1: Try to get translation from CSV (Supabase/Cache)
  // ============================================
  try {
    if (translationsCSV != null && translationsCSV.isNotEmpty) {
      // Parse JSON from AppState
      final Map<String, dynamic> translations = jsonDecode(translationsCSV);

      // Try exact match first
      if (translations.containsKey(cleanedLang)) {
        final Map<String, dynamic> langMap = translations[cleanedLang];

        if (langMap.containsKey(cleanedKey)) {
          final value = langMap[cleanedKey];
          if (value != null && value.toString().isNotEmpty) {
            // print(
            //     "✅ CSV translation found: [$cleanedLang][$cleanedKey] = $value");
            return value.toString();
          }
        }
      }

      // Try alternative formats for Chinese
      if (cleanedLang.startsWith('zh')) {
        final alternatives = [
          cleanedLang, // zh_hans
          cleanedLang.toLowerCase(), // zh_hans (already lowercase)
          'zh_Hans', // Original case
          'zh-Hans', // With hyphen
          'zh', // Base language
        ];

        for (final altLang in alternatives) {
          if (translations.containsKey(altLang)) {
            final Map<String, dynamic> langMap = translations[altLang];
            if (langMap.containsKey(cleanedKey)) {
              final value = langMap[cleanedKey];
              if (value != null && value.toString().isNotEmpty) {
                // print("✅ CSV translation found (alternative): [$altLang][$cleanedKey] = $value");
                return value.toString();
              }
            }
          }
        }
      }

      // Try English fallback from CSV
      if (cleanedLang != 'en' && translations.containsKey('en')) {
        final Map<String, dynamic> enMap = translations['en'];
        if (enMap.containsKey(cleanedKey)) {
          final enValue = enMap[cleanedKey];
          if (enValue != null && enValue.toString().isNotEmpty) {
            // print("✅ CSV English fallback: [$cleanedKey] = $enValue");
            return enValue.toString();
          }
        }
      }
    }
  } catch (e) {
    print("⚠️ CSV translation lookup failed: $e");
    // Continue to hardcoded fallback
  }

  // ============================================
  // STEP 2: Fallback to hardcoded translations
  // ============================================
  // print("🔄 Using hardcoded translations for: $cleanedKey");

  final translations = {
    "smart_diabetes": {
      "en": "Smart Diabetes",
      "vi": "Tiểu đường thông minh",
      "ja": "スマート糖尿病",
      "ar": "السكري الذكي",
      "hi": "स्मार्ट मधुमेह",
      "th": "เบาหวานอัจฉริยะ",
      "es": "Diabetes inteligente",
      "ko": "스마트 당뇨",
      "zh_Hans": "智能糖尿病",
      "fr": "Diabète intelligent",
      "tr": "Akıllı Diyabet",
      "ru": "Умный диабет",
      "de": "Intelligenter Diabetes",
      "pt": "Diabetes inteligente",
      "it": "Diabete intelligente",
      "id": "Diabetes pintar"
    },
    "management": {
      "en": "Management",
      "vi": "Quản lý",
      "ja": "管理",
      "ar": "الإدارة",
      "hi": "प्रबंधन",
      "th": "การจัดการ",
      "es": "Gestión",
      "ko": "관리",
      "zh_Hans": "管理",
      "fr": "Gestion",
      "tr": "Yönetim",
      "ru": "Управление",
      "de": "Management",
      "pt": "Gestão",
      "it": "Gestione",
      "id": "Manajemen"
    },
    "take_control_health_tagline": {
      "en":
          "Take control of your health with personalized insights and daily tracking.",
      "vi":
          "Kiểm soát sức khỏe của bạn với các thông tin cá nhân hóa và theo dõi hằng ngày.",
      "ja": "パーソナライズされたインサイトと毎日の記録で、健康を自分の手に取り戻しましょう。",
      "ar": "تحكّم بصحتك من خلال رؤى مخصّصة وتتبع يومي.",
      "hi":
          "व्यक्तिगत इनसाइट्स और दैनिक ट्रैकिंग के साथ अपनी सेहत पर नियंत्रण रखें।",
      "th": "ควบคุมสุขภาพของคุณด้วยข้อมูลเชิงลึกเฉพาะบุคคลและการติดตามประจำวัน",
      "es":
          "Toma el control de tu salud con información personalizada y seguimiento diario.",
      "ko": "맞춤형 인사이트와 일일 추적으로 건강을 스스로 관리하세요.",
      "zh_Hans": "通过个性化洞察和每日追踪来掌控您的健康。",
      "fr":
          "Prenez le contrôle de votre santé grâce à des informations personnalisées et un suivi quotidien.",
      "tr":
          "Kişiselleştirilmiş içgörüler ve günlük takip ile sağlığınızı kontrol altına alın.",
      "ru":
          "Возьмите контроль над своим здоровьем с персонализированными рекомендациями и ежедневным отслеживанием.",
      "de":
          "Übernehmen Sie die Kontrolle über Ihre Gesundheit mit personalisierten Einblicken und täglichem Tracking.",
      "pt":
          "Assuma o controle da sua saúde com insights personalizados e acompanhamento diário.",
      "it":
          "Riprendi il controllo della tua salute con approfondimenti personalizzati e monitoraggio quotidiano.",
      "id":
          "Kendalikan kesehatan Anda dengan wawasan personal dan pelacakan harian."
    },
    "ai_food_analysis": {
      "en": "AI Food Analysis",
      "vi": "Phân tích thực phẩm bằng AI",
      "ja": "AI食品分析",
      "ar": "تحليل الطعام بالذكاء الاصطناعي",
      "hi": "एआई खाद्य विश्लेषण",
      "th": "การวิเคราะห์อาหารด้วย AI",
      "es": "Análisis de alimentos con IA",
      "ko": "AI 음식 분석",
      "zh_Hans": "AI食物分析",
      "fr": "Analyse alimentaire par IA",
      "tr": "Yapay Zekâ ile Gıda Analizi",
      "ru": "Анализ пищи с помощью ИИ",
      "de": "KI-Lebensmittelanalyse",
      "pt": "Análise de alimentos com IA",
      "it": "Analisi degli alimenti con IA",
      "id": "Analisis makanan berbasis AI"
    },
    "track_macros_get_diabetic_warnings": {
      "en":
          "Track macros and get diabetic warnings instantly with just a photo of your plate.",
      "vi":
          "Theo dõi macro và nhận cảnh báo tiểu đường ngay lập tức chỉ với một ảnh chụp món ăn của bạn.",
      "ja": "あなたの皿を撮るだけで、マクロを追跡し、糖尿病の警告を即座に受け取れます。",
      "ar":
          "تتبع المغذيات واحصل على تحذيرات مرض السكري فورًا بمجرد صورة لطبقك.",
      "hi":
          "सिर्फ अपनी प्लेट की एक फोटो से मैक्रोज़ ट्रैक करें और तुरंत डायबिटीज़ चेतावनियाँ प्राप्त करें।",
      "th":
          "ติดตามสารอาหารและรับคำเตือนเบาหวานได้ทันที เพียงถ่ายรูปจานอาหารของคุณ",
      "es":
          "Haz un seguimiento de los macronutrientes y recibe advertencias de diabetes al instante con solo una foto de tu plato.",
      "ko": "접시 사진만으로 매크로를 추적하고 즉시 당뇨 경고를 받을 수 있습니다.",
      "zh_Hans": "只需拍下餐盘照片，即可追踪营养素并即时获得糖尿病预警。",
      "fr":
          "Suivez vos macronutriments et recevez des alertes diabétiques instantanément avec une simple photo de votre assiette.",
      "tr":
          "Sadece tabağınızın fotoğrafını çekerek makroları takip edin ve anında diyabet uyarıları alın.",
      "ru":
          "Отслеживайте макросы и мгновенно получайте предупреждения о диабете — только по фото вашей тарелки.",
      "de":
          "Verfolge Makronährstoffe und erhalte sofort Diabeteswarnungen – nur mit einem Foto deines Tellers.",
      "pt":
          "Acompanhe macros e receba alertas de diabetes instantaneamente com apenas uma foto do seu prato.",
      "it":
          "Monitora i macronutrienti e ricevi avvisi sul diabete all’istante con una semplice foto del tuo piatto.",
      "id":
          "Lacak makro dan dapatkan peringatan diabetes seketika hanya dengan foto piring Anda."
    },
    "get_started": {
      "en": "Get Started",
      "vi": "Bắt đầu",
      "ja": "開始する",
      "ar": "ابدأ",
      "hi": "शुरू करें",
      "th": "เริ่มต้น",
      "es": "Comenzar",
      "ko": "시작하기",
      "zh_Hans": "开始使用",
      "fr": "Commencer",
      "tr": "Başlayın",
      "ru": "Начать",
      "de": "Loslegen",
      "pt": "Começar",
      "it": "Inizia",
      "id": "Mulai"
    },
    "next": {
      "en": "Next",
      "vi": "Tiếp theo",
      "ja": "次へ",
      "ar": "التالي",
      "hi": "आगे",
      "th": "ถัดไป",
      "es": "Siguiente",
      "ko": "다음",
      "zh_Hans": "下一步",
      "fr": "Suivant",
      "tr": "Sonraki",
      "ru": "Далее",
      "de": "Weiter",
      "pt": "Próximo",
      "it": "Avanti",
      "id": "Berikutnya"
    },
    "vital_tracking": {
      "en": "Vital Tracking",
      "vi": "Theo dõi chỉ số sức khỏe",
      "ja": "バイタル追跡",
      "ar": "تتبع المؤشرات الحيوية",
      "hi": "वाइटल ट्रैकिंग",
      "th": "การติดตามสัญญาณชีพ",
      "es": "Seguimiento vital",
      "ko": "바이탈 추적",
      "zh_Hans": "生命体征追踪",
      "fr": "Suivi des signes vitaux",
      "tr": "Hayati Değer Takibi",
      "ru": "Отслеживание жизненных показателей",
      "de": "Vitalwert-Tracking",
      "pt": "Rastreamento vital",
      "it": "Monitoraggio dei parametri vitali",
      "id": "Pelacakan tanda vital"
    },
    "monitor_glucose_heart_activity": {
      "en":
          "Monitor your glucose, heart rate, and activity levels seamlessly to stay on top of your health.",
      "vi":
          "Theo dõi đường huyết, nhịp tim và mức độ hoạt động của bạn một cách liền mạch để luôn kiểm soát sức khỏe.",
      "ja": "血糖値、心拍数、活動レベルをシームレスに監視し、健康状態を常に把握しましょう。",
      "ar":
          "راقب مستوى الجلوكوز ومعدل ضربات القلب ومستويات النشاط بسهولة للبقاء على رأس صحتك.",
      "hi":
          "अपनी रक्त शर्करा, हृदय गति और गतिविधि स्तर को सहज रूप से मॉनिटर करें ताकि आप अपनी सेहत पर नियंत्रण बनाए रख सकें।",
      "th":
          "ตรวจวัดระดับน้ำตาลในเลือด อัตราการเต้นของหัวใจ และระดับกิจกรรมของคุณอย่างราบรื่นเพื่อดูแลสุขภาพได้อย่างมีประสิทธิภาพ",
      "es":
          "Supervisa tus niveles de glucosa, frecuencia cardíaca y actividad sin esfuerzo para mantener el control de tu salud.",
      "ko": "혈당, 심박수, 활동 수준을 매끄럽게 모니터링하여 건강을 효과적으로 관리하세요.",
      "zh_Hans": "无缝监测您的血糖、心率和活动水平，让您随时掌握健康状况。",
      "fr":
          "Surveillez sans effort votre glycémie, votre rythme cardiaque et vos niveaux d'activité pour garder le contrôle de votre santé.",
      "tr":
          "Sağlığınızı kontrol altında tutmak için glikoz, kalp atış hızı ve aktivite seviyelerinizi sorunsuz bir şekilde izleyin.",
      "ru":
          "Беспрепятственно отслеживайте уровень глюкозы, частоту сердечных сокращений и уровень активности, чтобы контролировать своё здоровье.",
      "de":
          "Überwachen Sie nahtlos Ihren Blutzucker, Ihre Herzfrequenz und Ihr Aktivitätsniveau, um Ihre Gesundheit im Blick zu behalten.",
      "pt":
          "Monitore seus níveis de glicose, frequência cardíaca e atividade sem esforço para manter sua saúde em dia.",
      "it":
          "Monitora senza sforzo i tuoi livelli di glicemia, frequenza cardiaca e attività per mantenere sotto controllo la tua salute.",
      "id":
          "Pantau kadar glukosa, detak jantung, dan tingkat aktivitas Anda dengan mudah untuk tetap menjaga kesehatan Anda."
    },
    "reach_health_goals": {
      "en": "Reach Health Goals",
      "vi": "Đạt được mục tiêu sức khỏe",
      "ja": "健康目標を達成する",
      "ar": "تحقيق أهداف الصحة",
      "hi": "स्वास्थ्य लक्ष्यों को प्राप्त करें",
      "th": "บรรลุเป้าหมายด้านสุขภาพ",
      "es": "Alcanza tus objetivos de salud",
      "ko": "건강 목표 달성",
      "zh_Hans": "达成健康目标",
      "fr": "Atteindre vos objectifs de santé",
      "tr": "Sağlık hedeflerine ulaş",
      "ru": "Достигайте целей по здоровью",
      "de": "Gesundheitsziele erreichen",
      "pt": "Alcançar metas de saúde",
      "it": "Raggiungi i tuoi obiettivi di salute",
      "id": "Mencapai tujuan kesehatan"
    },
    "track_progress_stay_motivated_diabetes": {
      "en":
          "Track your progress and stay motivated on your journey to better diabetes management.",
      "vi":
          "Theo dõi tiến trình của bạn và giữ vững động lực trên hành trình quản lý bệnh tiểu đường tốt hơn.",
      "ja": "進捗を追跡し、より良い糖尿病管理への道のりでモチベーションを保ちましょう。",
      "ar": "تتبع تقدمك وابقَ متحمسًا في رحلتك نحو إدارة أفضل لمرض السكري.",
      "hi":
          "अपनी प्रगति को ट्रैक करें और बेहतर मधुमेह प्रबंधन की यात्रा में प्रेरित बने रहें।",
      "th":
          "ติดตามความก้าวหน้าของคุณและรักษาแรงจูงใจไว้ระหว่างเส้นทางสู่การจัดการโรคเบาหวานที่ดีขึ้น",
      "es":
          "Sigue tu progreso y mantente motivado en tu camino hacia un mejor control de la diabetes.",
      "ko": "진행 상황을 추적하고 더 나은 당뇨 관리 여정에서 동기부여를 유지하세요.",
      "zh_Hans": "跟踪您的进展，并在迈向更好糖尿病管理的旅程中保持动力。",
      "fr":
          "Suivez vos progrès et restez motivé dans votre parcours vers une meilleure gestion du diabète.",
      "tr":
          "İlerlemenizi takip edin ve daha iyi diyabet yönetimi yolculuğunuzda motive kalın.",
      "ru":
          "Отслеживайте свой прогресс и оставайтесь мотивированными на пути к лучшему контролю диабета.",
      "de":
          "Verfolge deinen Fortschritt und bleibe motiviert auf deinem Weg zu einem besseren Diabetesmanagement.",
      "pt":
          "Acompanhe seu progresso e mantenha-se motivado na sua jornada para um melhor controle do diabetes.",
      "it":
          "Monitora i tuoi progressi e rimani motivato nel tuo percorso verso una migliore gestione del diabete.",
      "id":
          "Lacak perkembangan Anda dan tetap termotivasi dalam perjalanan menuju manajemen diabetes yang lebih baik."
    },
    "diabetics_nutrition": {
      "en": "Diabetics Nutrition",
      "vi": "Dinh dưỡng cho người tiểu đường",
      "ja": "糖尿病患者の栄養管理",
      "ar": "تغذية مرضى السكري",
      "hi": "मधुमेह रोगियों के लिए पोषण",
      "th": "โภชนาการสำหรับผู้ป่วยเบาหวาน",
      "es": "Nutrición para diabéticos",
      "ko": "당뇨 환자를 위한 영양",
      "zh_Hans": "糖尿病患者营养",
      "fr": "Nutrition pour les diabétiques",
      "tr": "Diyabetikler için beslenme",
      "ru": "Питание для диабетиков",
      "de": "Ernährung für Diabetiker",
      "pt": "Nutrição para diabéticos",
      "it": "Nutrizione per diabetici",
      "id": "Nutrisi untuk penderita diabetes"
    },
    "instant_sugar_warning_description": {
      "en":
          "Get instant sugar warnings and personalized suggestions to keep glucose stable.",
      "vi":
          "Nhận cảnh báo đường huyết tức thì và gợi ý cá nhân hóa để giữ mức đường ổn định.",
      "ja": "即時の血糖警告と、血糖値を安定させるための個別提案を受け取りましょう。",
      "ar":
          "احصل على تنبيهات فورية لمستوى السكر واقتراحات مخصصة للحفاظ على استقرار الجلوكوز.",
      "hi":
          "तुरंत शुगर चेतावनियाँ और ग्लूकोज़ स्थिर रखने के लिए व्यक्तिगत सुझाव प्राप्त करें।",
      "th":
          "รับคำเตือนระดับน้ำตาลทันทีและคำแนะนำส่วนบุคคลเพื่อคงระดับกลูโคสให้คงที่",
      "es":
          "Recibe alertas instantáneas de azúcar y sugerencias personalizadas para mantener la glucosa estable.",
      "ko": "즉각적인 혈당 경고와 개인 맞춤형 제안을 통해 혈당을 안정적으로 유지하세요.",
      "zh_Hans": "获取即时血糖警报和个性化建议，以保持血糖稳定。",
      "fr":
          "Recevez des alertes de glycémie instantanées et des recommandations personnalisées pour maintenir une stabilité du glucose.",
      "tr":
          "Glukozu dengede tutmak için anında şeker uyarıları ve kişiselleştirilmiş öneriler alın.",
      "ru":
          "Получайте мгновенные предупреждения о сахаре и персональные рекомендации для поддержания стабильного уровня глюкозы.",
      "de":
          "Erhalten Sie sofortige Zuckerwarnungen und personalisierte Vorschläge, um den Glukosespiegel stabil zu halten.",
      "pt":
          "Receba alertas instantâneos de açúcar e sugestões personalizadas para manter a glicose estável.",
      "it":
          "Ricevi avvisi immediati sul livello di zucchero e suggerimenti personalizzati per mantenere stabile la glicemia.",
      "id":
          "Dapatkan peringatan gula instan dan saran personal untuk menjaga kadar glukosa tetap stabil."
    },
    "start_onboarding": {
      "en": "Start Onboarding",
      "vi": "Bắt đầu giới thiệu",
      "ja": "オンボーディングを開始",
      "ar": "ابدأ الإعداد",
      "hi": "ऑनबोर्डिंग शुरू करें",
      "th": "เริ่มการแนะนำระบบ",
      "es": "Iniciar incorporación",
      "ko": "온보딩 시작",
      "zh_Hans": "开始注册流程",
      "fr": "Commencer l’intégration",
      "tr": "Onboarding'i Başlat",
      "ru": "Начать онбординг",
      "de": "Onboarding starten",
      "pt": "Iniciar integração",
      "it": "Avvia l’onboarding",
      "id": "Mulai onboarding"
    },
    "manage_blood_sugar": {
      "en": "Manage Blood Sugar",
      "vi": "Quản lý đường huyết",
      "ja": "血糖を管理する",
      "ar": "إدارة مستوى السكر في الدم",
      "hi": "ब्लड शुगर प्रबंधन",
      "th": "จัดการระดับน้ำตาลในเลือด",
      "es": "Gestionar el nivel de azúcar en la sangre",
      "ko": "혈당 관리",
      "zh_Hans": "管理血糖",
      "fr": "Gérer la glycémie",
      "tr": "Kan şekerini yönet",
      "ru": "Управление уровнем сахара в крови",
      "de": "Blutzucker verwalten",
      "pt": "Gerenciar o açúcar no sangue",
      "it": "Gestire la glicemia",
      "id": "Mengelola gula darah"
    },
    "precision_glucose_insulin_tracking": {
      "en": "Precision glucose & insulin tracking.",
      "vi": "Theo dõi đường huyết và insulin chính xác.",
      "ja": "正確な血糖値とインスリンの追跡。",
      "ar": "تتبع دقيق لمستوى الجلوكوز والأنسولين.",
      "hi": "सटीक ग्लूकोज़ और इंसुलिन ट्रैकिंग।",
      "th": "การติดตามระดับน้ำตาลและอินซูลินอย่างแม่นยำ",
      "es": "Seguimiento preciso de glucosa e insulina.",
      "ko": "정밀한 혈당 및 인슐린 추적.",
      "zh_Hans": "精确的血糖和胰岛素追踪。",
      "fr": "Suivi précis de la glycémie et de l’insuline.",
      "tr": "Hassas glikoz ve insülin takibi.",
      "ru": "Точное отслеживание глюкозы и инсулина.",
      "de": "Präzise Überwachung von Glukose und Insulin.",
      "pt": "Rastreamento preciso de glicose e insulina.",
      "it": "Monitoraggio preciso di glucosio e insulina.",
      "id": "Pemantauan glukosa dan insulin yang presisi."
    },
    "healthy_eating": {
      "en": "Healthy Eating",
      "vi": "Ăn uống lành mạnh",
      "ja": "健康的な食事",
      "ar": "الأكل الصحي",
      "hi": "स्वस्थ भोजन",
      "th": "การรับประทานอาหารเพื่อสุขภาพ",
      "es": "Alimentación saludable",
      "ko": "건강한 식습관",
      "zh_Hans": "健康饮食",
      "fr": "Alimentation saine",
      "tr": "Sağlıklı Beslenme",
      "ru": "Здоровое питание",
      "de": "Gesunde Ernährung",
      "pt": "Alimentação saudável",
      "it": "Alimentazione sana",
      "id": "Pola makan sehat"
    },
    "balanced_meal_plans_and_intake": {
      "en": "Balanced meal plans and intake.",
      "vi": "Kế hoạch bữa ăn cân bằng và lượng ăn vào.",
      "ja": "バランスの取れた食事プランと摂取量。",
      "ar": "خطط وجبات متوازنة وكمية تناول مناسبة.",
      "hi": "संतुलित भोजन योजनाएँ और सेवन मात्रा।",
      "th": "แผนมื้ออาหารที่สมดุลและปริมาณการบริโภค.",
      "es": "Planes de comidas equilibrados y consumo adecuado.",
      "ko": "균형 잡힌 식단 계획과 섭취량.",
      "zh_Hans": "均衡的膳食计划和摄入量。",
      "fr": "Plans de repas équilibrés et apport alimentaire.",
      "tr": "Dengeli öğün planları ve alım miktarı.",
      "ru": "Сбалансированные планы питания и объем потребления.",
      "de": "Ausgewogene Ernährungspläne und Nahrungsaufnahme.",
      "pt": "Planos de refeições equilibrados e ingestão adequada.",
      "it": "Piani alimentari equilibrati e quantità di assunzione.",
      "id": "Rencana makan seimbang dan asupan harian."
    },
    "track_heart_health": {
      "en": "Track Heart Health",
      "vi": "Theo dõi sức khỏe tim mạch",
      "ja": "心臓の健康を追跡",
      "ar": "تتبع صحة القلب",
      "hi": "हृदय स्वास्थ्य को ट्रैक करें",
      "th": "ติดตามสุขภาพหัวใจ",
      "es": "Monitorea la salud del corazón",
      "ko": "심장 건강 추적",
      "zh_Hans": "追踪心脏健康",
      "fr": "Suivre la santé cardiaque",
      "tr": "Kalp sağlığını takip et",
      "ru": "Отслеживание здоровья сердца",
      "de": "Herzgesundheit verfolgen",
      "pt": "Acompanhar a saúde do coração",
      "it": "Monitora la salute del cuore",
      "id": "Lacak kesehatan jantung"
    },
    "monitor_pressure_pulse_trends": {
      "en": "Monitor pressure and pulse trends.",
      "vi": "Theo dõi xu hướng huyết áp và nhịp tim.",
      "ja": "血圧と脈拍の傾向をモニタリングします。",
      "ar": "راقب اتجاهات ضغط الدم والنبض.",
      "hi": "रक्तचाप और नाड़ी के रुझानों की निगरानी करें।",
      "th": "ติดตามแนวโน้มความดันและชีพจร",
      "es": "Monitorea las tendencias de presión y pulso.",
      "ko": "혈압과 맥박의 추세를 모니터링하세요.",
      "zh_Hans": "监测血压和脉搏趋势。",
      "fr": "Surveillez les tendances de la pression et du pouls.",
      "tr": "Tansiyon ve nabız eğilimlerini izleyin.",
      "ru": "Отслеживайте тенденции давления и пульса.",
      "de": "Überwachen Sie Blutdruck- und Pulstendenzen.",
      "pt": "Monitore as tendências de pressão e pulso.",
      "it": "Monitora le tendenze della pressione e del polso.",
      "id": "Pantau tren tekanan dan denyut nadi."
    },
    "weight_loss": {
      "en": "Weight Loss",
      "vi": "Giảm cân",
      "ja": "減量",
      "ar": "فقدان الوزن",
      "hi": "वज़न कम करना",
      "th": "การลดน้ำหนัก",
      "es": "Pérdida de peso",
      "ko": "체중 감량",
      "zh_Hans": "减重",
      "fr": "Perte de poids",
      "tr": "Kilo Kaybı",
      "ru": "Похудение",
      "de": "Gewichtsverlust",
      "pt": "Perda de peso",
      "it": "Perdita di peso",
      "id": "Penurunan berat badan"
    },
    "reach_target_weight_safely": {
      "en": "Reach your target weight safely.",
      "vi": "Đạt được cân nặng mục tiêu của bạn một cách an toàn.",
      "ja": "目標体重を安全に達成しましょう。",
      "ar": "حقق وزنك المستهدف بأمان.",
      "hi": "अपना लक्ष्य वजन सुरक्षित रूप से प्राप्त करें।",
      "th": "ลดน้ำหนักให้ถึงเป้าหมายอย่างปลอดภัย",
      "es": "Alcanza tu peso objetivo de forma segura.",
      "ko": "목표 체중을 안전하게 달성하세요.",
      "zh_Hans": "安全地达到您的目标体重。",
      "fr": "Atteignez votre poids cible en toute sécurité.",
      "tr": "Hedef kilonuza güvenli bir şekilde ulaşın.",
      "ru": "Безопасно достигните вашего целевого веса.",
      "de": "Erreichen Sie sicher Ihr Wunschgewicht.",
      "pt": "Alcance seu peso ideal com segurança.",
      "it": "Raggiungi il tuo peso ideale in modo sicuro.",
      "id": "Capai berat badan target Anda dengan aman."
    },
    "primary_goal_question": {
      "en": "What is your primary goal?",
      "vi": "Mục tiêu chính của bạn là gì?",
      "ja": "あなたの主な目標は何ですか？",
      "ar": "ما هو هدفك الأساسي؟",
      "hi": "आपका मुख्य लक्ष्य क्या है?",
      "th": "เป้าหมายหลักของคุณคืออะไร?",
      "es": "¿Cuál es tu objetivo principal?",
      "ko": "당신의 주요 목표는 무엇인가요?",
      "zh_Hans": "你的主要目标是什么？",
      "fr": "Quel est votre objectif principal ?",
      "tr": "Birincil hedefiniz nedir?",
      "ru": "Какова ваша основная цель?",
      "de": "Was ist Ihr Hauptziel?",
      "pt": "Qual é o seu principal objetivo?",
      "it": "Qual è il tuo obiettivo principale?",
      "id": "Apa tujuan utama Anda?"
    },
    "personalize_your_journey_health": {
      "en": "Personalize your journey for better health outcomes.",
      "vi": "Cá nhân hóa hành trình của bạn để đạt kết quả sức khỏe tốt hơn.",
      "ja": "より良い健康成果のために、あなたの旅をパーソナライズしましょう。",
      "ar": "خصص رحلتك لتحقيق نتائج صحية أفضل.",
      "hi": "बेहतर स्वास्थ्य परिणामों के लिए अपनी यात्रा को व्यक्तिगत बनाएं.",
      "th": "ปรับแต่งเส้นทางสุขภาพของคุณเพื่อผลลัพธ์ที่ดีขึ้น",
      "es": "Personaliza tu camino para obtener mejores resultados de salud.",
      "ko": "더 나은 건강 결과를 위해 여정을 개인화하세요.",
      "zh_Hans": "个性化你的健康之旅，获得更好的健康成果。",
      "fr":
          "Personnalisez votre parcours pour de meilleurs résultats de santé.",
      "tr": "Daha iyi sağlık sonuçları için yolculuğunuzu kişiselleştirin.",
      "ru": "Персонализируйте свой путь для лучших результатов в здоровье.",
      "de": "Personalisieren Sie Ihren Weg für bessere Gesundheitsresultate.",
      "pt": "Personalize sua jornada para melhores resultados de saúde.",
      "it":
          "Personalizza il tuo percorso per ottenere migliori risultati di salute.",
      "id":
          "Personalisasikan perjalanan Anda demi hasil kesehatan yang lebih baik."
    },
    "secure_clinical_encryption": {
      "en": "SECURE CLINICAL ENCRYPTION",
      "vi": "MÃ HÓA LÂM SÀNG AN TOÀN",
      "ja": "安全な臨床暗号化".toUpperCase(),
      "ar": "تشفير سريري آمن".toUpperCase(),
      "hi": "सुरक्षित नैदानिक ​​एन्क्रिप्शन".toUpperCase(),
      "th": "การเข้ารหัสข้อมูลทางคลินิกที่ปลอดภัย".toUpperCase(),
      "es": "CIFRADO CLÍNICO SEGURO",
      "ko": "보안 임상 암호화".toUpperCase(),
      "zh_Hans": "安全的临床加密".toUpperCase(),
      "fr": "CHIFFREMENT CLINIQUE SÉCURISÉ",
      "tr": "GÜVENLİ KLİNİK ŞİFRELEME",
      "ru": "БЕЗОПАСНОЕ КЛИНИЧЕСКОЕ ШИФРОВАНИЕ",
      "de": "SICHERE KLINISCHE VERSCHLÜSSELUNG",
      "pt": "CRIPTOGRAFIA CLÍNICA SEGURA",
      "it": "CRITTOGRAFIA CLINICA SICURA",
      "id": "ENKRIPSI KLINIS YANG AMAN"
    },
    "personal_health_profile": {
      "en": "Personal Health Profile",
      "vi": "Hồ sơ sức khỏe cá nhân",
      "ja": "個人の健康プロフィール",
      "ar": "الملف الصحي الشخصي",
      "hi": "व्यक्तिगत स्वास्थ्य प्रोफ़ाइल",
      "th": "โปรไฟล์สุขภาพส่วนบุคคล",
      "es": "Perfil de salud personal",
      "ko": "개인 건강 프로필",
      "zh_Hans": "个人健康档案",
      "fr": "Profil de santé personnel",
      "tr": "Kişisel Sağlık Profili",
      "ru": "Личный профиль здоровья",
      "de": "Persönliches Gesundheitsprofil",
      "pt": "Perfil de saúde pessoal",
      "it": "Profilo sanitario personale",
      "id": "Profil kesehatan pribadi"
    },
    "tell_about_yourself_customize": {
      "en": "Tell us about yourself to customize",
      "vi": "Hãy cho chúng tôi biết về bạn để tùy chỉnh",
      "ja": "カスタマイズするためにあなたについて教えてください",
      "ar": "أخبرنا عن نفسك للتخصيص",
      "hi": "अनुकूलन के लिए हमें अपने बारे में बताएं",
      "th": "บอกเราเกี่ยวกับตัวคุณเพื่อปรับให้เหมาะกับคุณ",
      "es": "Cuéntanos sobre ti para personalizar",
      "ko": "맞춤 설정을 위해 당신에 대해 알려주세요",
      "zh_Hans": "告诉我们关于您的信息以便进行个性化设置",
      "fr": "Parlez-nous de vous pour personnaliser",
      "tr": "Kişiselleştirmek için bize kendinizden bahsedin",
      "ru": "Расскажите нам о себе для персонализации",
      "de": "Erzählen Sie uns von sich, um zu personalisieren",
      "pt": "Conte-nos sobre você para personalizar",
      "it": "Parlaci di te per personalizzare",
      "id": "Ceritakan tentang diri Anda untuk menyesuaikan"
    },
    "gender": {
      "en": "GENDER",
      "vi": "GIỚI TÍNH",
      "ja": "性別",
      "ar": "الجِنْس",
      "hi": "लिंग",
      "th": "เพศ",
      "es": "GÉNERO",
      "ko": "성별",
      "zh_Hans": "性别",
      "fr": "GENRE",
      "tr": "CİNSİYET",
      "ru": "ПОЛ",
      "de": "GESCHLECHT",
      "pt": "GÊNERO",
      "it": "GENERE",
      "id": "JENIS KELAMIN"
    },
    "male": {
      "en": "Male",
      "vi": "Nam",
      "ja": "男性",
      "ar": "ذكر",
      "hi": "पुरुष",
      "th": "ชาย",
      "es": "Hombre",
      "ko": "남성",
      "zh_Hans": "男性",
      "fr": "Homme",
      "tr": "Erkek",
      "ru": "Мужчина",
      "de": "Männlich",
      "pt": "Masculino",
      "it": "Maschio",
      "id": "Laki-laki"
    },
    "female": {
      "en": "Female",
      "vi": "Nữ",
      "ja": "女性",
      "ar": "أنثى",
      "hi": "महिला",
      "th": "หญิง",
      "es": "Mujer",
      "ko": "여성",
      "zh_Hans": "女性",
      "fr": "Femme",
      "tr": "Kadın",
      "ru": "Женщина",
      "de": "Weiblich",
      "pt": "Feminino",
      "it": "Femmina",
      "id": "Perempuan"
    },
    "prefer_not_to_say": {
      "en": "Prefer not to say",
      "vi": "Không muốn tiết lộ",
      "ja": "回答しない",
      "ar": "يفضل عدم الإفصاح",
      "hi": "कहना नहीं चाहता/चाहती",
      "th": "ไม่ประสงค์จะระบุ",
      "es": "Prefiero no decirlo",
      "ko": "말하고 싶지 않음",
      "zh_Hans": "不愿透露",
      "fr": "Préfère ne pas répondre",
      "tr": "Belirtmek istemiyorum",
      "ru": "Предпочитаю не говорить",
      "de": "Möchte ich nicht sagen",
      "pt": "Prefiro não dizer",
      "it": "Preferisco non dirlo",
      "id": "Lebih memilih untuk tidak mengatakan"
    },
    "diabetes_type": {
      "en": "DIABETES TYPE",
      "vi": "LOẠI BỆNH TIỂU ĐƯỜNG",
      "ja": "糖尿病の種類",
      "ar": "نَوْعُ مَرَضِ السُّكَّرِيّ",
      "hi": "मधुमेह का प्रकार",
      "th": "ประเภทของโรคเบาหวาน",
      "es": "TIPO DE DIABETES",
      "ko": "당뇨병 유형",
      "zh_Hans": "糖尿病类型",
      "fr": "TYPE DE DIABÈTE",
      "tr": "DİYABET TÜRÜ",
      "ru": "ТИП ДИАБЕТА",
      "de": "DIABETES-TYP",
      "pt": "TIPO DE DIABETES",
      "it": "TIPO DI DIABETE",
      "id": "JENIS DIABETES"
    },
    "type_1": {
      "en": "Type 1",
      "vi": "Loại 1",
      "ja": "1型",
      "ar": "النوع 1",
      "hi": "टाइप 1",
      "th": "ชนิดที่ 1",
      "es": "Tipo 1",
      "ko": "1형",
      "zh_Hans": "1型",
      "fr": "Type 1",
      "tr": "Tip 1",
      "ru": "Тип 1",
      "de": "Typ 1",
      "pt": "Tipo 1",
      "it": "Tipo 1",
      "id": "Tipe 1"
    },
    "type_2": {
      "en": "Type 2",
      "vi": "Loại 2",
      "ja": "タイプ2",
      "ar": "النوع 2",
      "hi": "टाइप 2",
      "th": "ประเภท 2",
      "es": "Tipo 2",
      "ko": "타입 2",
      "zh_Hans": "2型",
      "fr": "Type 2",
      "tr": "Tip 2",
      "ru": "Тип 2",
      "de": "Typ 2",
      "pt": "Tipo 2",
      "it": "Tipo 2",
      "id": "Tipe 2"
    },
    "gestational": {
      "en": "Gestational",
      "vi": "Thai kỳ",
      "ja": "妊娠性",
      "ar": "حملي",
      "hi": "गर्भावधि",
      "th": "เกี่ยวกับการตั้งครรภ์",
      "es": "Gestacional",
      "ko": "임신성",
      "zh_Hans": "妊娠期",
      "fr": "Gestationnel",
      "tr": "Gebelikle ilgili",
      "ru": "Гестационный",
      "de": "Gestational",
      "pt": "Gestacional",
      "it": "Gestazionale",
      "id": "Kehamilan"
    },
    "age": {
      "en": "AGE",
      "vi": "TUỔI",
      "ja": "年齢",
      "ar": "العُمْر",
      "hi": "आयु",
      "th": "อายุ",
      "es": "EDAD",
      "ko": "나이",
      "zh_Hans": "年龄",
      "fr": "ÂGE",
      "tr": "YAŞ",
      "ru": "ВОЗРАСТ",
      "de": "ALTER",
      "pt": "IDADE",
      "it": "ETÀ",
      "id": "USIA"
    },
    "height": {
      "en": "HEIGHT",
      "vi": "CHIỀU CAO",
      "ja": "身長",
      "ar": "الطُول",
      "hi": "ऊँचाई",
      "th": "ส่วนสูง",
      "es": "ALTURA",
      "ko": "키",
      "zh_Hans": "身高",
      "fr": "TAILLE",
      "tr": "BOY",
      "ru": "РОСТ",
      "de": "HÖHE",
      "pt": "ALTURA",
      "it": "ALTEZZA",
      "id": "TINGGI BADAN"
    },
    "weight": {
      "en": "WEIGHT",
      "vi": "CÂN NẶNG",
      "ja": "体重",
      "ar": "الْوَزْن",
      "hi": "वज़न",
      "th": "น้ำหนัก",
      "es": "PESO",
      "ko": "체중",
      "zh_Hans": "体重",
      "fr": "POIDS",
      "tr": "KİLO",
      "ru": "ВЕС",
      "de": "GEWICHT",
      "pt": "PESO",
      "it": "PESO",
      "id": "BERAT BADAN"
    },
    "save_profile": {
      "en": "Save Profile",
      "vi": "Lưu Hồ Sơ",
      "ja": "プロフィールを保存",
      "ar": "حفظ الملف الشخصي",
      "hi": "प्रोफ़ाइल सहेजें",
      "th": "บันทึกโปรไฟล์",
      "es": "Guardar Perfil",
      "ko": "프로필 저장",
      "zh_Hans": "保存资料",
      "fr": "Enregistrer le profil",
      "tr": "Profili Kaydet",
      "ru": "Сохранить профиль",
      "de": "Profil speichern",
      "pt": "Salvar Perfil",
      "it": "Salva Profilo",
      "id": "Simpan Profil"
    },
    "your_privacy_is_our_priority": {
      "en": "YOUR PRIVACY IS OUR PRIORITY.",
      "vi": "QUYỀN RIÊNG TƯ CỦA BẠN LÀ ƯU TIÊN CỦA CHÚNG TÔI.",
      "ja": "あなたのプライバシーは私たちの最優先事項です。",
      "ar": "خصوصيتك هي أولويتنا.",
      "hi": "आपकी गोपनीयता हमारी प्राथमिकता है.",
      "th": "ความเป็นส่วนตัวของคุณคือความสำคัญของเรา.",
      "es": "TU PRIVACIDAD ES NUESTRA PRIORIDAD.",
      "ko": "당신의 개인정보 보호는 우리의 최우선 과제입니다.",
      "zh_Hans": "您的隐私是我们的首要任务。",
      "fr": "VOTRE CONFIDENTIALITÉ EST NOTRE PRIORITÉ.",
      "tr": "GİZLİLİĞİNİZ BİZİM ÖNCELİĞİMİZDİR.",
      "ru": "ВАША КОНФИДЕНЦИАЛЬНОСТЬ — НАШ ПРИОРИТЕТ.",
      "de": "IHRE PRIVATSPHÄRE HAT FÜR UNS PRIORITÄT.",
      "pt": "A SUA PRIVACIDADE É A NOSSA PRIORIDADE.",
      "it": "LA TUA PRIVACY È LA NOSTRA PRIORITÀ.",
      "id": "PRIVASI ANDA ADALAH PRIORITAS KAMI."
    },
    "privacy_policy": {
      "en": "PRIVACY POLICY",
      "vi": "CHÍNH SÁCH QUYỀN RIÊNG TƯ",
      "ja": "プライバシーポリシー",
      "ar": "سياسة الخصوصية",
      "hi": "गोपनीयता नीति",
      "th": "นโยบายความเป็นส่วนตัว",
      "es": "POLÍTICA DE PRIVACIDAD",
      "ko": "개인정보 처리방침",
      "zh_Hans": "隐私政策",
      "fr": "POLITIQUE DE CONFIDENTIALITÉ",
      "tr": "GİZLİLİK POLİTİKASI",
      "ru": "ПОЛИТИКА КОНФИДЕНЦИАЛЬНОСТИ",
      "de": "DATENSCHUTZRICHTLINIE",
      "pt": "POLÍTICA DE PRIVACIDADE",
      "it": "INFORMATIVA SULLA PRIVACY",
      "id": "KEBIJAKAN PRIVASI"
    },
    "connect_your_health_data": {
      "en": "Connect Your Health Data",
      "vi": "Kết nối dữ liệu sức khỏe của bạn",
      "ja": "あなたの健康データを接続",
      "ar": "قم بتوصيل بيانات صحتك",
      "hi": "अपना स्वास्थ्य डेटा कनेक्ट करें",
      "th": "เชื่อมต่อข้อมูลสุขภาพของคุณ",
      "es": "Conecta tus datos de salud",
      "ko": "건강 데이터를 연결하세요",
      "zh_Hans": "连接您的健康数据",
      "fr": "Connectez vos données de santé",
      "tr": "Sağlık verilerinizi bağlayın",
      "ru": "Подключите свои данные о здоровье",
      "de": "Verbinden Sie Ihre Gesundheitsdaten",
      "pt": "Conecte seus dados de saúde",
      "it": "Collega i tuoi dati sulla salute",
      "id": "Hubungkan data kesehatan Anda"
    },
    "let_glucopal_sync_with_apple_health_to_give_you_a_complete_view_of_your_daily_wellness":
        {
      "en":
          "Let glucoPal sync with Apple Health to give you a complete view of your daily wellness.",
      "vi":
          "Hãy cho phép glucoPal đồng bộ với Apple Health để cung cấp cho bạn cái nhìn toàn diện về sức khỏe hàng ngày.",
      "ja": "glucoPal を Apple Health と同期して、日々の健康状態を包括的に把握しましょう。",
      "ar":
          "دع glucoPal يتزامن مع Apple Health ليمنحك نظرة كاملة على صحتك اليومية.",
      "hi":
          "glucoPal को Apple Health के साथ सिंक करने दें ताकि आपको अपनी दैनिक सेहत का पूरा दृश्य मिल सके।",
      "th":
          "ให้ glucoPal ซิงค์กับ Apple Health เพื่อให้คุณเห็นภาพรวมสุขภาพประจำวันของคุณอย่างครบถ้วน",
      "es":
          "Permite que glucoPal se sincronice con Apple Health para ofrecerte una visión completa de tu bienestar diario.",
      "ko": "glucoPal을 Apple Health와 동기화하여 일상적인 건강 상태를 전체적으로 확인하세요.",
      "zh_Hans": "让 glucoPal 与 Apple Health 同步，为您提供每日健康状况的完整视图。",
      "fr":
          "Permettez à glucoPal de se synchroniser avec Apple Health pour vous offrir une vue complète de votre bien-être quotidien.",
      "tr":
          "glucoPal'ın Apple Health ile senkronize olmasına izin vererek günlük sağlığınızın tam bir görünümünü elde edin.",
      "ru":
          "Разрешите glucoPal синхронизироваться с Apple Health, чтобы получить полный обзор вашего ежедневного самочувствия.",
      "de":
          "Lassen Sie glucoPal mit Apple Health synchronisieren, um einen vollständigen Überblick über Ihr tägliches Wohlbefinden zu erhalten.",
      "pt":
          "Permita que o glucoPal sincronize com o Apple Health para oferecer uma visão completa do seu bem-estar diário.",
      "it":
          "Consenti a glucoPal di sincronizzarsi con Apple Health per offrirti una visione completa del tuo benessere quotidiano.",
      "id":
          "Izinkan glucoPal menyinkronkan dengan Apple Health untuk memberi Anda gambaran lengkap tentang kesehatan harian Anda."
    },
    "steps": {
      "en": "Steps",
      "vi": "Bước",
      "ja": "歩数",
      "ar": "الخطوات",
      "hi": "कदम",
      "th": "ก้าว",
      "es": "Pasos",
      "ko": "걸음",
      "zh_Hans": "步数",
      "fr": "Pas",
      "tr": "Adımlar",
      "ru": "Шаги",
      "de": "Schritte",
      "pt": "Passos",
      "it": "Passi",
      "id": "Langkah"
    },
    "heart_rate": {
      "en": "Heart Rate",
      "vi": "Nhịp tim",
      "ja": "心拍数",
      "ar": "معدل ضربات القلب",
      "hi": "हृदय गति",
      "th": "อัตราการเต้นของหัวใจ",
      "es": "Frecuencia cardíaca",
      "ko": "심박수",
      "zh_Hans": "心率",
      "fr": "Fréquence cardiaque",
      "tr": "Kalp atış hızı",
      "ru": "Частота сердечных сокращений",
      "de": "Herzfrequenz",
      "pt": "Frequência cardíaca",
      "it": "Frequenza cardiaca",
      "id": "Detak jantung"
    },
    "sleep_analysis": {
      "en": "Sleep Analysis",
      "vi": "Phân tích giấc ngủ",
      "ja": "睡眠分析",
      "ar": "تحليل النوم",
      "hi": "नींद विश्लेषण",
      "th": "การวิเคราะห์การนอนหลับ",
      "es": "Análisis del sueño",
      "ko": "수면 분석",
      "zh_Hans": "睡眠分析",
      "fr": "Analyse du sommeil",
      "tr": "Uyku Analizi",
      "ru": "Анализ сна",
      "de": "Schlafanalyse",
      "pt": "Análise do sono",
      "it": "Analisi del sonno",
      "id": "Analisis tidur"
    },
    "active_energy": {
      "en": "Active Energy",
      "vi": "Năng lượng hoạt động",
      "ja": "アクティブエネルギー",
      "ar": "الطاقة النشطة",
      "hi": "सक्रिय ऊर्जा",
      "th": "พลังงานที่ใช้ในการเคลื่อนไหว",
      "es": "Energía activa",
      "ko": "활동 에너지",
      "zh_Hans": "活动能量",
      "fr": "Énergie active",
      "tr": "Aktif enerji",
      "ru": "Активная энергия",
      "de": "Aktive Energie",
      "pt": "Energia ativa",
      "it": "Energia attiva",
      "id": "Energi aktif"
    },
    "sync_with_apple_health": {
      "en": "Sync with Apple Health",
      "vi": "Đồng bộ với Apple Health",
      "ja": "Apple Healthと同期",
      "ar": "المزامنة مع Apple Health",
      "hi": "Apple Health के साथ सिंक करें",
      "th": "ซิงค์กับ Apple Health",
      "es": "Sincronizar con Apple Health",
      "ko": "Apple Health와 동기화",
      "zh_Hans": "与 Apple Health 同步",
      "fr": "Synchroniser avec Apple Health",
      "tr": "Apple Health ile senkronize et",
      "ru": "Синхронизировать с Apple Health",
      "de": "Mit Apple Health synchronisieren",
      "pt": "Sincronizar com Apple Health",
      "it": "Sincronizza con Apple Health",
      "id": "Sinkronkan dengan Apple Health"
    },
    "skip_for_now": {
      "en": "Skip for now",
      "vi": "Bỏ qua lúc này",
      "ja": "今はスキップ",
      "ar": "تخطي الآن",
      "hi": "अभी छोड़ें",
      "th": "ข้ามตอนนี้",
      "es": "Saltar por ahora",
      "ko": "지금은 건너뛰기",
      "zh_Hans": "暂时跳过",
      "fr": "Passer pour le moment",
      "tr": "Şimdilik atla",
      "ru": "Пропустить сейчас",
      "de": "Jetzt überspringen",
      "pt": "Pular por agora",
      "it": "Salta per ora",
      "id": "Lewati untuk sekarang"
    },
    "understand_your_food_instantly": {
      "en": "Understand Your Food Instantly",
      "vi": "Hiểu Thực Phẩm Của Bạn Ngay Lập Tức",
      "ja": "食べ物を瞬時に理解",
      "ar": "افهم طعامك فورًا",
      "hi": "अपने भोजन को तुरंत समझें",
      "th": "เข้าใจอาหารของคุณทันที",
      "es": "Comprende Tu Comida Al Instante",
      "ko": "음식을 즉시 이해하세요",
      "zh_Hans": "即时了解你的食物",
      "fr": "Comprenez Votre Alimentation Instantanément",
      "tr": "Yemeğinizi Anında Anlayın",
      "ru": "Мгновенно Понимайте Свою Еду",
      "de": "Verstehen Sie Ihr Essen Sofort",
      "pt": "Entenda Sua Comida Instantaneamente",
      "it": "Comprendi Il Tuo Cibo All'Istante",
      "id": "Pahami Makanan Anda Secara Instan"
    },
    "camera_meal_diabetes_analysis": {
      "en":
          "Point your camera at any meal for instant diabetic warnings, glycemic load analysis, and automated macro tracking.",
      "vi":
          "Chĩa camera vào bất kỳ bữa ăn nào để nhận cảnh báo tiểu đường tức thì, phân tích tải lượng đường huyết và theo dõi macro tự động.",
      "ja": "カメラを食事に向けるだけで、糖尿病警告、グリセミック負荷分析、自動マクロ追跡を即座に取得できます。",
      "ar":
          "وجّه الكاميرا إلى أي وجبة للحصول على تحذيرات فورية لمرضى السكري وتحليل الحمل الجلايسيمي وتتبع المغذيات الكبرى تلقائيًا.",
      "hi":
          "किसी भी भोजन पर कैमरा इंगित करें और तुरंत मधुमेह चेतावनी, ग्लाइसेमिक लोड विश्लेषण और स्वचालित मैक्रो ट्रैकिंग प्राप्त करें।",
      "th":
          "ชี้กล้องไปที่มื้ออาหารใดก็ได้เพื่อรับคำเตือนสำหรับผู้ป่วยเบาหวานทันที การวิเคราะห์ภาระไกลซีมิก และการติดตามสารอาหารหลักอัตโนมัติ",
      "es":
          "Apunta tu cámara a cualquier comida para obtener advertencias instantáneas para diabéticos, análisis de carga glucémica y seguimiento automático de macronutrientes.",
      "ko": "카메라를 음식에 비추면 즉시 당뇨 경고, 혈당 부하 분석 및 자동 매크로 추적을 받을 수 있습니다.",
      "zh_Hans": "将相机对准任何餐食，即可获得即时糖尿病警告、血糖负荷分析和自动宏量营养追踪。",
      "fr":
          "Pointez votre caméra vers n’importe quel repas pour obtenir des avertissements diabétiques instantanés, une analyse de la charge glycémique et un suivi automatique des macros.",
      "tr":
          "Herhangi bir yemeğe kameranızı doğrultarak anında diyabet uyarıları, glisemik yük analizi ve otomatik makro takibi alın.",
      "ru":
          "Наведите камеру на любое блюдо, чтобы мгновенно получить предупреждения для диабетиков, анализ гликемической нагрузки и автоматическое отслеживание макроэлементов.",
      "de":
          "Richten Sie Ihre Kamera auf eine beliebige Mahlzeit, um sofortige Diabeteswarnungen, eine Analyse der glykämischen Last und automatische Makroverfolgung zu erhalten.",
      "pt":
          "Aponte sua câmera para qualquer refeição para obter avisos instantâneos para diabéticos, análise de carga glicêmica e rastreamento automático de macronutrientes.",
      "it":
          "Punta la fotocamera su qualsiasi pasto per ricevere avvisi immediati per il diabete, analisi del carico glicemico e tracciamento automatico dei macronutrienti.",
      "id":
          "Arahkan kamera ke makanan apa pun untuk mendapatkan peringatan diabetes instan, analisis beban glikemik, dan pelacakan makro otomatis."
    },
    "ai_scan": {
      "en": "AI SCAN",
      "vi": "QUÉT AI",
      "ja": "AIスキャン",
      "ar": "فحص AI",
      "hi": "AI स्कैन",
      "th": "สแกน AI",
      "es": "ESCANEO AI",
      "ko": "AI 스캔",
      "zh_Hans": "AI扫描",
      "fr": "SCAN IA",
      "tr": "AI TARAMA",
      "ru": "AI СКАНИРОВАНИЕ",
      "de": "AI-SCAN",
      "pt": "SCAN IA",
      "it": "SCANSIONE AI",
      "id": "PEMINDAIAN AI"
    },
    "real_time": {
      "en": "REAL-TIME",
      "vi": "THỜI GIAN THỰC",
      "ja": "リアルタイム",
      "ar": "الوقت الحقيقي",
      "hi": "रीयल-टाइम",
      "th": "เรียลไทม์",
      "es": "TIEMPO REAL",
      "ko": "실시간",
      "zh_Hans": "实时",
      "fr": "TEMPS RÉEL",
      "tr": "GERÇEK ZAMANLI",
      "ru": "В РЕАЛЬНОМ ВРЕМЕНИ",
      "de": "Echtzeit",
      "pt": "TEMPO REAL",
      "it": "TEMPO REALE",
      "id": "WAKTU NYATA"
    },
    "enable_camera_access": {
      "en": "Enable Camera Access",
      "vi": "Bật Quyền Truy Cập Camera",
      "ja": "カメラアクセスを有効にする",
      "ar": "تمكين الوصول إلى الكاميرا",
      "hi": "कैमरा एक्सेस सक्षम करें",
      "th": "เปิดใช้งานการเข้าถึงกล้อง",
      "es": "Habilitar Acceso a la Cámara",
      "ko": "카메라 접근 허용",
      "zh_Hans": "启用相机访问",
      "fr": "Activer l'accès à la caméra",
      "tr": "Kamera Erişimini Etkinleştir",
      "ru": "Включить доступ к камере",
      "de": "Kamerazugriff aktivieren",
      "pt": "Ativar acesso à câmera",
      "it": "Abilita accesso alla fotocamera",
      "id": "Aktifkan Akses Kamera"
    },
    "camera_food_nutrition_usage": {
      "en":
          "We use your camera only to identify food items and calculate nutrition facts.",
      "vi":
          "Chúng tôi chỉ sử dụng camera của bạn để nhận diện món ăn và tính toán thông tin dinh dưỡng.",
      "ja": "カメラは食品を識別し、栄養情報を計算する目的でのみ使用されます。",
      "ar": "نستخدم الكاميرا فقط للتعرف على الأطعمة وحساب المعلومات الغذائية.",
      "hi":
          "हम आपके कैमरे का उपयोग केवल भोजन की पहचान करने और पोषण संबंधी जानकारी की गणना करने के लिए करते हैं।",
      "th":
          "เราใช้กล้องของคุณเพียงเพื่อระบุรายการอาหารและคำนวณข้อมูลโภชนาการเท่านั้น",
      "es":
          "Usamos su cámara solo para identificar alimentos y calcular información nutricional.",
      "ko": "카메라는 음식 항목을 식별하고 영양 정보를 계산하기 위해서만 사용됩니다.",
      "zh_Hans": "我们仅使用您的相机来识别食物并计算营养信息。",
      "fr":
          "Nous utilisons votre caméra uniquement pour identifier les aliments et calculer les informations nutritionnelles.",
      "tr":
          "Kameranızı yalnızca yiyecekleri tanımlamak ve besin değerlerini hesaplamak için kullanıyoruz.",
      "ru":
          "Мы используем вашу камеру только для определения продуктов и расчета их пищевой ценности.",
      "de":
          "Wir verwenden Ihre Kamera nur, um Lebensmittel zu erkennen und Nährwertangaben zu berechnen.",
      "pt":
          "Usamos sua câmera apenas para identificar alimentos e calcular informações nutricionais.",
      "it":
          "Usiamo la tua fotocamera solo per identificare gli alimenti e calcolare i valori nutrizionali.",
      "id":
          "Kami menggunakan kamera Anda hanya untuk mengidentifikasi makanan dan menghitung informasi nutrisi."
    },
    "secure_your_health_data_journey": {
      "en": "Secure your health data journey.",
      "vi": "Bảo mật hành trình dữ liệu sức khỏe của bạn.",
      "ja": "あなたの健康データの旅を安全に守りましょう。",
      "ar": "أمّن رحلة بيانات صحتك.",
      "hi": "अपनी स्वास्थ्य डेटा यात्रा को सुरक्षित रखें।",
      "th": "รักษาความปลอดภัยให้กับเส้นทางข้อมูลสุขภาพของคุณ",
      "es": "Asegura tu viaje de datos de salud.",
      "ko": "건강 데이터 여정을 안전하게 보호하세요.",
      "zh_Hans": "保护您的健康数据之旅。",
      "fr": "Sécurisez votre parcours de données de santé.",
      "tr": "Sağlık verisi yolculuğunuzu güvence altına alın.",
      "ru": "Защитите путь ваших данных о здоровье.",
      "de": "Sichern Sie Ihre Gesundheitsdaten-Reise.",
      "pt": "Proteja sua jornada de dados de saúde.",
      "it": "Proteggi il tuo percorso dei dati sanitari.",
      "id": "Amankan perjalanan data kesehatan Anda."
    },
    "scan_food": {
      "en": "SCAN FOOD",
      "vi": "QUÉT THỰC PHẨM",
      "ja": "食品をスキャン",
      "ar": "مسح الطعام",
      "hi": "भोजन स्कैन करें",
      "th": "สแกนอาหาร",
      "es": "ESCANEAR COMIDA",
      "ko": "음식 스캔",
      "zh_Hans": "扫描食物",
      "fr": "SCANNER LA NOURRITURE",
      "tr": "YEMEĞİ TARA",
      "ru": "СКАНИРОВАТЬ ЕДУ",
      "de": "ESSEN SCANNEN",
      "pt": "ESCANEAR COMIDA",
      "it": "SCANSIONA CIBO",
      "id": "PINDAI MAKANAN"
    },
    "log_glucose": {
      "en": "LOG GLUCOSE",
      "vi": "GHI NHẬT KÝ ĐƯỜNG HUYẾT",
      "ja": "血糖値を記録",
      "ar": "تسجيل الجلوكوز",
      "hi": "ग्लूकोज लॉग करें",
      "th": "บันทึกกลูโคส",
      "es": "REGISTRAR GLUCOSA",
      "ko": "혈당 기록",
      "zh_Hans": "记录血糖",
      "fr": "ENREGISTRER LE GLUCOSE",
      "tr": "GLIKOZ KAYDI",
      "ru": "ЗАПИСАТЬ ГЛЮКОЗУ",
      "de": "GLUKOSE PROTOKOLLIEREN",
      "pt": "REGISTRAR GLICOSE",
      "it": "REGISTRA GLUCOSIO",
      "id": "CATAT GLUKOSA"
    },
    "log_vitals": {
      "en": "LOG VITALS",
      "vi": "GHI CHỈ SỐ SINH TỒN",
      "ja": "バイタルを記録",
      "ar": "تسجيل العلامات الحيوية",
      "hi": "वाइटल्स लॉग करें",
      "th": "บันทึกสัญญาณชีพ",
      "es": "REGISTRAR SIGNOS VITALES",
      "ko": "바이탈 기록",
      "zh_Hans": "记录生命体征",
      "fr": "ENREGISTRER LES SIGNES VITAUX",
      "tr": "HAYATİ DEĞERLERİ KAYDET",
      "ru": "ЗАПИСАТЬ ЖИЗНЕННЫЕ ПОКАЗАТЕЛИ",
      "de": "VITALWERTE PROTOKOLLIEREN",
      "pt": "REGISTRAR SINAIS VITAIS",
      "it": "REGISTRA PARAMETRI VITALI",
      "id": "CATAT TANDA VITAL"
    },
    "log_activity": {
      "en": "LOG ACTIVITY",
      "vi": "NHẬT KÝ HOẠT ĐỘNG",
      "ja": "アクティビティ記録",
      "ar": "سِجِلّ النَّشَاط",
      "hi": "गतिविधि लॉग",
      "th": "บันทึกกิจกรรม",
      "es": "REGISTRO DE ACTIVIDAD",
      "ko": "활동 기록",
      "zh_Hans": "活动记录",
      "fr": "JOURNAL D’ACTIVITÉ",
      "tr": "AKTİVİTE GÜNLÜĞÜ",
      "ru": "ЖУРНАЛ АКТИВНОСТИ",
      "de": "AKTIVITÄTSPROTOKOLL",
      "pt": "REGISTRO DE ATIVIDADE",
      "it": "REGISTRO ATTIVITÀ",
      "id": "CATATAN AKTIVITAS"
    },
    "camera": {
      "en": "CAMERA",
      "vi": "MÁY ẢNH",
      "ja": "カメラ",
      "ar": "الكاميرا",
      "hi": "कैमरा",
      "th": "กล้อง",
      "es": "CÁMARA",
      "ko": "카메라",
      "zh_Hans": "相机",
      "fr": "CAMÉRA",
      "tr": "KAMERA",
      "ru": "КАМЕРА",
      "de": "KAMERA",
      "pt": "CÂMERA",
      "it": "FOTOCAMERA",
      "id": "KAMERA"
    },
    "recent": {
      "en": "RECENT",
      "vi": "GẦN ĐÂY",
      "ja": "最近",
      "ar": "الأخيرة",
      "hi": "हाल ही में",
      "th": "ล่าสุด",
      "es": "RECIENTE",
      "ko": "최근",
      "zh_Hans": "最近",
      "fr": "RÉCENT",
      "tr": "SON",
      "ru": "НЕДАВНИЕ",
      "de": "KÜRZLICH",
      "pt": "RECENTE",
      "it": "RECENTE",
      "id": "TERBARU"
    },
    "text": {
      "en": "TEXT",
      "vi": "VĂN BẢN",
      "ja": "テキスト",
      "ar": "نص",
      "hi": "पाठ",
      "th": "ข้อความ",
      "es": "TEXTO",
      "ko": "텍스트",
      "zh_Hans": "文本",
      "fr": "TEXTE",
      "tr": "METİN",
      "ru": "ТЕКСТ",
      "de": "TEXT",
      "pt": "TEXTO",
      "it": "TESTO",
      "id": "TEKS"
    },
    "ready_to_snap_your_meal": {
      "en": "Ready to snap your meal?",
      "vi": "Sẵn sàng chụp bữa ăn của bạn?",
      "ja": "食事を撮影する準備はできましたか？",
      "ar": "هل أنت مستعد لالتقاط صورة لوجبتك؟",
      "hi": "क्या आप अपने भोजन की तस्वीर लेने के लिए तैयार हैं?",
      "th": "พร้อมถ่ายรูปอาหารของคุณหรือยัง?",
      "es": "¿Listo para tomar una foto de tu comida?",
      "ko": "식사 사진을 찍을 준비가 되셨나요?",
      "zh_Hans": "准备好拍下你的餐食了吗？",
      "fr": "Prêt à prendre en photo votre repas ?",
      "tr": "Yemeğinizin fotoğrafını çekmeye hazır mısınız?",
      "ru": "Готовы сфотографировать свою еду?",
      "de": "Bereit, dein Essen zu fotografieren?",
      "pt": "Pronto para tirar uma foto da sua refeição?",
      "it": "Pronto a scattare una foto al tuo pasto?",
      "id": "Siap memotret makananmu?"
    },
    "gallery": {
      "en": "GALLERY",
      "vi": "THƯ VIỆN",
      "ja": "ギャラリー",
      "ar": "المعرض",
      "hi": "गैलरी",
      "th": "แกลเลอรี",
      "es": "GALERÍA",
      "ko": "갤러리",
      "zh_Hans": "图库",
      "fr": "GALERIE",
      "tr": "GALERİ",
      "ru": "ГАЛЕРЕЯ",
      "de": "GALERIE",
      "pt": "GALERIA",
      "it": "GALLERIA",
      "id": "GALERI"
    },
    "retake": {
      "en": "RETAKE",
      "vi": "CHỤP LẠI",
      "ja": "再撮影",
      "ar": "إعادة الالتقاط",
      "hi": "फिर से लें",
      "th": "ถ่ายใหม่",
      "es": "VOLVER A TOMAR",
      "ko": "다시 촬영",
      "zh_Hans": "重新拍摄",
      "fr": "REPRENDRE",
      "tr": "TEKRAR ÇEK",
      "ru": "ПЕРЕСНЯТЬ",
      "de": "ERNEUT AUFNEHMEN",
      "pt": "TIRAR NOVAMENTE",
      "it": "SCATTA DI NUOVO",
      "id": "AMBIL ULANG"
    },
    "process_image": {
      "en": "Process Image",
      "vi": "Xử lý hình ảnh",
      "ja": "画像を処理",
      "ar": "معالجة الصورة",
      "hi": "छवि संसाधित करें",
      "th": "ประมวลผลภาพ",
      "es": "Procesar imagen",
      "ko": "이미지 처리",
      "zh_Hans": "处理图像",
      "fr": "Traiter l'image",
      "tr": "Görüntüyü işle",
      "ru": "Обработать изображение",
      "de": "Bild verarbeiten",
      "pt": "Processar imagem",
      "it": "Elabora immagine",
      "id": "Proses gambar"
    },
    "agree_to_terms_prefix": {
      "en": "By continuing, you agree to our",
      "vi": "Bằng cách tiếp tục, bạn đồng ý với",
      "ja": "続行することで、以下に同意したことになります",
      "ar": "بمتابعتك، فإنك توافق على",
      "hi": "जारी रखकर, आप हमारी शर्तों से सहमत होते हैं",
      "th": "เมื่อดำเนินการต่อ คุณยอมรับ",
      "es": "Al continuar, aceptas nuestros",
      "ko": "계속 진행하면 다음에 동의하게 됩니다",
      "zh_Hans": "继续即表示您同意我们的",
      "fr": "En continuant, vous acceptez nos",
      "tr": "Devam ederek şunları kabul etmiş olursunuz",
      "ru": "Продолжая, вы соглашаетесь с нашими",
      "de": "Durch Fortfahren stimmen Sie unseren",
      "pt": "Ao continuar, você concorda com nossos",
      "it": "Continuando, accetti i nostri",
      "id": "Dengan melanjutkan, Anda menyetujui"
    },
    "terms_of_service": {
      "en": "Terms of Service",
      "vi": "Điều khoản dịch vụ",
      "ja": "利用規約",
      "ar": "شروط الخدمة",
      "hi": "सेवा की शर्तें",
      "th": "ข้อกำหนดการให้บริการ",
      "es": "Términos de servicio",
      "ko": "서비스 약관",
      "zh_Hans": "服务条款",
      "fr": "Conditions d'utilisation",
      "tr": "Hizmet şartları",
      "ru": "Условия обслуживания",
      "de": "Nutzungsbedingungen",
      "pt": "Termos de serviço",
      "it": "Termini di servizio",
      "id": "Ketentuan layanan"
    },
    "privacy_policy": {
      "en": "Privacy Policy",
      "vi": "Chính Sách Quyền Riêng Tư",
      "ja": "プライバシーポリシー",
      "ar": "سياسة الخصوصية",
      "hi": "गोपनीयता नीति",
      "th": "นโยบายความเป็นส่วนตัว",
      "es": "Política De Privacidad",
      "ko": "개인정보 처리방침",
      "zh_Hans": "隐私政策",
      "fr": "Politique De Confidentialité",
      "tr": "Gizlilik Politikası",
      "ru": "Политика Конфиденциальности",
      "de": "Datenschutzrichtlinie",
      "pt": "Política De Privacidade",
      "it": "Informativa Sulla Privacy",
      "id": "Kebijakan Privasi"
    },
    "and": {
      "en": "and",
      "vi": "và",
      "ja": "と",
      "ar": "و",
      "hi": "और",
      "th": "และ",
      "es": "y",
      "ko": "및",
      "zh_Hans": "和",
      "fr": "et",
      "tr": "ve",
      "ru": "и",
      "de": "und",
      "pt": "e",
      "it": "e",
      "id": "dan"
    },
    "low_glycemic": {
      "en": "LOW GLYCEMIC",
      "vi": "CHỈ SỐ ĐƯỜNG HUYẾT THẤP",
      "ja": "低グリセミック",
      "ar": "مؤشر جلايسيمي منخفض",
      "hi": "कम ग्लाइसेमिक",
      "th": "ดัชนีน้ำตาลต่ำ",
      "es": "ÍNDICE GLUCÉMICO BAJO",
      "ko": "저혈당 지수",
      "zh_Hans": "低升糖指数",
      "fr": "INDICE GLYCÉMIQUE BAS",
      "tr": "DÜŞÜK GLİSEMİK",
      "ru": "НИЗКИЙ ГЛИКЕМИЧЕСКИЙ ИНДЕКС",
      "de": "NIEDRIGER GLYKÄMISCHER INDEX",
      "pt": "BAIXO ÍNDICE GLICÊMICO",
      "it": "BASSO INDICE GLICEMICO",
      "id": "INDEKS GLIKEMIK RENDAH"
    },
    "medium_glycemic": {
      "en": "MEDIUM GLYCEMIC",
      "vi": "CHỈ SỐ ĐƯỜNG HUYẾT TRUNG BÌNH",
      "ja": "中程度のグリセミック",
      "ar": "مؤشر سكري متوسط",
      "hi": "मध्यम ग्लाइसेमिक",
      "th": "ดัชนีน้ำตาลปานกลาง",
      "es": "GLUCÉMICO MEDIO",
      "ko": "중간 혈당 지수",
      "zh_Hans": "中等血糖指数",
      "fr": "INDICE GLYCÉMIQUE MOYEN",
      "tr": "ORTA GLISEMIK",
      "ru": "СРЕДНИЙ ГЛИКЕМИЧЕСКИЙ ИНДЕКС",
      "de": "MITTLERER GLYKÄMISCHER INDEX",
      "pt": "ÍNDICE GLICÊMICO MÉDIO",
      "it": "INDICE GLICEMICO MEDIO",
      "id": "INDEKS GLIKEMIK SEDANG"
    },
    "high_glycemic": {
      "en": "HIGH GLYCEMIC",
      "vi": "CHỈ SỐ ĐƯỜNG HUYẾT CAO",
      "ja": "高グリセミック",
      "ar": "مؤشر سكري مرتفع",
      "hi": "उच्च ग्लाइसेमिक",
      "th": "ดัชนีน้ำตาลสูง",
      "es": "ÍNDICE GLUCÉMICO ALTO",
      "ko": "높은 혈당 지수",
      "zh_Hans": "高升糖指数",
      "fr": "INDICE GLYCÉMIQUE ÉLEVÉ",
      "tr": "YÜKSEK GLİSEMİK",
      "ru": "ВЫСОКИЙ ГЛИКЕМИЧЕСКИЙ ИНДЕКС",
      "de": "HOHER GLYKÄMISCHER INDEX",
      "pt": "ALTO ÍNDICE GLICÊMICO",
      "it": "ALTO INDICE GLICEMICO",
      "id": "INDEKS GLIKEMIK TINGGI"
    },
    "excellent": {
      "en": "EXCELLENT",
      "vi": "XUẤT SẮC",
      "ja": "優秀",
      "ar": "ممتاز",
      "hi": "उत्कृष्ट",
      "th": "ยอดเยี่ยม",
      "es": "EXCELENTE",
      "ko": "훌륭함",
      "zh_Hans": "优秀",
      "fr": "EXCELLENT",
      "tr": "MÜKEMMEL",
      "ru": "ОТЛИЧНО",
      "de": "AUSGEZEICHNET",
      "pt": "EXCELENTE",
      "it": "ECCELLENTE",
      "id": "LUAR BIASA"
    },
    "caution": {
      "en": "CAUTION",
      "vi": "CẢNH BÁO",
      "ja": "注意",
      "ar": "تحذير",
      "hi": "सावधानी",
      "th": "คำเตือน",
      "es": "PRECAUCIÓN",
      "ko": "주의",
      "zh_Hans": "注意",
      "fr": "PRUDENCE",
      "tr": "DİKKAT",
      "ru": "ОСТОРОЖНО",
      "de": "VORSICHT",
      "pt": "CUIDADO",
      "it": "ATTENZIONE",
      "id": "PERINGATAN"
    },
    "high_risk": {
      "en": "HIGH RISK",
      "vi": "NGUY CƠ CAO",
      "ja": "高リスク",
      "ar": "خطر مرتفع",
      "hi": "उच्च जोखिम",
      "th": "ความเสี่ยงสูง",
      "es": "ALTO RIESGO",
      "ko": "높은 위험",
      "zh_Hans": "高风险",
      "fr": "RISQUE ÉLEVÉ",
      "tr": "YÜKSEK RISK",
      "ru": "ВЫСОКИЙ РИСК",
      "de": "HOHES RISIKO",
      "pt": "ALTO RISCO",
      "it": "ALTO RISCHIO",
      "id": "RISIKO TINGGI"
    },
    "analyzing_your_meal": {
      "en": "Analyzing your meal...",
      "vi": "Đang phân tích bữa ăn của bạn...",
      "ja": "あなたの食事を分析しています...",
      "ar": "جارٍ تحليل وجبتك...",
      "hi": "आपके भोजन का विश्लेषण किया जा रहा है...",
      "th": "กำลังวิเคราะห์มื้ออาหารของคุณ...",
      "es": "Analizando tu comida...",
      "ko": "식사를 분석하는 중...",
      "zh_Hans": "正在分析您的餐食...",
      "fr": "Analyse de votre repas...",
      "tr": "Yemeğiniz analiz ediliyor...",
      "ru": "Анализируем ваш прием пищи...",
      "de": "Ihre Mahlzeit wird analysiert...",
      "pt": "Analisando sua refeição...",
      "it": "Analisi del tuo pasto...",
      "id": "Menganalisis makanan Anda..."
    },
    "calculating_macros_and_safety_scores": {
      "en": "Calculating macros and safety scores...",
      "vi": "Đang tính toán macro và điểm an toàn...",
      "ja": "マクロと安全スコアを計算しています...",
      "ar": "جارٍ حساب الماكروز ودرجات الأمان...",
      "hi": "मैक्रो और सुरक्षा स्कोर की गणना की जा रही है...",
      "th": "กำลังคำนวณมาโครและคะแนนความปลอดภัย...",
      "es": "Calculando macros y puntuaciones de seguridad...",
      "ko": "매크로와 안전 점수를 계산하는 중...",
      "zh_Hans": "正在计算宏量营养和安全评分...",
      "fr": "Calcul des macros et des scores de sécurité...",
      "tr": "Makrolar ve güvenlik puanları hesaplanıyor...",
      "ru": "Расчет макросов и показателей безопасности...",
      "de": "Makros und Sicherheitsbewertungen werden berechnet...",
      "pt": "Calculando macros e pontuações de segurança...",
      "it": "Calcolo dei macro e dei punteggi di sicurezza...",
      "id": "Menghitung makro dan skor keamanan..."
    },
    "portion_size": {
      "en": "Portion Size",
      "vi": "Khẩu phần ăn",
      "ja": "ポーションサイズ",
      "ar": "حجم الحصة",
      "hi": "परोसने का आकार",
      "th": "ขนาดส่วนอาหาร",
      "es": "Tamaño de la porción",
      "ko": "1회 제공량",
      "zh_Hans": "份量大小",
      "fr": "Taille de portion",
      "tr": "Porsiyon Boyutu",
      "ru": "Размер порции",
      "de": "Portionsgröße",
      "pt": "Tamanho da porção",
      "it": "Dimensione della porzione",
      "id": "Ukuran porsi"
    },
    "diabetic_insights": {
      "en": "Diabetic Insights",
      "vi": "Thông Tin Tiểu Đường",
      "ja": "糖尿病インサイト",
      "ar": "رؤى مرض السكري",
      "hi": "मधुमेह अंतर्दृष्टि",
      "th": "ข้อมูลเชิงลึกโรคเบาหวาน",
      "es": "Información Sobre Diabetes",
      "ko": "당뇨병 인사이트",
      "zh_Hans": "糖尿病洞察",
      "fr": "Aperçus Sur Le Diabète",
      "tr": "Diyabet İçgörüleri",
      "ru": "Аналитика Диабета",
      "de": "Diabetes Erkenntnisse",
      "pt": "Insights Sobre Diabetes",
      "it": "Approfondimenti Sul Diabete",
      "id": "Wawasan Diabetes"
    },
    "cancel": {
      "en": "Cancel",
      "vi": "Hủy",
      "ja": "キャンセル",
      "ar": "إلغاء",
      "hi": "रद्द करें",
      "th": "ยกเลิก",
      "es": "Cancelar",
      "ko": "취소",
      "zh_Hans": "取消",
      "fr": "Annuler",
      "tr": "İptal",
      "ru": "Отмена",
      "de": "Abbrechen",
      "pt": "Cancelar",
      "it": "Annulla",
      "id": "Batal"
    },
    "discard": {
      "en": "Discard",
      "vi": "Hủy bỏ",
      "ja": "破棄",
      "ar": "تجاهل",
      "hi": "त्यागें",
      "th": "ยกเลิก",
      "es": "Descartar",
      "ko": "삭제",
      "zh_Hans": "丢弃",
      "fr": "Ignorer",
      "tr": "Vazgeç",
      "ru": "Отменить",
      "de": "Verwerfen",
      "pt": "Descartar",
      "it": "Scarta",
      "id": "Buang"
    },
    "log_this_meal": {
      "en": "Log This Meal",
      "vi": "Ghi Lại Bữa Ăn Này",
      "ja": "この食事を記録",
      "ar": "تسجيل هذه الوجبة",
      "hi": "इस भोजन को लॉग करें",
      "th": "บันทึกมื้อนี้",
      "es": "Registrar Esta Comida",
      "ko": "이 식사 기록하기",
      "zh_Hans": "记录此餐",
      "fr": "Enregistrer Ce Repas",
      "tr": "Bu Öğünü Kaydet",
      "ru": "Записать Этот Прием Пищи",
      "de": "Diese Mahlzeit Protokollieren",
      "pt": "Registrar Esta Refeição",
      "it": "Registra Questo Pasto",
      "id": "Catat Makanan Ini"
    }
  };

  // Find the translation map for the given text (exact match)
  final translationMap = translations[cleanedKey];

  // Return the translation if available
  if (translationMap != null && translationMap.containsKey(cleanedLang)) {
    // print("✅ Hardcoded translation found: [$cleanedLang][$cleanedKey]");
    return translationMap[cleanedLang];
  }

  // Try English fallback from hardcoded translations
  if (cleanedLang != 'en' &&
      translationMap != null &&
      translationMap.containsKey('en')) {
    // print("✅ Hardcoded English fallback for: $cleanedKey");
    return translationMap['en'];
  }

  // ============================================
  // STEP 3: No translation found - return original text
  // ============================================
  // print("❌ No translation found for: [$cleanedLang][$cleanedKey] - returning original text");
  return text;
}

String? convertImage(String? userImg) {
  return userImg;
}

/// 0=createdattime
/// 1=time only
String? utcTimeConvert(
  DateTime? dateTime,
  int? type,
) {
  String newDateTime = dateTime!.toUtc().toUtc().toString();

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  return type == 0
      ? newDateTime
      : '${_twoDigits(dateTime.copyWith(isUtc: false).toUtc().hour)}:${_twoDigits(dateTime.copyWith(isUtc: false).toUtc().minute)}';
}

/// callType=0=original color
/// callType=1= color opacity 10
Color? returnProgressColor(
  String? foodStatus,
  List<InfoStruct>? configColorListDiabInsight,
  int? callType,
) {
  Color baseColor = const Color(0xFF10B981);

  if (foodStatus != null && configColorListDiabInsight != null) {
    for (final item in configColorListDiabInsight) {
      if (item.title.toLowerCase() == foodStatus.toLowerCase()) {
        final colorString = item.color ?? '';

        if (colorString.startsWith('0x')) {
          baseColor = Color(int.parse(colorString));
          break;
        }
      }
    }
  }

  if (callType == 1) {
    return baseColor.withOpacity(0.1);
  }

  return baseColor;
}

double? diabProgreeabar(int? daibScore) {
  if (daibScore == null) return 0;

  return (daibScore / 130).clamp(0.0, 1.0);
}

String? twoDayAgoDate() {
  return DateFormat('MMM dd')
      .format(DateTime.now().subtract(const Duration(days: 2)));
}

MealStruct? portionSizeNutritionCal(
  MealStruct? mealInfo,
  double? portionSize,
) {
  if (mealInfo == null || portionSize == null) return mealInfo;

  MealStruct updatedMeal = MealStruct.fromMap(mealInfo.toMap());

  updatedMeal.calories = (mealInfo.calories * portionSize).round();
  updatedMeal.protein = (mealInfo.protein * portionSize).round();
  updatedMeal.carbs = (mealInfo.carbs * portionSize).round();
  updatedMeal.fat = (mealInfo.fat * portionSize).round();
  updatedMeal.sugar = (mealInfo.sugar * portionSize).round();

  return updatedMeal;
}

MealStruct? returnActualPotionSize(
  MealStruct? mealInfo,
  double? portionSize,
) {
  if (mealInfo == null || portionSize == null || portionSize == 0) {
    return mealInfo;
  }

  double factor = 1 / portionSize;

  int scale(num value) => (value * factor).round();

  MealStruct updatedMeal = MealStruct.fromMap(mealInfo.toMap());

  updatedMeal.protein = scale(mealInfo.protein);
  updatedMeal.carbs = scale(mealInfo.carbs);
  updatedMeal.sugar = scale(mealInfo.sugar);
  updatedMeal.fat = scale(mealInfo.fat);
  updatedMeal.calories = scale(mealInfo.calories);

  return updatedMeal;
}

String? formatDateTime(
  String? dataBaseTime,
  int? calltype,
) {
// calltype==0	Oct 13, 07:30 PM
// calltype==1	8:30 AM
  if (dataBaseTime == null || dataBaseTime.isEmpty) return null;

  DateTime utcTime = DateTime.parse(dataBaseTime);
  DateTime localTime = utcTime.toLocal();

  DateTime now = DateTime.now();
  DateTime yesterday = now.subtract(const Duration(days: 1));

  // format time
  int hour = localTime.hour;
  String period = hour >= 12 ? 'PM' : 'AM';

  if (hour > 12) hour -= 12;
  if (hour == 0) hour = 12;

  String minute = localTime.minute.toString().padLeft(2, '0');
  String time = "$hour:$minute $period";

  // If only time required
  if (calltype == 1) {
    return time;
  }

  bool isToday = localTime.year == now.year &&
      localTime.month == now.month &&
      localTime.day == now.day;

  bool isYesterday = localTime.year == yesterday.year &&
      localTime.month == yesterday.month &&
      localTime.day == yesterday.day;

  if (isToday) {
    return "Today, $time";
  } else if (isYesterday) {
    return "Yesterday, $time";
  } else {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    String month = months[localTime.month - 1];
    return "$month ${localTime.day}, $time";
  }
}

List<MealStruct>? filterMeal(List<MealStruct>? mealInformation) {
  if (mealInformation == null || mealInformation.isEmpty)
    return mealInformation;

  DateTime now = DateTime.now();

  return mealInformation.where((meal) {
    if (!meal.hasMealDate()) return false;

    DateTime utcTime = DateTime.parse(meal.mealDate);
    DateTime localTime = utcTime.toLocal();

    return localTime.year == now.year &&
        localTime.month == now.month &&
        localTime.day == now.day;
  }).toList();
}
