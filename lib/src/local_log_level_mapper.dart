import 'package:logger/logger.dart' show Level;

import 'data/entity/local_log.dart';
import 'mapper.dart';

class LocalLogLevelMapper extends Mapper<LocalLevel, Level> {
  @override
  Level map(LocalLevel from) {
    switch (from) {
      case LocalLevel.trace:
        return Level.trace;
      case LocalLevel.debug:
        return Level.debug;
      case LocalLevel.info:
        return Level.info;
      case LocalLevel.warning:
        return Level.warning;
      case LocalLevel.error:
        return Level.error;
      case LocalLevel.fatal:
        return Level.fatal;
    }
  }
}
