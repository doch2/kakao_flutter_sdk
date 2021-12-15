import 'dart:collection';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:kakao_flutter_sdk_common/src/kakao_sdk.dart';

enum SdkLogLevel { v, d, i, w, e }

extension SdkLogLevelExtension on SdkLogLevel {
  int get level {
    switch (this) {
      case SdkLogLevel.v:
        return 0;
      case SdkLogLevel.d:
        return 1;
      case SdkLogLevel.i:
        return 2;
      case SdkLogLevel.w:
        return 3;
      case SdkLogLevel.e:
        return 4;
    }
  }

  String get prefix {
    switch (this) {
      case SdkLogLevel.v:
        return "[\uD83D\uDCAC]";
      case SdkLogLevel.d:
        return "[ℹ️]";
      case SdkLogLevel.i:
        return "[\uD83D\uDD2C]";
      case SdkLogLevel.w:
        return "[⚠️]";
      case SdkLogLevel.e:
        return "[‼️]";
    }
  }
}

class SdkLog {
  static final bool _enabled = KakaoSdk.logging;

  static final LinkedList<LogData> _logs = LinkedList();

  static const int _maxSize = 100;

  SdkLog._();

  static Future<String> get logs async {
    return ''' 
    ==== sdk version: ${KakaoSdk.sdkVersion}
    ==== app version: ${await KakaoSdk.appVer}
    '''
            .trim() +
        _logs.join("\n");
  }

  static void v(Object? logged) => _log(logged, SdkLogLevel.v);

  static void d(Object? logged) => _log(logged, SdkLogLevel.d);

  static void i(Object? logged) => _log(logged, SdkLogLevel.i);

  static void w(Object? logged) => _log(logged, SdkLogLevel.w);

  static void e(Object? logged) => _log(logged, SdkLogLevel.e);

  static void _log(Object? logged, SdkLogLevel logLevel) {
    String log = "${logLevel.prefix} $logged";

    if (kDebugMode) {
      developer.log(log, level: logLevel.level);
    }
    if (_enabled && logLevel.level >= SdkLogLevel.i.level) {
      _logs.add(LogData("${DateTime.now()} $log"));
      if (_logs.length > _maxSize) {
        _logs.remove(_logs.first);
      }
    }
  }
}

class LogData extends LinkedListEntry<LogData> {
  String log;

  LogData(this.log);

  @override
  String toString() {
    return log;
  }
}