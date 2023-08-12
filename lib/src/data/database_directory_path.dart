import 'dart:async';

import 'database_directory_path_stub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'io_database_directory_path.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'web_database_directory_path.dart';

abstract class DatabaseDirectoryPath {
  FutureOr<String> getPath();

  factory DatabaseDirectoryPath() => getDatabaseDirectoryPath();
}
