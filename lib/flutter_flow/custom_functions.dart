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

/// 0== height calling
/// 1== weight calling
String? converHeightWeight(
  int? type,
  int? info,
  int? callType,
) {
  if (info == null) return '';

  // HEIGHT
  if (callType == 0) {
    // type == 1 → cm
    if (type == 1) {
      return "$info cm";
    }

    // type == 0 → ft/in
    if (type == 0) {
      final double inches = info / 2.54;
      final int feet = inches ~/ 12;
      final int inch = (inches % 12).round();
      return "$feet' $inch\"";
    }
  }

  // WEIGHT
  if (callType == 1) {
    // type == 1 → kg
    if (type == 1) {
      final double kg = info / 1000;
      return "${kg.toStringAsFixed(0)} kg";
    }

    // type == 0 → lbs
    if (type == 0) {
      final double lbs = info * 0.00220462;
      return "${lbs.toStringAsFixed(0)} lbs";
    }
  }

  return '';
}

int? ageCalculate(
  String? birthDate,
  int currentage,
) {
  if (birthDate == null) return currentage;
  try {
    final date = DateTime.parse(birthDate); // "yyyy-MM-dd"
    final today = DateTime.now();
    int age = today.year - date.year;
    if (today.month < date.month ||
        (today.month == date.month && today.day < date.day)) {
      age--;
    }
    return age;
  } catch (e) {
    return currentage;
  }
}

/// 0=createdattime
/// 1=time only
String? utcTimeConvert(
  DateTime? dateTime,
  int? type,
  String? date,
) {
  if (dateTime == null) return null;

  // type 0 → normal UTC conversion
  if (type == 0) {
    return dateTime.toUtc().toIso8601String();
  }

  // type 1 → date + time → UTC
  if (type == 1) {
    if (date == null || date.isEmpty) return null;

    int year, month, day;

    // yyyy-MM-dd
    if (date.contains('-')) {
      final parts = date.split('-');
      if (parts.length != 3) return null;

      year = int.parse(parts[0]);
      month = int.parse(parts[1]);
      day = int.parse(parts[2]);
    }
    // dd/MM/yyyy
    else if (date.contains('/')) {
      final parts = date.split('/');
      if (parts.length != 3) return null;

      day = int.parse(parts[0]);
      month = int.parse(parts[1]);
      year = int.parse(parts[2]);
    } else {
      return null;
    }

    final combinedLocal = DateTime(
      year,
      month,
      day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
      dateTime.millisecond,
    );

    return combinedLocal.toUtc().toIso8601String();
  }

  return null;
}

/// callType=0 original
/// callType =1 new stauts
BloodInfoStruct? oxygenColorStatus(
  BloodInfoStruct? currentVal,
  int? callType,
) {
  final int spO2 = currentVal!.spo2;
  if (callType == 0) {
    if (spO2 >= 95 && spO2 <= 100) {
      currentVal
        ..sugarState = "Normal"
        ..color = const Color(0xFF4CAF50); // Green
    } else if (spO2 >= 91 && spO2 <= 94) {
      currentVal
        ..sugarState = "Mild Hypoxemia"
        ..color = const Color(0xFFFDD782); // Yellow
    } else if (spO2 >= 80 && spO2 <= 90) {
      currentVal
        ..sugarState = "Moderate Hypoxemia"
        ..color = const Color(0xFFFBAA47); // Orange
    } else {
      currentVal
        ..sugarState = "Severe Hypoxemia"
        ..color = const Color(0xFFE74C3C); // Red
    }
  } else {
    if (spO2 >= 91) {
      currentVal
        ..sugarState = "Good"
        ..color = const Color(0xFF4CAF50); // Green
    } else if (spO2 >= 90) {
      currentVal
        ..sugarState = "Normal"
        ..color = const Color(0xFFFDD782); // Yellow
    } else if (spO2 >= 80) {
      currentVal
        ..sugarState = "Normal"
        ..color = const Color(0xFFFBAA47); // Orange
    } else {
      currentVal
        ..sugarState = "Low"
        ..color = const Color(0xFFE74C3C); // Red
    }
  }

  return currentVal;
}

