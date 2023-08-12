import 'dart:async';

import 'package:path_provider/path_provider.dart';

import 'database_directory_path.dart';

class IoDatabaseDirectoryPath implements DatabaseDirectoryPath {
  @override
  FutureOr<String> getPath() =>
      getApplicationDocumentsDirectory().then((value) => value.path);
}

DatabaseDirectoryPath getDatabaseDirectoryPath() => IoDatabaseDirectoryPath();
