import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

class MyLogger {
  static const String _errorSymbol = '❌❌❌'; // Red Cross Mark
  static const String _successSymbol = '✅'; // Check Mark
  static const String _warningSymbol = '⚠️'; // Warning Sign
  static const String _infoSymbol = 'ℹ️'; // Information Symbol
  static const String _debugSymbol = '🐞'; // Bug Symbol

  // Info
  static void info(String message) {
    _log(message, _infoSymbol, 'INFO');
  }

  // Success
  static void success(String message) {
    _log(message, _successSymbol, 'SUCCESS');
  }

  // Warning
  static void warning(String message) {
    _log(message, _warningSymbol, 'WARNING');
  }

  // Error
  static void error(String message) {
    _log(message, _errorSymbol, 'ERROR');
  }

  // Debug
  static void debug(String message) {
    _log(message, _debugSymbol, 'DEBUG');
  }

  // Private log method
  static void _log(String message, String symbol, String level) {
    if (kDebugMode) {
      final formattedMessage = '$symbol [$level] ::: $message';
      developer.log(formattedMessage, name: level);
    }
  }
}