/// callType=0 original
/// callType =1 new stauts
BloodInfoStruct? pressureColorStatus(
  BloodInfoStruct? currentVal,
  int? callType,
) {
  if (currentVal == null ||
      !currentVal.hasSystolic() ||
      !currentVal.hasDiastolic()) {
    return currentVal;
  }

  final int sys = currentVal.systolic;
  final int dia = currentVal.diastolic;

  // ==================================================
  // callType = 1 → DEVICE MODE (Low / Medium / High)
  // ==================================================
  if (callType == 1) {
    if (sys <= 89 && dia <= 59) {
      currentVal
        ..sugarState = "Low"
        ..color = const Color(0xFF3B82F6); // Purple
    } else if ((sys >= 90 && sys <= 139) || (dia >= 60 && dia <= 89)) {
      currentVal
        ..sugarState = "Good"
        ..color = const Color(0xFF2DCC3A); // Blue
    } else {
      currentVal
        ..sugarState = "High"
        ..color = const Color(0xFFE74C3C); // Red
    }

    return currentVal;
  }

  // ==================================================
  // callType = 0 → STANDARD BP MEDICAL CATEGORIES
  // ==================================================
  if (callType == 0) {
    // Hypotension
    if (sys <= 89 && dia <= 59) {
      currentVal
        ..sugarState = "Hypotension"
        ..color = const Color(0xFFB29EF9); // Purple
    }
    // Normal
    else if (sys >= 90 && sys <= 129 && dia >= 60 && dia <= 84) {
      currentVal
        ..sugarState = "Normal"
        ..color = const Color(0xFF3B82F6); // Blue
    }
    // Grade 1
    else if (sys >= 130 && sys <= 139 && dia >= 85 && dia <= 89) {
      currentVal
        ..sugarState = "Grade 1"
        ..color = const Color(0xFFFDD782); // Yellow
    }
    // Grade 2
    else if (sys >= 140 && sys <= 159 && dia >= 90 && dia <= 99) {
      currentVal
        ..sugarState = "Grade 2"
        ..color = const Color(0xFFFBAA47); // Orange
    }
    // Grade 3
    else if (sys >= 160 && sys <= 179 && dia >= 100 && dia <= 109) {
      currentVal
        ..sugarState = "Grade 3"
        ..color = const Color(0xFFF96B30); // Deep Orange
    }
    // Grade 4 Hypertension
    else if (sys >= 180 || dia >= 110) {
      currentVal
        ..sugarState = "Grade 4 Hypertension"
        ..color = const Color(0xFFE74C3C); // Red
    }
    // Fallback
    else {
      currentVal
        ..sugarState = "Unknown"
        ..color = const Color(0xFF9CA3AF); // Grey
    }

    return currentVal;
  }

  return currentVal;
}

BloodInfoStruct? returnLocalDateTime(BloodInfoStruct? currentBloddInfo) {
  if (currentBloddInfo == null || !currentBloddInfo.hasTime()) {
    return currentBloddInfo;
  }

  try {
    // Parse UTC time string
    final DateTime utcDateTime = DateTime.parse(currentBloddInfo.time).toUtc();

    // Convert to local time
    final DateTime localDateTime = utcDateTime.toLocal();

    // Format date → Jan 30
    final String formattedDate = DateFormat('MMM dd').format(localDateTime);

    // Format time → HH:mm (24h local)
    final String formattedTime = DateFormat('HH:mm').format(localDateTime);

    currentBloddInfo
      ..date = formattedDate
      ..time = formattedTime;

    return currentBloddInfo;
  } catch (e) {
    // If parsing fails, return original object safely
    return currentBloddInfo;
  }
}

