import 'package:flutter/foundation.dart';

/// Enum to represent different styles for a widget.
enum Style {
  material,
  cupertino,
  platform;

  /// Getter method to determine if the current style represents the Cupertino style.
  /// If the style is 'platform', it checks whether the platform is iOS, macOS, or Linux,
  /// and if so, returns true. Otherwise, if the style is 'cupertino', it also returns true.
  bool get isCupertino {
    final targetPlatform = defaultTargetPlatform;
    return (this == Style.platform &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(targetPlatform)) ||
        this == Style.cupertino;
  }
}
