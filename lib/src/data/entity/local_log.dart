import 'package:isar/isar.dart';

part 'local_log.g.dart';

@collection
class LocalLog {
  LocalLog({
    required this.message,
    required this.formatted,
    required this.timestamp,
    required this.level,
    required this.levelForeground,
    required this.levelBackground,
  });

  String get id => '$timestamp$message$formatted$level';
  final String message;
  final String formatted;
  final DateTime timestamp;
  final LocalLevel level;
  final int levelForeground;
  final int levelBackground;
}

enum LocalLevel {
  trace,
  debug,
  info,
  warning,
  error,
  @Deprecated('[wtf] is being deprecated in favor of [fatal].')
  wtf,
  fatal;
}