/// calltype = 0 = max info
/// calltype = 2= last info
/// calltype = 1 = avg of oxygen
int? oxygenLastAvg(
  List<BloodInfoStruct>? oxyGenInfoAll,
  int? calltype,
) {
  if (oxyGenInfoAll == null || oxyGenInfoAll.isEmpty) return 0;

  // Extract valid SpO₂ values
  final List<int> spo2List = oxyGenInfoAll
      .where((e) => e.hasSpo2() && e.spo2 > 0)
      .map((e) => e.spo2)
      .toList();

  if (spo2List.isEmpty) return 0;

  // 0 = MAX SpO₂
  if (calltype == 0) {
    return spo2List.reduce((a, b) => a > b ? a : b);
  }

  if (calltype == 2) {
    return spo2List.last;
  }

  // 1 = AVG SpO₂
  if (calltype == 1) {
    final int sum = spo2List.reduce((a, b) => a + b);
    return (sum / spo2List.length).round();
  }

  return 0;
}

/// calltype=0= maximum
/// calltype=1= avage
BloodInfoStruct? pressureLastAvg(
  List<BloodInfoStruct>? bloodInfo,
  int? calltype,
) {
  if (bloodInfo == null || bloodInfo.isEmpty) return null;

  int maxSystolic = 0;
  int maxDiastolic = 0;

  int sumSystolic = 0;
  int sumDiastolic = 0;

  int validCount = 0;

  for (final item in bloodInfo) {
    if (!item.hasSystolic() || !item.hasDiastolic()) continue;

    final int sys = item.systolic;
    final int dia = item.diastolic;

    // For MAX
    if (sys > maxSystolic) maxSystolic = sys;
    if (dia > maxDiastolic) maxDiastolic = dia;

    // For AVG
    sumSystolic += sys;
    sumDiastolic += dia;
    validCount++;
  }

  if (validCount == 0) return null;

  if (calltype == 0) {
    // MAX
    return createBloodInfoStruct(
      systolic: maxSystolic,
      diastolic: maxDiastolic,
    );
  } else {
    // AVG
    return createBloodInfoStruct(
      systolic: (sumSystolic / validCount).round(),
      diastolic: (sumDiastolic / validCount).round(),
    );
  }
}

List<DateBoolTrackRecordsStruct>? filterDatebyBloodInfo(
    List<BloodInfoStruct>? booldInfo) {
  if (booldInfo == null || booldInfo.isEmpty) return [];

  final Map<String, List<BloodInfoStruct>> groupedMap = {};

  final DateTime now = DateTime.now();
  final DateTime today = DateTime(now.year, now.month, now.day);

  for (final item in booldInfo) {
    if (item.date.isEmpty || item.time.isEmpty) continue;

    // 1️⃣ Parse "Jan 27" + "11:14"
    final DateTime? recordDateTime = parseDateAndTime(item.date, item.time);

    if (recordDateTime == null) continue;

    // 2️⃣ Normalize date (remove time)
    final DateTime recordDate = DateTime(
      recordDateTime.year,
      recordDateTime.month,
      recordDateTime.day,
    );

    // 3️⃣ Format MM/dd/yyyy
    final String formattedDate =
        '${recordDate.month.toString().padLeft(2, '0')}/'
        '${recordDate.day.toString().padLeft(2, '0')}/'
        '${recordDate.year}';

    // 4️⃣ Today logic
    final String groupKey = recordDate == today ? 'Today' : formattedDate;

    groupedMap.putIfAbsent(groupKey, () => []);
    groupedMap[groupKey]!.add(item);
  }

  return groupedMap.entries.map((e) {
    return DateBoolTrackRecordsStruct(
      date: e.key,
      bloodInfo: e.value,
    );
  }).toList();
}

DateTime? parseDateAndTime(
  String? date,
  String? time,
) {
  try {
    final dateParts = date!.split(' ');
    if (dateParts.length != 2) return null;

    final monthMap = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12,
    };

    final int? month = monthMap[dateParts[0]];
    final int day = int.parse(dateParts[1]);

    if (month == null) return null;

    final timeParts = time!.split(':');
    final int hour = int.parse(timeParts[0]);
    final int minute = int.parse(timeParts[1]);

    final int year = DateTime.now().year;

    return DateTime(year, month, day, hour, minute);
  } catch (_) {
    return null;
  }
}

