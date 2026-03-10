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

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This Calling Inside of the Void Main File

const String _kTranslationVersionKey = 'translation_table_version';
const String _kLastSyncTimestampKey = 'translation_last_sync';

// ============================================
// MAIN INITIALIZATION - OPTIMIZED FOR INSTANT RETURN
// ============================================

Future<void> initializeTranslations() async {
  // OPTIMIZATION 1: If already in memory, return instantly
  if (FFAppState().translationsCSV != null &&
      FFAppState().translationsCSV.isNotEmpty) {
    print("⚡ Translations already in memory - 0ms");
    _syncInBackgroundDelayed(); // Check updates later
    return; // ✅ INSTANT RETURN
  }

  // OPTIMIZATION 2: Start background loading immediately, don't wait
  print("🚀 Starting translation load in background...");
  _loadTranslationsOptimized();

  // ✅ INSTANT RETURN - Don't block app startup
  return;
}

// ============================================
// OPTIMIZED BACKGROUND LOADER
// ============================================

void _loadTranslationsOptimized() {
  Future.microtask(() async {
    try {
      // OPTIMIZATION 3: Check cache existence first (fast file check)
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/language_cache.csv');
      final cacheExists = await file.exists();

      if (cacheExists) {
        // OPTIMIZATION 4: Try fast parse first
        print("📂 Cache found - attempting fast load...");
        await _parseCachedCSVFast(file);

        if (FFAppState().translationsCSV != null &&
            FFAppState().translationsCSV.isNotEmpty) {
          print("⚡ Fast load successful");
          _checkForUpdatesInBackground(); // Check for updates
          return;
        }
      }

      // OPTIMIZATION 5: No cache or fast parse failed - download fresh
      print("📥 Downloading fresh translations...");
      await downloadAndCacheLanguageCSV();

      // Parse the newly downloaded cache
      await parseCachedCSV();

      print("✅ Translation load complete");
    } catch (e) {
      print("⛔ Translation load error: $e");
      // Optionally: Set a flag that translations failed to load
    }
  });
}

// ============================================
// SHARED PREFERENCES HELPERS
// ============================================

Future<int> _getLocalVersion() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kTranslationVersionKey) ?? 0;
  } catch (e) {
    print("⚠️ Error reading local version: $e");
    return 0;
  }
}

Future<void> _saveLocalVersion(int version) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kTranslationVersionKey, version);
    await prefs.setInt(
        _kLastSyncTimestampKey, DateTime.now().millisecondsSinceEpoch);
    print("💾 Saved version $version to SharedPreferences");
  } catch (e) {
    print("⚠️ Error saving local version: $e");
  }
}

Future<DateTime?> _getLastSyncTime() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt(_kLastSyncTimestampKey);
    if (timestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
  } catch (e) {
    print("⚠️ Error reading last sync time: $e");
  }
  return null;
}

Future<void> _clearLocalVersion() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kTranslationVersionKey);
    await prefs.remove(_kLastSyncTimestampKey);
    print("🗑️ Cleared version from SharedPreferences");
  } catch (e) {
    print("⚠️ Error clearing local version: $e");
  }
}

// ============================================
// OPTIMIZED: Fast cache parsing (no validation)
// ============================================

Future<void> _parseCachedCSVFast(File file) async {
  try {
    final content = await file.readAsString();
    if (content.isEmpty) return;

    // OPTIMIZATION 6: Parse CSV with minimal validation
    final rows = const CsvToListConverter().convert(content);
    if (rows.length < 2) return;

    final headers = rows[0].map((h) => h.toString().trim()).toList();
    final keyIndex = headers.indexOf('key');
    if (keyIndex == -1) return;

    Map<String, Map<String, String>> translations = {};

    // Fast parse - skip validation
    for (var i = 1; i < rows.length; i++) {
      final row = rows[i];
      if (row.length != headers.length) continue;

      final key = row[keyIndex].toString().trim();
      if (key.isEmpty) continue;

      for (int j = 0; j < headers.length; j++) {
        if (j == keyIndex) continue;
        final langCode = headers[j].trim();
        translations.putIfAbsent(langCode, () => {});
        translations[langCode]![key] = row[j].toString().trim();
      }
    }

    if (translations.isNotEmpty) {
      FFAppState().translationsCSV = jsonEncode(translations);
      print("⚡ Fast parsed ${translations.keys.length} languages");
    }
  } catch (e) {
    print("⚠️ Fast parse error: $e");
  }
}

// ============================================
// BACKGROUND UPDATE CHECKER
// ============================================

void _checkForUpdatesInBackground() async {
  try {
    // OPTIMIZATION 7: Delay update check to avoid impacting UI
    await Future.delayed(Duration(seconds: 3));

    final localVersion = await _getLocalVersion();
    final supabase = Supabase.instance.client;

    final response = await supabase
        .from('config')
        .select('translation_table_version')
        .limit(1)
        .maybeSingle();

    final serverVersion = (response?['translation_table_version'] as int?) ?? 0;

    print("📊 Version check: local=$localVersion, server=$serverVersion");

    if (serverVersion > localVersion) {
      print("🔄 Update available ($localVersion → $serverVersion)");
      await downloadAndCacheLanguageCSV();
      await parseCachedCSV();
      print("✅ Translations updated to v$serverVersion");
    } else {
      print("✅ Translations up to date (v$localVersion)");
    }
  } catch (e) {
    print("⚠️ Update check failed: $e");
  }
}

