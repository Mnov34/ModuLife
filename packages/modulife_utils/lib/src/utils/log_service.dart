import 'dart:async';

import 'package:logger/logger.dart';
import 'package:modulife_utils/modulife_utils.dart';

class LogService {
  static Logger _logger = Logger(
      printer: PrettyPrinter(
          methodCount: 5,
          dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart));

  static final LogService _instance = LogService._internal();

  factory LogService() => _instance;

  LogService._internal();

  final Completer<void> _completer = Completer<void>();

  static final List<String> _logMemory = [];

  Future<void> init() async {
    if (_completer.isCompleted) return;

    try {
      LogService.i("Logger initialized.");
    } catch (e) {
      LogService.e('Failed to initialize Logger.', e);
    } finally {
      _completer.complete();
    }
  }

  /// Setter for assigning mock Logger for testing
  static set testLogger(Logger logger) {
    _logger = logger;
  }

  /// Log and store trace messages
  static void t(String message) {
    _logger.t(message);
    _storeInMemory('TRACE: $message');
  }

  /// Log and store debug messages
  static void d(String message) {
    _logger.d(message);
    _storeInMemory('DEBUG: $message');
  }

  /// Log and store info messages
  static void i(String message) {
    _logger.i(message);
    _storeInMemory('INFO: $message');
  }

  /// Log and store warning messages
  static void w(String message) {
    _logger.w(message);
    _storeInMemory('WARN: $message');
  }

  /// Log and store error messages
  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
    _storeInMemory(
        'ERROR:\nMessage: $message\nError: $error\nStackTrace: $stackTrace');
  }

  /// Store the logs in a memory buffer for later inclusion in bug reports
  static void _storeInMemory(String logEntry) {
    _logMemory.add(logEntry);

    if (_logMemory.length > 500) _logMemory.removeAt(0);
  }

  /// Get all stored logs as a single string (for inclusion in bug reports)
  static String getLogs() => _logMemory.join('\n');

  /// Clear all logs from memory
  static void clearLogs() => _logMemory.clear();
}
