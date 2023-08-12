import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class PlatformCard extends StatelessWidget {
  final Widget child;
  final Style style;

  const PlatformCard({
    super.key,
    required this.child,
    this.style = Style.platform,
  });

  @override
  Widget build(BuildContext context) {
    return style.isCupertino
        ? _buildCupertinoCard(context)
        : _buildMaterialCard(context);
  }

  Color getBackgroundColor(BuildContext context) {
    try {
      return style.isCupertino
          ? CupertinoTheme.of(context).scaffoldBackgroundColor
          : Theme.of(context).scaffoldBackgroundColor;
    } catch (e) {
      try {
        return Theme.of(context).scaffoldBackgroundColor;
      } catch (e) {
        return Colors.white;
      }
    }
  }

  Widget _buildCupertinoCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: getBackgroundColor(context),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.25),
            blurRadius: 12.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildMaterialCard(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: child,
    );
  }
}
