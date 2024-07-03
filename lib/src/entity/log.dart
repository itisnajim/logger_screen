import 'package:flutter/material.dart';
import 'package:logger/logger.dart' show Level, LogEvent, AnsiColor;
import 'package:logger_screen/src/extensions.dart';

class Log {
  final dynamic message;
  final String formatted;
  final DateTime timestamp;
  final Level level;
  final Color levelForegroundColor;
  final Color levelBackgroundColor;

  const Log({
    required this.message,
    required this.formatted,
    required this.timestamp,
    required this.level,
    required this.levelForegroundColor,
    required this.levelBackgroundColor,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Log &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          formatted == other.formatted &&
          timestamp == other.timestamp &&
          level == other.level &&
          levelForegroundColor == other.levelForegroundColor &&
          levelBackgroundColor == other.levelBackgroundColor;

  @override
  int get hashCode =>
      message.hashCode ^
      formatted.hashCode ^
      timestamp.hashCode ^
      level.hashCode ^
      levelForegroundColor.hashCode ^
      levelBackgroundColor.hashCode;

  Log copyWith({
    dynamic message,
    String? formatted,
    DateTime? timestamp,
    Level? level,
    Color? levelForegroundColor,
    Color? levelBackgroundColor,
  }) {
    return Log(
      message: message ?? this.message,
      formatted: formatted ?? this.formatted,
      timestamp: timestamp ?? this.timestamp,
      level: level ?? this.level,
      levelForegroundColor: levelForegroundColor ?? this.levelForegroundColor,
      levelBackgroundColor: levelBackgroundColor ?? this.levelBackgroundColor,
    );
  }

  factory Log.fromLogEvent(
    LogEvent event, {
    required String formatted,
    required Map<Level, AnsiColor> colors,
  }) {
    return Log(
      message: event.message,
      formatted: formatted,
      timestamp: event.time,
      level: event.level,
      levelForegroundColor: event.level.foregroundColor(colors) ?? Colors.black,
      levelBackgroundColor: event.level.backgroundColor(colors) ?? Colors.white,
    );
  }

  @override
  String toString() {
    return "[${timestamp.toIso8601String()}] ${level.name}:\n$formatted\nmessage: $message";
  }

  static List<Level> usedLevelValues = Level.values
      .where((l) => ![
            Level.all,
            Level.off,
            // ignore: deprecated_member_use
            Level.nothing,
            // ignore: deprecated_member_use
            Level.verbose,
            // ignore: deprecated_member_use
            Level.wtf,
          ].contains(l))
      .toList();
}