/// callType = 0 = mgdl
/// callType = 1 = mmol
BloodInfoStruct? convertSugarVal(
  int? mgDlVal,
  double? mmol,
  int? callType,
) {
  if (callType != 0 && callType != 1) return null;

  // mg/dL → mmol/L
  if (callType == 0) {
    if (mgDlVal == null || mgDlVal <= 0) return null;

    return createBloodInfoStruct(
      mgDl: mgDlVal,
      mmoiL: double.parse((mgDlVal / 18.0).toStringAsFixed(1)),
    );
  }

  // mmol/L → mg/dL
  if (mmol == null || mmol <= 0) return null;

  return createBloodInfoStruct(
    mmoiL: mmol,
    mgDl: (mmol * 18.0).round(),
  );
}

BloodInfoStruct? bloodSugarColorStatus(BloodInfoStruct? sugarInfo) {
  if (sugarInfo == null) return null;

  final int value = sugarInfo.mgDl;

  if (value <= 69) {
    sugarInfo
      ..sugarState = 'Hypoglycemia'
      ..color = const Color(0xFF2196F3);
  } else if (value <= 99) {
    sugarInfo
      ..sugarState = 'Normal'
      ..color = const Color(0xFF4CAF50);
  } else if (value <= 125) {
    sugarInfo
      ..sugarState = 'Prediabetes'
      ..color = const Color(0xFFFFA500);
  } else {
    sugarInfo
      ..sugarState = 'Diabetes'
      ..color = const Color(0xFFE53935);
  }

  return sugarInfo;
}

/// callType = 1 = avg
/// callType =0= maximum
BloodInfoStruct? sugarAvg(
  List<BloodInfoStruct>? sugarInfo,
  int? callType,
) {
  if (sugarInfo == null || sugarInfo.isEmpty) {
    return null;
  }

  // Keep only valid mg/dL entries
  final valid = sugarInfo.where((e) => e.hasMgDl() && e.mgDl > 0).toList();

  if (valid.isEmpty) {
    return null;
  }

  // -------------------------
  // MAX MODE
  // -------------------------
  if (callType == 0) {
    BloodInfoStruct maxItem = valid.first;

    for (final e in valid) {
      if (e.mgDl > maxItem.mgDl) {
        maxItem = e;
      }
    }

    return createBloodInfoStruct(
      mgDl: maxItem.mgDl,
    );
  }

  // -------------------------
  // AVG MODE (default)
  // -------------------------
  int total = 0;

  for (final e in valid) {
    total += e.mgDl;
  }

  return createBloodInfoStruct(
    mgDl: (total / valid.length).round(),
  );
}

HealthInfoStruct? getTodayHealthInfo(
  List<HealthInfoStruct>? healthInfo,
  int? calltype,
) {
  if (healthInfo == null || healthInfo.isEmpty) {
    return null;
  }

  final DateTime now = DateTime.now();
  final DateTime today = DateTime(now.year, now.month, now.day);

  for (final item in healthInfo) {
    if (item.date == null) continue;

    final DateTime? recordDate = DateTime.tryParse(item.date!)?.toLocal();

    if (recordDate == null) continue;

    final DateTime recordDay =
        DateTime(recordDate.year, recordDate.month, recordDate.day);

    if (recordDay == today) {
      return item; // ✅ today's record
    }
  }

  return null;
}

double? stepProgress(
  int? goalVal,
  int? stepVal,
) {
  if (goalVal == null || goalVal <= 0) return 0.0;
  if (stepVal == null || stepVal <= 0) return 0.0;

  final progress = stepVal / goalVal;

  // Clamp between 0.0 and 1.0
  return progress.clamp(0.0, 1.0);
}

