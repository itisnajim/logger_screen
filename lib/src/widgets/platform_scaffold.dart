import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_app_bar.dart';
import '../style.dart';

// Usage Example:
// PlatformScaffold(
//   appBar: AppBar(title: Text('My App')),
//   body: Center(child: Text('Hello, World!')),
// );
class PlatformScaffold extends StatelessWidget {
  final Style style;
  final String? title;
  final Widget body;
  final List<Widget>? trailingActions;

  const PlatformScaffold({
    super.key,
    this.title,
    required this.body,
    this.trailingActions,
    this.style = Style.platform,
  });

  @override
  Widget build(BuildContext context) {
    return style.isCupertino
        ? CupertinoPageScaffold(
            navigationBar: platformAppBar(
              Style.cupertino,
              title: title,
              trailingActions: trailingActions,
            ) as ObstructingPreferredSizeWidget?,
            child: body,
          )
        : Scaffold(
            appBar: platformAppBar(
              Style.material,
              title: title,
              trailingActions: trailingActions,
            ) as PreferredSizeWidget?,
            body: body,
          );
  }
}
