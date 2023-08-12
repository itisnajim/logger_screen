import 'dart:async';

import 'package:logger/logger.dart' show PrettyPrinter, Level, LogEvent;

import 'data/database.dart';
import 'data/schemas.dart';
import 'data/service/local_log_service.dart';
import 'entity/filter.dart';
import 'entity/log.dart';
import 'local_log_level_mapper.dart';
import 'local_log_mapper.dart';
import 'log_level_mapper.dart';
import 'log_mapper.dart';

final void unit = (() {})();

/// The `LoggerScreenPrinter` is responsible for processing log events and
/// notifying listeners about new log entries. It extends `PrettyPrinter` from
/// the `logger` package. The formatted logs are stored
/// in the [logs] list and can be accessed directly. Additionally, the `logsStream`
/// provides a broadcast stream that emits new log entries to listeners.
///
/// The [fileName] parameter specifies the name of the log file where the logs
/// will be persisted locally.
///
/// The [encryptionKey] parameter is an optional key that can be provided if
/// you want to encrypt the log data when storing it in the local log database.
///
/// Example usage:
/// ```dart
/// LoggerScreenPrinter myLoggerPrinter = LoggerScreenPrinter(
///   fileName: "logs",
///   encryptionKey: "my_secret_key",
///   colors: true,
///   printEmojis: true,
/// );
/// ```
class LoggerScreenPrinter extends PrettyPrinter {
  final StreamController<Log> _logsStreamController =
      StreamController<Log>.broadcast();

  final StreamController<void> _resetStreamController =
      StreamController<void>.broadcast();

  LocalLogService? _localLogService;
  // mappers
  late LogMapper _logMapper;
  late LocalLogMapper _localLogMapper;

  /// The name of the log database file where the logs will be persisted locally.
  final String? fileName;

  /// An optional key to encrypt the log data when storing it in the local log database.
  final String? encryptionKey;

  /// Stream that provides log entries to its listeners.
  Stream<Log> get logsStream => _logsStreamController.stream;
  Stream<void> get resetStream => _resetStreamController.stream;

  /// List of logs stored in memory. These logs are also used to display in the UI.
  List<Log> logs = [];
  final List<Log> _allLogs = [];
  Filter _filter = const Filter();

  /// Constructor to create a new `LoggerScreenPrinter`.
  ///
  /// The [stackTraceBeginIndex], [methodCount], [errorMethodCount], [lineLength],
  /// [colors], [printEmojis], [printTime], [excludeBox], [noBoxingByDefault],
  /// [excludePaths], [levelColors], and [levelEmojis] parameters are used to
  /// initialize the underlying `PrettyPrinter` with the provided log formatting
  /// options and configurations.
  ///
  /// The [fileName] parameter is an optional parameter that specifies the name
  /// of the log file where the logs will be persisted locally. If provided, the
  /// `LoggerScreenPrinter` will store the logs in the local database.
  /// The logs will be saved to the specified file and can be accessed even after
  /// the app restarts.
  ///
  /// The [encryptionKey] parameter is an optional key that can be provided if
  /// you want to encrypt the log data when storing it in the local log database.
  LoggerScreenPrinter({
    super.stackTraceBeginIndex = 0,
    super.methodCount = 2,
    super.errorMethodCount = 8,
    super.lineLength = 120,
    super.colors = true,
    super.printEmojis = true,
    super.printTime = false,
    super.excludeBox = const {},
    super.noBoxingByDefault = false,
    super.excludePaths = const [],
    super.levelColors,
    super.levelEmojis,
    this.fileName,
    this.encryptionKey,
  }) {
    _logMapper = LogMapper();
    _localLogMapper = LocalLogMapper();
    if (fileName != null) {
      _localLogService = LocalLogService(
        Database(
          schemas: schemas,
          name: fileName!.split('.').first,
          encryptionKey: encryptionKey,
        ),
      );
    }
  }

  Future<List<Log>> initialize() async {
    final result = await loadLogs(_filter);
    _allLogs
      ..clear()
      ..addAll(result);
    _allLogs.sort((l1, l2) => l2.timestamp.compareTo(l1.timestamp));

    logs.clear();
    for (final log in _allLogs) {
      if (isValidToFilter(log, _filter)) logs.add(log);
    }
    return logs;
  }

  Future<void>? _saveLog(Log log) {
    return _localLogService?.set(_logMapper.map(log));
  }

  Future<List<Log>> applyFilter(Filter filter) async {
    _filter = filter;

    final result = await loadLogs(filter);
    final map = await getLevelCountMap(terms: _filter.search);
    levelsCounts = Map.from(map);
    if (result.isEmpty && _filter.page > 1) {
      _filter = _filter.copyWithPage(_filter.page - 1);
    }
    if (_filter.page == 1) {
      logs = List.from(result);
    } else {
      logs.addAll(result);
    }

    for (final log in result) {
      if (!_allLogs.contains(log)) {
        _allLogs.add(log);
      }
    }

    _allLogs.sort((l1, l2) => l2.timestamp.compareTo(l1.timestamp));
    return logs;
  }

