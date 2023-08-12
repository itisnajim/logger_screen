import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart' show Level;

import 'entity/filter.dart';
import 'style.dart';
import 'extensions.dart';
import 'entity/log.dart';
import 'logger_screen_printer.dart';
import 'widgets/platform_card.dart';
import 'widgets/platform_circular_progress_indicator.dart';
import 'widgets/platform_scaffold.dart';
import 'widgets/platform_search_bar.dart';
import 'widgets/scroll_view_items.dart';

/// The `LoggerScreen` widget displays logs in a user-friendly manner with the
/// ability to filter and search logs. It listens to a `LoggerScreenPrinter`
/// for new log entries and updates the log list accordingly. You can customize
/// the appearance and behavior of the logs using various properties and
/// callbacks provided by this widget.
///
/// Use the [printer] parameter to pass an instance of `LoggerScreenPrinter`
/// that you want to listen to for log updates. The [itemBuilder] callback
/// allows you to customize the appearance of individual log entries.
///
/// If [numberOfColumns] is greater than 1, the logs will be displayed in a grid
/// layout with the specified number of columns using the [gridDelegate].
///
/// The [style] parameter is used to customize the appearance of the `LoggerScreen`.
/// You can choose between three styles: [Style.material], [Style.cupertino], or
/// [Style.platform]. The [Style.material] style provides a Material Design
/// appearance, [Style.cupertino] provides an iOS-style appearance, and [Style.platform]
/// adapts the appearance based on the platform (Material on Android, Cupertino on iOS).
///
/// The [title] parameter is used to set the title of the `LoggerScreen` displayed
/// in the app bar.
///
/// The [trailingActions] parameter allows you to provide additional widgets that
/// will be displayed at the trailing end of the app bar. These widgets can be used
/// to add custom actions, buttons, or icons related to log management.
///
/// Example usage:
/// ```dart
/// LoggerScreen(
///   printer: myLoggerPrinter,
///   itemBuilder: (context, log, index) {
///     // Custom log item widget
///     return MyCustomLogItem(log: log);
///   },
///   numberOfColumns: 2,
///   style: Style.platform,
///   title: "My Logs",
///   trailingActions: [
///     IconButton(
///       icon: Icon(Icons.clear_all),
///       onPressed: () {
///         // Clear logs action
///         myLoggerPrinter.clear();
///       },
///     ),
///   ],
/// )
/// ```
class LoggerScreen extends StatefulWidget {
  /// The instance of `LoggerScreenPrinter` that provides log entries to display.
  final LoggerScreenPrinter printer;

  /// A callback that allows you to customize the appearance of individual log entries.
  /// The `BuildContext`, the log entry (`Log` object), and its index in the list
  /// are provided as parameters to the callback.
  final Widget? Function(BuildContext context, Log log, int index)? itemBuilder;

  /// The number of columns to display the logs in a grid layout. If `numberOfColumns`
  /// is greater than 1, the logs will be displayed in a grid with the specified
  /// number of columns using the [gridDelegate].
  final int numberOfColumns;

  /// A delegate that controls the layout of the grid if [numberOfColumns] is greater than 1.
  /// If null, a default grid delegate will be used.
  final SliverGridDelegate? gridDelegate;

  /// The style to customize the appearance of the `LoggerScreen`. You can choose
  /// between [Style.material], [Style.cupertino], or [Style.platform]. The [Style.material]
  /// style provides a Material Design appearance, [Style.cupertino] provides an iOS-style
  /// appearance, and [Style.platform] adapts the appearance based on the platform
  /// (Material on Android, Cupertino on iOS).
  final Style style; // enum Style { material, cupertino, platform;

  /// The title displayed in the app bar of the `LoggerScreen`.
  final String title;

  /// Additional widgets displayed at the trailing end of the app bar. You can use
  /// these widgets to add custom actions, buttons, or icons related to log management.
  final List<Widget> trailingActions;

