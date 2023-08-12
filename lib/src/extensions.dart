import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart' show Level, AnsiColor;

extension AnsiColorExt on AnsiColor {
  Color? get foregroundColor {
    return fg != null ? _ansiColorToColor(fg!) : null;
  }

  Color? get backgroundColor {
    return bg != null ? _ansiColorToColor(bg!) : null;
  }

  static Color _ansiColorToColor(int ansiColor) {
    if (ansiColor < 16) {
      // system colors
      if (ansiColor == 7) return const Color.fromARGB(255, 0xc0, 0xc0, 0xc0);
      if (ansiColor == 8) return const Color.fromARGB(255, 0x80, 0x80, 0x80);

      final intensity = ansiColor < 8 ? 0x80 : 0xff;
      ansiColor %= 8; // makes the matching simpler
      return Color.fromARGB(
        255,
        [1, 3, 5, 7].contains(ansiColor) ? intensity : 0x00,
        [2, 3, 6, 7].contains(ansiColor) ? intensity : 0x00,
        [4, 5, 6, 7].contains(ansiColor) ? intensity : 0x00,
      );
    }

    if (ansiColor > 231) {
      // greyscale
      return Color.fromARGB(
        255,
        0x08 + ((ansiColor - 232) * 10),
        0x08 + ((ansiColor - 232) * 10),
        0x08 + ((ansiColor - 232) * 10),
      );
    }

    List<int> intensities = [0x00, 0x5f, 0x87, 0xaf, 0xd7, 0xff];
    ansiColor -= 16; // makes the math simpler
    int r = intensities[ansiColor ~/ 36];
    int g = intensities[(ansiColor % 36) ~/ 6];
    int b = intensities[(ansiColor % 36) % 6];

    return Color.fromARGB(255, r, g, b);
  }
}

extension LevelExt on Level {
  AnsiColor ansiColor(Map<Level, AnsiColor> colors) =>
      colors[this] ?? const AnsiColor.none();

  Color? foregroundColor(Map<Level, AnsiColor> colors) =>
      ansiColor(colors).foregroundColor;

  Color? backgroundColor(Map<Level, AnsiColor> colors) =>
      ansiColor(colors).backgroundColor;
}

extension StringExt on String {
  String get capitalize =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
}

extension LevelCountMapExt on Map<Level?, int> {
  // Level null (all) always included
  Map<Level?, int> get notZero => Map.fromEntries(
        entries.where((entry) => entry.value != 0 || entry.key == null),
      );
}
