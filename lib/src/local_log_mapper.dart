import 'package:flutter/material.dart';

import 'mapper.dart';
import 'entity/log.dart';
import 'data/entity/local_log.dart';
import 'local_log_level_mapper.dart';

class LocalLogMapper extends Mapper<LocalLog, Log> {
  @override
  Log map(LocalLog from) {
    final localLogLevelMapper = LocalLogLevelMapper();
    return Log(
      message: from.message,
      formatted: from.formatted,
      timestamp: from.timestamp,
      level: localLogLevelMapper.map(from.level),
      levelForegroundColor: Color(from.levelForeground),
      levelBackgroundColor: Color(from.levelBackground),
    );
  }
}