  /// Creates a new `LoggerScreen` widget.
  ///
  /// The [printer] parameter is required. It specifies
  /// the instance of `LoggerScreenPrinter` that will provide log entries to display.
  ///
  /// The [itemBuilder] parameter is an optional callback that allows you to
  /// customize the appearance of individual log entries. If provided, the callback
  /// will be called for each log entry to build a custom widget representing that log.
  ///
  /// The [numberOfColumns] parameter specifies the number of columns in which the
  /// logs will be displayed when using a grid layout. By default, logs are displayed
  /// in a single-column layout.
  ///
  /// The [gridDelegate] parameter allows you to provide a custom grid delegate
  /// to control the layout of the logs when [numberOfColumns] is greater than 1.
  ///
  /// The [style] parameter allows you to customize the appearance of the `LoggerScreen`.
  /// You can choose between three styles: [Style.material], [Style.cupertino], or
  /// [Style.platform]. The [Style.material] style provides a Material Design
  /// appearance, [Style.cupertino] provides an iOS-style appearance, and [Style.platform]
  /// adapts the appearance based on the platform (Material on Android, Cupertino on iOS).
  ///
  /// The [title] parameter allows you to set the title of the `LoggerScreen`
  /// displayed in the app bar.
  ///
  /// The [trailingActions] parameter allows you to provide additional widgets that
  /// will be displayed at the trailing end of the app bar. These widgets can be used
  /// to add custom actions, buttons, or icons related to log management.
  const LoggerScreen({
    super.key,
    required this.printer,
    this.itemBuilder,
    this.numberOfColumns = 1,
    this.gridDelegate,
    this.style = Style.platform,
    this.title = "Logs",
    this.trailingActions = const [],
  });

  @override
  State<LoggerScreen> createState() => _LoggerScreenState();
}

class _LoggerScreenState extends State<LoggerScreen> {
  final ScrollController _scrollController = ScrollController();

  StreamSubscription? _logsStreamSubscription;
  StreamSubscription? _resetStreamSubscription;

  List<Log> _logs = [];

  late Filter _filter;
  bool _isLoading = true;
  Map<Level?, int> _levelsCounts = {
    null: 0,
    ...Map.fromEntries(Log.usedLevelValues.map((l) => MapEntry(l, 0))),
  };