int? avgSteps(List<HealthInfoStruct>? healthInfo) {
  if (healthInfo == null || healthInfo.isEmpty) return 0;
  int total = 0;
  int count = 0;
  for (final item in healthInfo) {
    if (item.steps != null) {
      total += item.steps!;
      count++;
    }
  }
  if (count == 0) return 0;
  return (total ~/ count);
}

List<DateBoolTrackRecordsStruct>? filterBPMinfoDatewise(
    List<BPMinfoStruct>? bpmData) {
  if (bpmData == null || bpmData.isEmpty) {
    return [];
  }

  final Map<String, List<BPMinfoStruct>> groupedMap = {};
  final DateTime now = DateTime.now();
  final DateTime today = DateTime(now.year, now.month, now.day);
  final DateTime yesterday = today.subtract(const Duration(days: 1));

  for (final bpm in bpmData) {
    if (!bpm.hasCreatedAt()) continue;

    try {
      final DateTime utcTime = DateTime.parse(bpm.createdAt);
      final DateTime localTime = utcTime.toLocal();

      final DateTime recordDate =
          DateTime(localTime.year, localTime.month, localTime.day);

      String dateKey;

      if (recordDate == today) {
        dateKey = "Today";
      } else if (recordDate == yesterday) {
        dateKey = "Yesterday";
      } else {
        dateKey = DateFormat('MM/dd/yyyy').format(recordDate);
      }

      groupedMap.putIfAbsent(dateKey, () => []);
      groupedMap[dateKey]!.add(bpm);
    } catch (e) {
      print("❌ BPM Date Parse Error: $e");
    }
  }

  final List<DateBoolTrackRecordsStruct> result = [];

  groupedMap.forEach((date, bpmList) {
    result.add(
      DateBoolTrackRecordsStruct(
        date: date,
        bpmInfo: bpmList,
      ),
    );
  });

  // Sort logic:
  result.sort((a, b) {
    DateTime parseDate(String label) {
      if (label == "Today") return today;
      if (label == "Yesterday") return yesterday;
      return DateFormat('MM/dd/yyyy').parse(label);
    }

    return parseDate(a.date).compareTo(parseDate(b.date));
  });

  return result;
}

/// calltype = 1 pulse
/// calltype = 2 hrv
/// calltype =0 status
BPMinfoStruct? bpmStatusColor(
  BPMinfoStruct? bpmInfos,
  int? calltype,
) {
  if (bpmInfos == null) return null;

  const Color green = Color(0xFF22C55E);
  const Color yellow = Color(0xFFFACC15);
  const Color red = Color(0xFFEF4444);

  // ---------------------------
  // 🫀 Pulse
  // ---------------------------
  if (calltype == 1) {
    final int bpm = bpmInfos.pluse;

    if (bpm >= 60 && bpm <= 100) {
      return BPMinfoStruct(status: "Normal", color: green);
    } else if ((bpm >= 50 && bpm < 60) || (bpm > 100 && bpm <= 110)) {
      return BPMinfoStruct(status: "Borderline", color: yellow);
    } else {
      return BPMinfoStruct(status: "High Risk", color: red);
    }
  }

  // ---------------------------
  // 💓 HRV
  // ---------------------------
  if (calltype == 2) {
    final int hrv = bpmInfos.hrv;

    if (hrv >= 50) {
      return BPMinfoStruct(status: "Good", color: green);
    } else if (hrv >= 30) {
      return BPMinfoStruct(status: "Moderate", color: yellow);
    } else {
      return BPMinfoStruct(status: "Low", color: red);
    }
  }

  // ---------------------------
  // 📊 Overall Status
  // ---------------------------
  if (calltype == 0) {
    final int bpm = bpmInfos.pluse;

    if (bpm >= 60 && bpm <= 100) {
      return BPMinfoStruct(status: "Good", color: green);
    } else {
      return BPMinfoStruct(status: "Low", color: red);
    }
  }

  return null;
}

DateTime? dateRetun(int? howmanyDaysabove) {
  if (howmanyDaysabove == null) return DateTime.now();

  return DateTime.now().subtract(
    Duration(days: howmanyDaysabove),
  );
}
