// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_log.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetLocalLogCollection on Isar {
  IsarCollection<String, LocalLog> get localLogs => this.collection();
}

const LocalLogSchema = IsarCollectionSchema(
  schema:
      '{"name":"LocalLog","idName":"id","properties":[{"name":"message","type":"String"},{"name":"formatted","type":"String"},{"name":"timestamp","type":"DateTime"},{"name":"level","type":"Byte","enumMap":{"trace":0,"debug":1,"info":2,"warning":3,"error":4,"wtf":5,"fatal":6}},{"name":"levelForeground","type":"Long"},{"name":"levelBackground","type":"Long"},{"name":"id","type":"String"}]}',
  converter: IsarObjectConverter<String, LocalLog>(
    serialize: serializeLocalLog,
    deserialize: deserializeLocalLog,
    deserializeProperty: deserializeLocalLogProp,
  ),
  embeddedSchemas: [],
  //hash: 3945217570814107922,
);

@isarProtected
int serializeLocalLog(IsarWriter writer, LocalLog object) {
  IsarCore.writeString(writer, 1, object.message);
  IsarCore.writeString(writer, 2, object.formatted);
  IsarCore.writeLong(
      writer, 3, object.timestamp.toUtc().microsecondsSinceEpoch);
  IsarCore.writeByte(writer, 4, object.level.index);
  IsarCore.writeLong(writer, 5, object.levelForeground);
  IsarCore.writeLong(writer, 6, object.levelBackground);
  IsarCore.writeString(writer, 7, object.id);
  return Isar.fastHash(object.id);
}

