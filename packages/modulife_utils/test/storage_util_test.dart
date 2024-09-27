import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:modulife_utils/modulife_utils.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late StorageUtils storageUtils;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    storageUtils = StorageUtils();
    storageUtils.setMockPrefs(mockSharedPreferences);
  });

  group('StorageUtils Tests', () {
    test('Save and retrieve String value', () async {
      const testKey = 'test_string_key';
      const testValue = 'Test String';

      when(() => mockSharedPreferences.setString(testKey, testValue))
          .thenAnswer((_) async => true);

      expect(await storageUtils.saveString(testKey, testValue), isTrue);
      verify(() => mockSharedPreferences.setString(testKey, testValue)).called(1);
    });

    test('Retrieve existing String value', () {
      const testKey = 'test_string_key';
      const testValue = 'Test String';

      when(() => mockSharedPreferences.getString(testKey)).thenReturn(testValue);

      expect(storageUtils.getString(testKey), testValue);
      verify(() => mockSharedPreferences.getString(testKey)).called(1);
    });

    test('Save and retrieve Int value', () async {
      const testKey = 'test_int_key';
      const testValue = 123;

      when(() => mockSharedPreferences.setInt(testKey, testValue))
          .thenAnswer((_) async => true);

      expect(await storageUtils.saveInt(testKey, testValue), isTrue);
      verify(() => mockSharedPreferences.setInt(testKey, testValue)).called(1);
    });

    test('Retrieve existing Int value', () {
      const testKey = 'test_int_key';
      const testValue = 123;

      when(() => mockSharedPreferences.getInt(testKey)).thenReturn(testValue);

      expect(storageUtils.getInt(testKey), testValue);
      verify(() => mockSharedPreferences.getInt(testKey)).called(1);
    });

    test('Save and retrieve Bool value', () async {
      const testKey = 'test_bool_key';
      const testValue = true;

      when(() => mockSharedPreferences.setBool(testKey, testValue))
          .thenAnswer((_) async => true);

      expect(await storageUtils.saveBool(testKey, testValue), isTrue);
      verify(() => mockSharedPreferences.setBool(testKey, testValue)).called(1);
    });

    test('Retrieve existing Bool value', () {
      const testKey = 'test_bool_key';
      const testValue = true;

      when(() => mockSharedPreferences.getBool(testKey)).thenReturn(testValue);

      expect(storageUtils.getBool(testKey), testValue);
      verify(() => mockSharedPreferences.getBool(testKey)).called(1);
    });

    test('Save and retrieve Double value', () async {
      const testKey = 'test_double_key';
      const testValue = 10.5;

      when(() => mockSharedPreferences.setDouble(testKey, testValue))
          .thenAnswer((_) async => true);

      expect(await storageUtils.saveDouble(testKey, testValue), isTrue);
      verify(() => mockSharedPreferences.setDouble(testKey, testValue)).called(1);
    });

    test('Retrieve existing Double value', () {
      const testKey = 'test_double_key';
      const testValue = 10.5;

      when(() => mockSharedPreferences.getDouble(testKey)).thenReturn(testValue);

      expect(storageUtils.getDouble(testKey), testValue);
      verify(() => mockSharedPreferences.getDouble(testKey)).called(1);
    });

    test('Save and retrieve List<String> value', () async {
      const testKey = 'test_list_key';
      const testValue = ['one', 'two', 'three'];

      when(() => mockSharedPreferences.setStringList(testKey, testValue))
          .thenAnswer((_) async => true);

      expect(await storageUtils.saveStringList(testKey, testValue), isTrue);
      verify(() => mockSharedPreferences.setStringList(testKey, testValue)).called(1);
    });

    test('Retrieve existing List<String> value', () {
      const testKey = 'test_list_key';
      const testValue = ['one', 'two', 'three'];

      when(() => mockSharedPreferences.getStringList(testKey))
          .thenReturn(testValue);

      expect(storageUtils.getStringList(testKey), testValue);
      verify(() => mockSharedPreferences.getStringList(testKey)).called(1);
    });

    test('Save and retrieve JSON value', () async {
      const testKey = 'test_json_key';
      const testValue = {'key1': 'value1', 'key2': 'value2'};
      const testJsonString = '{"key1":"value1","key2":"value2"}';

      when(() => mockSharedPreferences.setString(testKey, testJsonString))
          .thenAnswer((_) async => true);

      expect(await storageUtils.saveJson(testKey, testValue), isTrue);
      verify(() => mockSharedPreferences.setString(testKey, testJsonString)).called(1);
    });

    test('Retrieve existing JSON value', () {
      const testKey = 'test_json_key';
      const testJsonString = '{"key1":"value1","key2":"value2"}';
      const expectedValue = {'key1': 'value1', 'key2': 'value2'};

      when(() => mockSharedPreferences.getString(testKey)).thenReturn(testJsonString);

      expect(storageUtils.getJson(testKey), expectedValue);
      verify(() => mockSharedPreferences.getString(testKey)).called(1);
    });
  });
}
