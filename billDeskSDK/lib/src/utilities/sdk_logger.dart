import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class SdkLogger{
  static late Logger _logger;
  
  static void init({bool isUAT = false, Level level = Level.debug}) {

    _logger = Logger(
      level: level,
      printer: PrettyPrinter(),
      output: ConsoleOutput(),
      filter: (kReleaseMode || !isUAT )? ProdLogFilter() : DevelopmentFilter()
    );
   
  }

  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error, stackTrace);
  }

  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error, stackTrace);
  }

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }

  static void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.v(message, error, stackTrace);
  }
  
}

class ProdLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
     if(event.level == Level.error || event.level == Level.warning) {
     return true;
   }

   return false;
  }
}
