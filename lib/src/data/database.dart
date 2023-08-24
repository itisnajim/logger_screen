import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import 'database_directory_path.dart';

class Database {
  final String name;
  final String? encryptionKey;
  final List<IsarGeneratedSchema> schemas;

  /// Creates an instance of [Database].
  ///
  /// The [schemas] parameter is a list of collection schemas to be used by the database.
  /// The [name] parameter specifies the name of the database (optional, default is "logs").
  const Database({
    required this.schemas,
    this.name = "logs",
    this.encryptionKey,
  });

  /// Opens the database and returns an instance of [Isar].
  ///
  /// If the database is not yet open, this method will initialize the database and return the instance.
  /// If the database is already open, the existing instance will be returned.
  ///
  /// Returns a [Future] that resolves to the [Isar] instance.
  FutureOr<Isar> open() {
    Isar? instance;
    // try to get an already opened instance if exists
    try {
      instance = Isar.get(name: name, schemas: schemas);
    } catch (e) {
      debugPrint("The Isar instance hasn't been created yet");
    }
    if (instance != null) return instance;

    final pathFuture = Future.value(DatabaseDirectoryPath().getPath());
    return pathFuture.then(
      (directory) => Isar.open(
        schemas: schemas,
        name: name,
        encryptionKey: encryptionKey,
        engine: IsarEngine.sqlite,
        maxSizeMiB: 512,
        // set to true to enable the inspector
        inspector: false,
        directory: directory,
      ),
    );
  }

  Future<T?> get<ID, T>(ID id) async {
    final isar = await open();
    return isar.collection<ID, T>().get(id);
  }

  Future<IsarCollection<ID, T>> collection<ID, T>() async {
    final isar = await open();
    return isar.collection<ID, T>();
  }

  Future<List<T?>> getMany<ID, T>(List<ID> ids) async {
    final isar = await open();
    return isar.collection<ID, T>().getAll(ids);
  }

  Future<List<T>> getAll<ID, T>({int? offset, int? limit}) async {
    final isar = await open();
    return isar
        .collection<ID, T>()
        .where()
        .findAll(offset: offset, limit: limit);
  }

  Future<void> set<ID, T>(T object) async {
    final isar = await open();
    return isar.writeAsync((isar) => isar.collection<ID, T>().put(object));
  }

  // Isar web always returns true.
  Future<bool> delete<ID, T>(ID id) async {
    final isar = await open();
    return isar.writeAsync((isar) => isar.collection<ID, T>().delete(id));
  }

  Future<void> clear<ID, T>() async {
    final isar = await open();
    return isar.writeAsync((isar) => isar.collection<ID, T>().clear());
  }

  Future<int> count<ID, T>() async {
    final isar = await open();
    return isar.collection<ID, T>().count();
  }
}