@isarProtected
LocalLog deserializeLocalLog(IsarReader reader) {
  final String _message;
  _message = IsarCore.readString(reader, 1) ?? '';
  final String _formatted;
  _formatted = IsarCore.readString(reader, 2) ?? '';
  final DateTime _timestamp;
  {
    final value = IsarCore.readLong(reader, 3);
    if (value == -9223372036854775808) {
      _timestamp =
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
    } else {
      _timestamp =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  final LocalLevel _level;
  {
    if (IsarCore.readNull(reader, 4)) {
      _level = LocalLevel.trace;
    } else {
      _level = _localLogLevel[IsarCore.readByte(reader, 4)] ?? LocalLevel.trace;
    }
  }
  final int _levelForeground;
  _levelForeground = IsarCore.readLong(reader, 5);
  final int _levelBackground;
  _levelBackground = IsarCore.readLong(reader, 6);
  final object = LocalLog(
    message: _message,
    formatted: _formatted,
    timestamp: _timestamp,
    level: _level,
    levelForeground: _levelForeground,
    levelBackground: _levelBackground,
  );
  return object;
}

@isarProtected
dynamic deserializeLocalLogProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      {
        final value = IsarCore.readLong(reader, 3);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    case 4:
      {
        if (IsarCore.readNull(reader, 4)) {
          return LocalLevel.trace;
        } else {
          return _localLogLevel[IsarCore.readByte(reader, 4)] ??
              LocalLevel.trace;
        }
      }
    case 5:
      return IsarCore.readLong(reader, 5);
    case 6:
      return IsarCore.readLong(reader, 6);
    case 7:
      return IsarCore.readString(reader, 7) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _LocalLogUpdate {
  bool call({
    required String id,
    String? message,
    String? formatted,
    DateTime? timestamp,
    LocalLevel? level,
    int? levelForeground,
    int? levelBackground,
  });
}

class _LocalLogUpdateImpl implements _LocalLogUpdate {
  const _LocalLogUpdateImpl(this.collection);

  final IsarCollection<String, LocalLog> collection;

  @override
  bool call({
    required String id,
    Object? message = ignore,
    Object? formatted = ignore,
    Object? timestamp = ignore,
    Object? level = ignore,
    Object? levelForeground = ignore,
    Object? levelBackground = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (message != ignore) 1: message as String?,
          if (formatted != ignore) 2: formatted as String?,
          if (timestamp != ignore) 3: timestamp as DateTime?,
          if (level != ignore) 4: level as LocalLevel?,
          if (levelForeground != ignore) 5: levelForeground as int?,
          if (levelBackground != ignore) 6: levelBackground as int?,
        }) >
        0;
  }
}

sealed class _LocalLogUpdateAll {
  int call({
    required List<String> id,
    String? message,
    String? formatted,
    DateTime? timestamp,
    LocalLevel? level,
    int? levelForeground,
    int? levelBackground,
  });
}

class _LocalLogUpdateAllImpl implements _LocalLogUpdateAll {
  const _LocalLogUpdateAllImpl(this.collection);

  final IsarCollection<String, LocalLog> collection;

  @override
  int call({
    required List<String> id,
    Object? message = ignore,
    Object? formatted = ignore,
    Object? timestamp = ignore,
    Object? level = ignore,
    Object? levelForeground = ignore,
    Object? levelBackground = ignore,
  }) {
    return collection.updateProperties(id, {
      if (message != ignore) 1: message as String?,
      if (formatted != ignore) 2: formatted as String?,
      if (timestamp != ignore) 3: timestamp as DateTime?,
      if (level != ignore) 4: level as LocalLevel?,
      if (levelForeground != ignore) 5: levelForeground as int?,
      if (levelBackground != ignore) 6: levelBackground as int?,
    });
  }
}

extension LocalLogUpdate on IsarCollection<String, LocalLog> {
  _LocalLogUpdate get update => _LocalLogUpdateImpl(this);

  _LocalLogUpdateAll get updateAll => _LocalLogUpdateAllImpl(this);
}

sealed class _LocalLogQueryUpdate {
  int call({
    String? message,
    String? formatted,
    DateTime? timestamp,
    LocalLevel? level,
    int? levelForeground,
    int? levelBackground,
  });
}

class _LocalLogQueryUpdateImpl implements _LocalLogQueryUpdate {
  const _LocalLogQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<LocalLog> query;
  final int? limit;

  @override
  int call({
    Object? message = ignore,
    Object? formatted = ignore,
    Object? timestamp = ignore,
    Object? level = ignore,
    Object? levelForeground = ignore,
    Object? levelBackground = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (message != ignore) 1: message as String?,
      if (formatted != ignore) 2: formatted as String?,
      if (timestamp != ignore) 3: timestamp as DateTime?,
      if (level != ignore) 4: level as LocalLevel?,
      if (levelForeground != ignore) 5: levelForeground as int?,
      if (levelBackground != ignore) 6: levelBackground as int?,
    });
  }
}

extension LocalLogQueryUpdate on IsarQuery<LocalLog> {
  _LocalLogQueryUpdate get updateFirst =>
      _LocalLogQueryUpdateImpl(this, limit: 1);

  _LocalLogQueryUpdate get updateAll => _LocalLogQueryUpdateImpl(this);
}

const _localLogLevel = {
  0: LocalLevel.trace,
  1: LocalLevel.debug,
  2: LocalLevel.info,
  3: LocalLevel.warning,
  4: LocalLevel.error,
  // ignore: deprecated_member_use_from_same_package
  5: LocalLevel.wtf,
  6: LocalLevel.fatal,
};

extension LocalLogQueryFilter
    on QueryBuilder<LocalLog, LocalLog, QFilterCondition> {
  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> messageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> messageGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      messageGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> messageLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      messageLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> messageBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> messageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> messageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> messageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> messageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> formattedEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> formattedGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      formattedGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> formattedLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      formattedLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> formattedBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> formattedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> formattedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> formattedContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> formattedMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> formattedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      formattedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> timestampEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> timestampGreaterThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      timestampGreaterThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> timestampLessThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      timestampLessThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> timestampBetween(
    DateTime lower,
    DateTime upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> levelEqualTo(
    LocalLevel value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> levelGreaterThan(
    LocalLevel value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      levelGreaterThanOrEqualTo(
    LocalLevel value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> levelLessThan(
    LocalLevel value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      levelLessThanOrEqualTo(
    LocalLevel value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> levelBetween(
    LocalLevel lower,
    LocalLevel upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower.index,
          upper: upper.index,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      levelForegroundEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      levelForegroundGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      levelForegroundGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      levelForegroundLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      levelForegroundLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      levelForegroundBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 5,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      levelBackgroundEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      levelBackgroundGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      levelBackgroundGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      levelBackgroundLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      levelBackgroundLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      levelBackgroundBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 6,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition>
      idGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> idLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> idLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 7,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 7,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }
}

extension LocalLogQueryObject
    on QueryBuilder<LocalLog, LocalLog, QFilterCondition> {}

extension LocalLogQuerySortBy on QueryBuilder<LocalLog, LocalLog, QSortBy> {
  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByMessageDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByFormatted(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByFormattedDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByLevelForeground() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByLevelForegroundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByLevelBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByLevelBackgroundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> sortByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension LocalLogQuerySortThenBy
    on QueryBuilder<LocalLog, LocalLog, QSortThenBy> {
  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByMessageDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByFormatted(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByFormattedDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByLevelForeground() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByLevelForegroundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByLevelBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByLevelBackgroundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterSortBy> thenByIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension LocalLogQueryWhereDistinct
    on QueryBuilder<LocalLog, LocalLog, QDistinct> {
  QueryBuilder<LocalLog, LocalLog, QAfterDistinct> distinctByMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterDistinct> distinctByFormatted(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterDistinct> distinctByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterDistinct> distinctByLevelForeground() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<LocalLog, LocalLog, QAfterDistinct> distinctByLevelBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }
}

extension LocalLogQueryProperty1
    on QueryBuilder<LocalLog, LocalLog, QProperty> {
  QueryBuilder<LocalLog, String, QAfterProperty> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<LocalLog, String, QAfterProperty> formattedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<LocalLog, DateTime, QAfterProperty> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<LocalLog, LocalLevel, QAfterProperty> levelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<LocalLog, int, QAfterProperty> levelForegroundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<LocalLog, int, QAfterProperty> levelBackgroundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<LocalLog, String, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}

extension LocalLogQueryProperty2<R>
    on QueryBuilder<LocalLog, R, QAfterProperty> {
  QueryBuilder<LocalLog, (R, String), QAfterProperty> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<LocalLog, (R, String), QAfterProperty> formattedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<LocalLog, (R, DateTime), QAfterProperty> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<LocalLog, (R, LocalLevel), QAfterProperty> levelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<LocalLog, (R, int), QAfterProperty> levelForegroundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<LocalLog, (R, int), QAfterProperty> levelBackgroundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<LocalLog, (R, String), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}

extension LocalLogQueryProperty3<R1, R2>
    on QueryBuilder<LocalLog, (R1, R2), QAfterProperty> {
  QueryBuilder<LocalLog, (R1, R2, String), QOperations> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<LocalLog, (R1, R2, String), QOperations> formattedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<LocalLog, (R1, R2, DateTime), QOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<LocalLog, (R1, R2, LocalLevel), QOperations> levelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<LocalLog, (R1, R2, int), QOperations> levelForegroundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<LocalLog, (R1, R2, int), QOperations> levelBackgroundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<LocalLog, (R1, R2, String), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}
