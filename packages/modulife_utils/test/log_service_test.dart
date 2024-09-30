import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:logger/logger.dart';

import 'package:modulife_utils/modulife_utils.dart';

// Mock class for Logger
class MockLogger extends Mock implements Logger {}

void main() {
  late MockLogger mockLogger;

  setUp(() {
    mockLogger = MockLogger();
    LogService.testLogger = mockLogger;
  });

  group('LogService Tests', () {
    test('LogService should correctly store TRACE logs in memory', () {
      LogService.t("Test Trace Message");

      expect(LogService.getLogs(), contains("TRACE: Test Trace Message"));
    });

    test('LogService should correctly store DEBUG logs in memory', () {
      LogService.d("Test Debug Message");

      expect(LogService.getLogs(), contains("DEBUG: Test Debug Message"));
    });

    test('LogService should correctly store ERROR logs in memory', () {
      LogService.e("Test Error Message", "Error Object");

      expect(LogService.getLogs(), contains("ERROR:\nMessage: Test Error Message\nError: Error Object\nStackTrace: null"));
    });

    test('LogService should clear logs from memory', () {
      LogService.d("Test Debug Message");
      LogService.clearLogs();

      expect(LogService.getLogs(), isEmpty);
    });

    test('LogService should respect the log buffer limit of 500 entries', () {
      for (int i = 0; i < 600; i++) {
        LogService.d("Log Entry $i");
      }

      String logs = LogService.getLogs();
      expect(logs, contains("Log Entry 100"));
      expect(logs, contains("Log Entry 599"));
      expect(logs, isNot(contains("Log Entry 0")));
    });
  });
}
