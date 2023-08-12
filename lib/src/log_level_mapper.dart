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
        // ignore: deprecated_member_use_from_same_package
        return LocalLevel.wtf;
      case Level.fatal:
        return LocalLevel.fatal;
      default:
        return LocalLevel.trace;
    }
  }
}