  @override
  void initState() {
    super.initState();
    _filter = const Filter();
    _textEditingController.addListener(_onTextChanged);

    widget.printer.initialize().then((logs) {
      _logs = List.from(logs);
      _isLoading = false;
    });
    // assign count to each level!
    widget.printer.getLevelCountMap().then(
          (map) => setState(
            () => _levelsCounts = map,
          ),
        );
    _logsStreamSubscription = widget.printer.logsStream.listen(
      (log) => setState(
        () {
          _logs = widget.printer.logs;
          /*if (widget.printer.isValidToFilter(log, _filter)) {
            _logs.insert(0, log);
          }*/

          _levelsCounts = widget.printer.levelsCounts;
        },
      ),
    );
    _resetStreamSubscription = widget.printer.resetStream.listen((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _logs.clear();
        _levelsCounts = {
          null: 0,
          ...Map.fromEntries(Log.usedLevelValues.map((l) => MapEntry(l, 0))),
        };
        _filter = const Filter();
        _isLoading = false;
        setState(() {});
      });
    });
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _filterLogs() async {
    setState(() {
      _isLoading = true;
    });

    await widget.printer.applyFilter(_filter);
    _logs = widget.printer.logs;
    _levelsCounts = widget.printer.levelsCounts;
    setState(() {
      _isLoading = false;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // If the user reaches the end of the list, load more logs
      _loadMoreLogs();
    }
  }

  void _loadMoreLogs() {
    final nextPage = _filter.page + 1;
    _filter = _filter.copyWithPage(nextPage);
    _filterLogs();
  }

  @override
  void dispose() {
    _logsStreamSubscription?.cancel();
    _resetStreamSubscription?.cancel();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();

    _textEditingController.removeListener(_onTextChanged);
    _textEditingController.dispose();
    _debounce?.cancel();

    super.dispose();
  }

  String formatDateTime(DateTime dateTime) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitYear(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String year = twoDigitYear(dateTime.year % 100);
    String month = twoDigits(dateTime.month);
    String day = twoDigits(dateTime.day);
    String hour = twoDigits(dateTime.hour);
    String minute = twoDigits(dateTime.minute);
    String second = twoDigits(dateTime.second);

    return '$year-$month-$day $hour:$minute:$second';
  }

  final TextEditingController _textEditingController = TextEditingController();
  Timer? _debounce;

  void _onTextChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      final newText = _textEditingController.text;
      final search = newText.trim().isEmpty ? null : newText.trim();
      _filter = _filter.copyWithSearch(search);
      _filterLogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget listItem(Log log) {
      return PlatformCard(
        style: widget.style,
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatDateTime(log.timestamp),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: log.levelBackgroundColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  log.level.name.toUpperCase(),
                  style: TextStyle(
                    color: log.levelForegroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Text(
            log.message.toString(),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          children: [
            SelectableText(
              log.formatted,
            ),
          ],
        ),
      );
    }

    Widget gridItem(Log log) {
      return PlatformCard(
        style: widget.style,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: log.levelBackgroundColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  log.level.name.toUpperCase(),
                  style: TextStyle(
                    color: log.levelForegroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                log.message.toString(),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                formatDateTime(log.timestamp),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: SelectableText(
                    log.formatted,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return PlatformScaffold(
      style: widget.style,
      title: widget.title,
      trailingActions: widget.trailingActions,
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: PlatformSearchBar(
                        style: widget.style,
                        controller: _textEditingController,
                      ),
                    ),
                    SizedBox(
                      height: 36,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: _levelsCounts.length,
                        itemBuilder: (context, index) {
                          final level = _levelsCounts.entries.toList()[index];
                          return _buildActionChip(
                            context,
                            level: level.key,
                            count: level.value,
                          );
                        },
                        separatorBuilder: (_, index) => index == 0
                            ? const Row(
                                children: [
                                  SizedBox(width: 6),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: VerticalDivider(),
                                  ),
                                  SizedBox(width: 6),
                                ],
                              )
                            : const SizedBox(width: 16),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ScrollViewItems(
                        controller: _scrollController,
                        itemCount: _logs.length,
                        gridDelegate: widget.gridDelegate,
                        padding: EdgeInsets.only(
                          right: widget.numberOfColumns > 1 ? 8 : 0,
                          left: widget.numberOfColumns > 1 ? 8 : 0,
                          top: 8,
                          bottom: 24,
                        ),
                        numberOfColumns: widget.numberOfColumns,
                        itemBuilder: (context, index) {
                          final log = _logs[index];
                          return widget.itemBuilder != null
                              ? widget.itemBuilder!(context, log, index)
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        widget.numberOfColumns == 1 ? 16 : 0,
                                    vertical: 4,
                                  ),
                                  child: widget.numberOfColumns == 1
                                      ? listItem(log)
                                      : gridItem(log),
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (_isLoading)
                Positioned.fill(
                  child: Container(
                    color: getBackgroundColor(context)?.withOpacity(0.7),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: PlatformCircularProgressIndicator(
                          style: widget.style),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Color getPrimaryColor(BuildContext context) {
    try {
      return widget.style.isCupertino
          ? CupertinoTheme.of(context).primaryColor
          : Theme.of(context).colorScheme.primary;
    } catch (e) {
      try {
        return Theme.of(context).colorScheme.primary;
      } catch (e) {
        return Colors.blue;
      }
    }
  }

  Color getOnPrimaryColor(BuildContext context) {
    try {
      return widget.style.isCupertino
          ? CupertinoTheme.of(context).primaryContrastingColor
          : Theme.of(context).colorScheme.onPrimary;
    } catch (e) {
      try {
        return Theme.of(context).colorScheme.onPrimary;
      } catch (e) {
        return Colors.white;
      }
    }
  }

  Color? getBackgroundColor(BuildContext context) {
    try {
      return widget.style.isCupertino
          ? CupertinoTheme.of(context).scaffoldBackgroundColor
          : Theme.of(context).scaffoldBackgroundColor;
    } catch (e) {
      try {
        return Theme.of(context).scaffoldBackgroundColor;
      } catch (e) {
        return Colors.grey[300];
      }
    }
  }

  Color? getOnBackgroundColor(BuildContext context) {
    try {
      return widget.style.isCupertino
          ? CupertinoTheme.of(context).textTheme.textStyle.color
          : Theme.of(context).colorScheme.onBackground;
    } catch (e) {
      try {
        return Theme.of(context).colorScheme.onBackground;
      } catch (e) {
        return Colors.black;
      }
    }
  }

  Widget _buildActionChip(
    BuildContext context, {
    Level? level,
    required int count,
  }) {
    final isSelected = level == _filter.level;

    return ActionChip(
      label: Text('${(level?.name ?? 'All').capitalize} ($count)'),
      onPressed: () {
        _filter = _filter.copyWithPage(1);
        _filter = _filter.copyWithLevel(level);
        _filterLogs();
      },
      backgroundColor:
          isSelected ? getPrimaryColor(context) : getBackgroundColor(context),
      labelStyle: TextStyle(
        color: isSelected
            ? getOnPrimaryColor(context)
            : getOnBackgroundColor(context),
      ),
    );
  }
}
