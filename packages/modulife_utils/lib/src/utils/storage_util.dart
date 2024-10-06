import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'log_service.dart';

class StorageUtils {
  static final StorageUtils _instance = StorageUtils._internal();

  factory StorageUtils() => _instance;

  StorageUtils._internal();

  SharedPreferences? _prefs;

  final Completer<void> _completer = Completer<void>();

  /// Asynchronously initialize the SharedPreferences instance
  Future<void> init() async {
    if (_completer.isCompleted) return;

    try {
      _prefs = await SharedPreferences.getInstance();
      LogService.i('SharedPreferences initialized successfully.');
    } catch (e) {
      LogService.e('Failed to initialize SharedPreferences.', e);
    } finally {
      _completer.complete();
    }
  }

  /// Wait for initialization to complete before using SharedPreferences
  Future<void> ensureInitialized() => _completer.future;

  /// Setter for assigning mock SharedPreferences for testing
  void setMockPrefs(SharedPreferences sharedPreferences) {
    _prefs = sharedPreferences;
    _completer.complete();
  }

  /// Save String value
  Future<bool> saveString(String key, String value) async {
    ensureInitialized();
    try {
      bool result = await _prefs?.setString(key, value) ?? false;
      LogService.d('Saved String value: $key = $value');

      return result;
    } catch (e, stackTrace) {
      LogService.e('Failed to save String value for key: $key', e, stackTrace);
      return false;
    }
  }

  /// Get String value
  String? getString(String key) {
    ensureInitialized();
    try {
      String? value = _prefs?.getString(key);
      LogService.d('Retrieved String value: $key = $value');

      return value;
    } catch (e, stackTrace) {
      LogService.e(
          'Failed to retrieve String value for key: $key', e, stackTrace);
      return null;
    }
  }

  /// Save Integer value
  Future<bool> saveInt(String key, int value) async {
    ensureInitialized();
    try {
      bool result = await _prefs?.setInt(key, value) ?? false;
      LogService.d('Saved Int value: $key = $value');

      return result;
    } catch (e) {
      LogService.e('Failed to save Int value for key: $key', e);
      return false;
    }
  }

  /// Get Integer value
  int? getInt(String key) {
    ensureInitialized();
    try {
      int? value = _prefs?.getInt(key);
      LogService.d('Retrieved Int value: $key = $value');

      return value;
    } catch (e) {
      LogService.e('Failed to retrieve Int value for key: $key', e);
      return null;
    }
  }

  /// Save Double value
  Future<bool> saveDouble(String key, double value) async {
    ensureInitialized();
    try {
      bool result = await _prefs?.setDouble(key, value) ?? false;
      LogService.d('Saved Double value: $key = $value');

      return result;
    } catch (e) {
      LogService.e('Failed to save Double value for key: $key', e);
      return false;
    }
  }

  /// Get Double value
  double? getDouble(String key) {
    ensureInitialized();
    try {
      double? value = _prefs?.getDouble(key);
      LogService.d('Retrieved Double value: $key = $value');

      return value;
    } catch (e) {
      LogService.e('Failed to retrieve Double value for key: $key', e);
      return null;
    }
  }

  /// Save Boolean value
  Future<bool> saveBool(String key, bool value) async {
    ensureInitialized();
    try {
      bool result = await _prefs?.setBool(key, value) ?? false;
      LogService.d('Saved Boolean value: $key = $value');

      return result;
    } catch (e) {
      LogService.e('Failed to save Boolean value for key: $key', e);
      return false;
    }
  }

  /// Get Boolean value
  bool? getBool(String key) {
    ensureInitialized();
    try {
      bool? value = _prefs?.getBool(key);
      LogService.d('Retrieved Boolean value: $key = $value');

      return value;
    } catch (e) {
      LogService.e('Failed to retrieve Boolean value for key: $key', e);
      return null;
    }
  }

  /// Save List<String> value
  Future<bool> saveStringList(String key, List<String> value) async {
    ensureInitialized();
    try {
      bool result = await _prefs?.setStringList(key, value) ?? false;
      LogService.d('Saved List<String> value: $key = $value');

      return result;
    } catch (e) {
      LogService.e('Failed to save List<String> value for key: $key', e);
      return false;
    }
  }

