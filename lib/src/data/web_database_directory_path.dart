import 'dart:async';

import 'database_directory_path.dart';

class WebDatabaseDirectoryPath implements DatabaseDirectoryPath {
  @override
  FutureOr<String> getPath() => "/assets/db";
}

DatabaseDirectoryPath getDatabaseDirectoryPath() => WebDatabaseDirectoryPath();
