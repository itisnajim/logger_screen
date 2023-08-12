import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class PlatformSearchBar extends StatelessWidget {
  final Style style;
  final String hint;
  final TextEditingController? controller;

  const PlatformSearchBar({
    super.key,
    this.style = Style.platform,
    this.hint = 'Search',
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return style.isCupertino
        ? CupertinoSearchTextField(
            placeholder: hint,
            controller: controller,
          )
        : SearchBar(
            hintText: hint,
            controller: controller,
          );
  }
}