  Future<List<Log>> loadLogs(Filter filter) {
    List<Log> filterMemory() {
      final filteredLogs = _allLogs
          .where(
            (l) =>
                (l.level == filter.level || filter.level == null) &&
                ((filter.search?.isNotEmpty ?? false) &&
                    l.message
                        .toString()
                        .toLowerCase()
                        .contains(filter.search!.toLowerCase())),
          )
          .toList();

      // Apply pagination
      int startIndex = filter.offset;
      int endIndex = (startIndex + filter.limit).clamp(0, filteredLogs.length);

      return filteredLogs.sublist(startIndex, endIndex);
    }

    return _localLogService
            ?.getFiltered(
              filter.level == null ? null : LogLevelMapper().map(filter.level!),
              filter.search,
              offset: filter.offset,
              limit: filter.limit,
            )
            .then((l) => _localLogMapper.mapList(l)) ??
        Future.value(filterMemory());
  }

  /// Clears the list of logs stored in memory and also clears the logs stored in
  /// the local log database. The method returns a
  /// `FutureOr<void>` since it doesn't return any specific value. It only clears
  /// the logs, and the future is completed when the logs are successfully cleared.
  ///
  /// The method is useful to clear logs when you want to start fresh or free up
  /// memory occupied by old logs.
  ///
  /// Example usage:
  /// ```dart
  /// // Clear all logs from memory and the local log database
  /// await clear();
  /// ```
  FutureOr<void> clear() {
    logs.clear();
    _allLogs.clear();
    levelsCounts = {
      null: 0,
      ...Map.fromEntries(Log.usedLevelValues.map((l) => MapEntry(l, 0))),
    };
    _resetStreamController.add(unit);
    return _localLogService?.clear();
  }

  Map<Level?, int> levelsCounts = {
    null: 0,
    ...Map.fromEntries(Log.usedLevelValues.map((l) => MapEntry(l, 0))),
  };

  Map<Level?, int> _getMemoryLevelCountMap() {
    final Map<Level?, int> levelCountMap = {};
    int totalCount = 0;

    for (final log in logs) {
      final level = log.level;
      levelCountMap[level] = (levelCountMap[level] ?? 0) + 1;
      totalCount++;
    }

    levelCountMap[null] = totalCount;
    return levelCountMap;
  }

  /// Retrieves a map containing the count of logs for each [Level] and a null
  /// key for the total count.
  ///
  ///
  /// If the levels count map from the database is not available, it falls
  /// back to [logs] value to provides a map of the count of logs in memory.
  ///
  /// Returns a `Future<Map<Level?, int>>` with each [Level] and its corresponding count.
  Future<Map<Level?, int>> getLevelCountMap({
    String? terms,
  }) async {
    final Map<Level?, int> result;
    final memoryLevelCountMap = _getMemoryLevelCountMap();
    final localLogLevelMapper = LocalLogLevelMapper();

    final levelsCountMap =
        await _localLogService?.getLevelCountMap(terms: terms);

    if (levelsCountMap != null) {
      result = levelsCountMap.map((localLevel, count) {
        final level =
            localLevel == null ? null : localLogLevelMapper.map(localLevel);
        return MapEntry(level, count);
      });
    } else {
      result = memoryLevelCountMap;
    }

    levelsCounts = result;
    return levelsCounts;
  }

  bool isValidToFilter(Log log, Filter filter) {
    bool levelMatches = log.level == filter.level || filter.level == null;
    bool searchMatches = (filter.search?.isNotEmpty ?? false)
        ? log.message
            .toString()
            .toLowerCase()
            .contains(filter.search!.toLowerCase())
        : true;

    return levelMatches && searchMatches;
  }

  void handleNewLog(Log log) {
    _saveLog(log);
    _logsStreamController.add(log);
    _allLogs.insert(0, log);
    levelsCounts[log.level] = (levelsCounts[log.level] ?? 0) + 1;
    levelsCounts[null] = (levelsCounts[null] ?? 0) + 1;
    if (isValidToFilter(log, _filter)) {
      logs.insert(0, log);
    }
  }

  @override
  List<String> log(LogEvent event) {
    final result = super.log(event);

    // Call the superclass method to get the formatted log message
    List<String> logOutput = List.from(result);

    // Extract the formatted log message from the list
    String formattedLog = logOutput.join("\n");

    handleNewLog(Log.fromLogEvent(
      event,
      formatted: formattedLog,
      colors: levelColors ?? PrettyPrinter.defaultLevelColors,
    ));

    return result;
  }
}
