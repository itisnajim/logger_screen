import 'package:logger/logger.dart' show Level;

import 'mapper.dart';
import 'data/entity/local_log.dart';

class LogLevelMapper extends Mapper<Level, LocalLevel> {
  @override
  LocalLevel map(Level from) {
    switch (from) {
      // ignore: deprecated_member_use
      case Level.trace || Level.verbose:
        return LocalLevel.trace;
      case Level.debug:
        return LocalLevel.debug;
      case Level.info:
        return LocalLevel.info;
      case Level.warning:
        return LocalLevel.warning;
      case Level.error:
        return LocalLevel.error;
      // ignore: deprecated_member_use
      case Level.wtf:
        return LocalLevel.fatal;
      case Level.fatal:
        return LocalLevel.fatal;
      default:
        return LocalLevel.trace;
    }
  }
}