void _syncInBackgroundDelayed() async {
  await Future.delayed(Duration(seconds: 5));
  _checkForUpdatesInBackground();
}

// ============================================
// STANDARD: Full validation parsing
// ============================================

Future<void> parseCachedCSV() async {
  print("📁 Parsing cached CSV with validation...");

  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/language_cache.csv');

  if (!await file.exists()) {
    print("⚠️ No cache file found");
    return;
  }

  try {
    final content = await file.readAsString();
    if (content.isEmpty) {
      print("⚠️ Empty cache file");
      return;
    }

    final rows = const CsvToListConverter().convert(content);
    if (rows.isEmpty) {
      print("⚠️ No rows in CSV");
      return;
    }

    print("📊 Parsing ${rows.length} rows...");

    final headers = rows[0].map((h) => h.toString().trim()).toList();
    final keyIndex = headers.indexOf('key');

    if (keyIndex == -1) {
      print("⛔ 'key' column missing");
      return;
    }

    Map<String, Map<String, String>> translations = {};

    for (var i = 1; i < rows.length; i++) {
      final row = rows[i];
      if (row.isEmpty || row.length != headers.length) continue;

      final key = row[keyIndex].toString().trim();
      if (key.isEmpty) continue;

      for (int j = 0; j < headers.length; j++) {
        if (j == keyIndex) continue;

        final langCode = headers[j].trim();
        final value = row[j].toString().trim();

        translations.putIfAbsent(langCode, () => {});
        translations[langCode]![key] = value;
      }
    }

    FFAppState().translationsCSV = jsonEncode(translations);

    print("✅ Validated ${translations.keys.length} languages");
    translations.forEach((lang, map) {
      print("   $lang: ${map.length} entries");
    });
  } catch (e) {
    print("⛔ Parsing error: $e");
  }
}

// ============================================
// DOWNLOAD & CACHE
// ============================================

Future<void> downloadAndCacheLanguageCSV() async {
  final supabase = Supabase.instance.client;

  try {
    print("🌐 Downloading translations...");

    // STEP 1: Get the current server version FIRST
    final configResponse = await supabase
        .from('config')
        .select('translation_table_version')
        .limit(1)
        .maybeSingle();

    final serverVersion =
        (configResponse?['translation_table_version'] as int?) ?? 0;
    print("📊 Server version: $serverVersion");

    // STEP 2: Download translations
    final response = await supabase
        .from('translation')
        .select()
        .order('key', ascending: true);

    if (response == null || response.isEmpty) {
      print("⚠️ Empty response from Supabase");
      return;
    }

    print("📊 Downloaded ${response.length} rows");

    // STEP 3: Cache the CSV file
    final csvContent = _convertToCsv(response);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/language_cache.csv');

    await file.writeAsString(csvContent);
    print("💾 CSV file cached successfully");

    // STEP 4: Save the version to SharedPreferences
    await _saveLocalVersion(serverVersion);

    print("✅ Download complete - cached v$serverVersion");
  } catch (e) {
    print("⛔ Download error: $e");
    rethrow;
  }
}

String _convertToCsv(List<dynamic> data) {
  if (data.isEmpty) return '';

  final headers = (data[0] as Map<String, dynamic>).keys.toList();

  if (headers.contains('key')) {
    headers.remove('key');
    headers.insert(0, 'key');
  }

  List<List<dynamic>> csvData = [headers];

  for (var row in data) {
    final rowData =
        headers.map((key) => (row as Map<String, dynamic>)[key] ?? '').toList();
    csvData.add(rowData);
  }

  return const ListToCsvConverter().convert(csvData);
}

// ============================================
// UTILITY FUNCTIONS
// ============================================

Future<void> clearTranslationCache() async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/language_cache.csv');

    if (await file.exists()) {
      await file.delete();
      print("🗑️ Cache file deleted");
    }

    FFAppState().translationsCSV = "";
    print("🗑️ Memory cleared");

    await _clearLocalVersion();

    print("✅ Cache completely cleared");
  } catch (e) {
    print("⛔ Clear error: $e");
  }
}

// ============================================
// DEBUG UTILITIES
// ============================================

Future<void> printTranslationInfo() async {
  try {
    final localVersion = await _getLocalVersion();
    final lastSync = await _getLastSyncTime();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/language_cache.csv');
    final fileExists = await file.exists();
    final fileSize = fileExists ? await file.length() : 0;

    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    print("📊 TRANSLATION CACHE INFO");
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    print("Version (Local): v$localVersion");
    print("Last Sync: ${lastSync ?? 'Never'}");
    print("Cache File Exists: $fileExists");
    print("Cache File Size: ${(fileSize / 1024).toStringAsFixed(2)} KB");
    print(
        "In Memory: ${FFAppState().translationsCSV != null && FFAppState().translationsCSV.isNotEmpty}");
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
  } catch (e) {
    print("⛔ Error getting info: $e");
  }
}

Future<void> forceUpdateTranslations() async {
  print("🔄 Force updating translations...");
  await clearTranslationCache();
  await downloadAndCacheLanguageCSV();
  await parseCachedCSV();
  print("✅ Force update complete");
}
