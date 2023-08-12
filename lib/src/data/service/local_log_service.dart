import 'package:isar/isar.dart';

import '../database.dart';
import '../entity/local_log.dart';

class LocalLogService {
  final Database _database;

  const LocalLogService(this._database);

  Future<LocalLog?> get(String id) async {
    return _database.get(id);
  }

  Future<List<LocalLog?>> getMany(List<String> ids) async {
    return _database.getMany(ids);
  }

  Future<List<LocalLog>> getAll({int? offset, int? limit}) async {
    final collection = await _database.collection<String, LocalLog>();
    return collection
        .where()
        .sortByTimestampDesc()
        .findAll(offset: offset, limit: limit);
  }

  Future<void> set(LocalLog object) async {
    return _database.set<String, LocalLog>(object);
  }

  // Isar web always returns true.
  Future<bool> delete(String id) {
    return _database.delete<String, LocalLog>(id);
  }

  Future<void> clear() {
    return _database.clear<String, LocalLog>();
  }

  Future<int> count() {
    return _database.count<String, LocalLog>();
  }

  Future<Map<LocalLevel?, int>> getLevelCountMap({
    String? terms,
  }) async {
    final isar = await _database.open();

    final res = await Future.wait(
      LocalLevel.values.map((level) async {
        if (terms != null) {
          final count = await isar.localLogs
              .where()
              .levelEqualTo(level)
              .formattedContains(terms, caseSensitive: true)
              .countAsync();
          return MapEntry(level, count);
        } else {
          final count =
              await isar.localLogs.where().levelEqualTo(level).countAsync();
          return MapEntry(level, count);
        }
      }),
    );

    final totalCount = res.map((e) => e.value).reduce((v, e) => v + e);
    return Map.fromEntries([MapEntry(null, totalCount), ...res]);
  }

  Future<List<LocalLog>> getFiltered(
    LocalLevel? level,
    String? terms, {
    int? offset,
    int? limit,
  }) async {
    final collection = await _database.collection<String, LocalLog>();

    if (level != null && terms != null) {
      return collection
          .where()
          .levelEqualTo(level)
          .formattedContains(terms, caseSensitive: true)
          .sortByTimestampDesc()
          .findAll(offset: offset, limit: limit);
    } else if (level != null) {
      return collection
          .where()
          .levelEqualTo(level)
          .sortByTimestampDesc()
          .findAll(offset: offset, limit: limit);
    } else if (terms != null) {
      return collection
          .where()
          .formattedContains(terms, caseSensitive: true)
          .sortByTimestampDesc()
          .findAll(offset: offset, limit: limit);
    } else {
      // If both level and terms are null, return all items without any filters.
      return collection
          .where()
          .sortByTimestampDesc()
          .findAll(offset: offset, limit: limit);
    }
  }
}