  /// Get List<String> value
  List<String>? getStringList(String key) {
    ensureInitialized();
    try {
      List<String>? value = _prefs?.getStringList(key);
      LogService.d('Retrieved List<String> value: $key = $value');

      return value;
    } catch (e) {
      LogService.e('Failed to retrieve List<String> value for key: $key', e);
      return null;
    }
  }

  /// Save JSON (Map<String, dynamic>) by converting it to a string
  Future<bool> saveJson(String key, Map<String, dynamic> json) async {
    ensureInitialized();
    try {
      String jsonString = jsonEncode(json);

      bool result = await _prefs?.setString(key, jsonString) ?? false;
      LogService.d('Saved JSON value: $key = $jsonString');

      return result;
    } catch (e) {
      LogService.e('Failed to save JSON value for key: $key', e);
      return false;
    }
  }

  /// Get JSON (Map<String, dynamic>) by decoding the stored string
  Map<String, dynamic>? getJson(String key) {
    ensureInitialized();
    try {
      String? jsonString = _prefs?.getString(key);

      if (jsonString == null) return null;

      Map<String, dynamic> json =
          jsonDecode(jsonString) as Map<String, dynamic>;
      LogService.d('Retrieved JSON value: $key = $json');

      return json;
    } catch (e) {
      LogService.e('Failed to retrieve JSON value for key: $key', e);
      return null;
    }
  }

  /// Remove a specific value from a stored List<String>
  Future<bool> removeFromList(String key, String valueToRemove) async {
    ensureInitialized();
    try {
      List<String>? currentList = _prefs?.getStringList(key);

      if (currentList == null || !currentList.contains(valueToRemove)) {
        LogService.w(
            'Cannot remove "$valueToRemove" from list for key: "$key". List is null or value does not exist.');
        return false;
      }

      currentList.remove(valueToRemove);
      await _prefs?.setStringList(key, currentList);
      LogService.i('Removed value "$valueToRemove" from list for key: $key');
      return true;
    } catch (e) {
      LogService.e(
          'Failed to remove value "$valueToRemove" from list for key: $key', e);
      return false;
    }
  }

  /// Remove a specific field from a stored JSON object
  Future<bool> removeFromJson(String key, String fieldToRemove) async {
    ensureInitialized();
    try {
      String? jsonString = _prefs?.getString(key);

      if (jsonString == null) {
        LogService.w('No existing JSON found for key: $key');
        return false;
      }

      Map<String, dynamic> json =
          jsonDecode(jsonString) as Map<String, dynamic>;

      if (!json.containsKey(fieldToRemove)) {
        LogService.w('Field "$fieldToRemove" not found in JSON for key: $key');
        return false;
      }

      json.remove(fieldToRemove);
      await saveJson(key, json);
      LogService.i(
          'Successfully removed field "$fieldToRemove" from JSON for key: $key');
      return true;
    } catch (e) {
      LogService.e(
          'Failed to remove field "$fieldToRemove" from JSON for key: $key.',
          e);
      return false;
    }
  }

  /// Remove a specific key from storage
  Future<bool> remove(String key) async {
    ensureInitialized();
    try {
      bool result = await _prefs?.remove(key) ?? false;
      LogService.d('Removed value for key: $key');

      return result;
    } catch (e) {
      LogService.e('Failed to remove value for key: $key', e);
      return false;
    }
  }

  /// Clear all keys in storage
  Future<bool> clearAll() async {
    ensureInitialized();
    try {
      bool result = await _prefs?.clear() ?? false;
      LogService.d('Cleared all storage values.');

      return result;
    } catch (e) {
      LogService.e('Failed to clear storage values.', e);
      return false;
    }
  }

  /// Check if a key exists
  bool containsKey(String key) {
    ensureInitialized();
    try {
      bool contains = _prefs?.containsKey(key) ?? false;
      LogService.d('Key exists check: $key = $contains');

      return contains;
    } catch (e) {
      LogService.e('Failed to check existence of key: $key', e);
      return false;
    }
  }
}
