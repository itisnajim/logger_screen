import 'mapper.dart';
import 'entity/log.dart';
import 'log_level_mapper.dart';
import 'data/entity/local_log.dart';

class LogMapper extends Mapper<Log, LocalLog> {
  @override
  LocalLog map(Log from) {
    final logLevelMapper = LogLevelMapper();
    return LocalLog(
      message: from.message,
      formatted: from.formatted,
      timestamp: from.timestamp,
      level: logLevelMapper.map(from.level),
      levelForeground: from.levelForegroundColor.value,
      levelBackground: from.levelBackgroundColor.value,
    );
  }
}
