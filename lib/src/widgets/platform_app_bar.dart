import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style.dart';

Widget platformAppBar(
  Style style, {
  String? title,
  List<Widget>? trailingActions,
}) {
  Text? titleText = title != null ? Text(title) : null;
  return style.isCupertino
      ? CupertinoNavigationBar(
          middle: titleText,
          trailing: (trailingActions?.length ?? 0) > 0
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: trailingActions!.map((e) => e).toList(),
                )
              : null,
        )
      : AppBar(title: titleText, actions: trailingActions);
}
