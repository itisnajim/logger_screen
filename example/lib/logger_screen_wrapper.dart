import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:logger_screen/logger_screen.dart';

enum ScreenStyle {
  material,
  cupertino,
  platform;

  bool get isCupertino {
    final targetPlatform = defaultTargetPlatform;
    return (this == ScreenStyle.platform &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(targetPlatform)) ||
        this == ScreenStyle.cupertino;
  }

  Style get toStyle => this == ScreenStyle.material
      ? Style.material
      : this == ScreenStyle.cupertino
          ? Style.cupertino
          : Style.platform;
}

class LoggerScreenWrapper extends StatelessWidget {
  final ScreenStyle screenStyle;
  final LoggerScreenPrinter printer;

  const LoggerScreenWrapper({
    super.key,
    required this.printer,
    required this.screenStyle,
  });

  Future<void> _printRandomLog(Logger logger) async {
    final randomLevel =
        Log.usedLevelValues[Random().nextInt(Log.usedLevelValues.length)];
    final randomMessage =
        'Random log ${Random().nextDouble().toStringAsFixed(2)} ${randomLevel.name}';
    logger.log(randomLevel, randomMessage);
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LoggerScreen(
        printer: printer,
        style: screenStyle.toStyle,
        numberOfColumns: 1,
        trailingActions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _printRandomLog(Logger(printer: printer));
            },
          ),
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              // Clear logs action
              printer.clear();
            },
          ),
        ],
      ),
    );
  }
}
