import 'package:logger/logger.dart' show Level;

class Filter {
  final int page;
  final int size;
  final String? search;

  /// null means all levels are selected.
  final Level? level;

  const Filter({
    this.page = 1,
    this.size = 50,
    this.search,
    this.level,
  });

  int get offset => (page - 1) * size;
  int get limit => size;

  Filter copyWith({
    int? page,
    int? size,
    String? search,
    Level? level,
  }) {
    return Filter(
      page: page ?? this.page,
      size: size ?? this.size,
      search: search ?? this.search,
      level: level ?? this.level,
    );
  }

  Filter copyWithLevel(Level? level) => Filter(
        page: page,
        size: size,
        search: search,
        level: level,
      );

  Filter copyWithPage(int page) => Filter(
        page: page,
        size: size,
        search: search,
        level: level,
      );

  Filter copyWithSearch(String? search) => Filter(
        page: page,
        size: size,
        search: search,
        level: level,
      );
}
