import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class PlatformCircularProgressIndicator extends StatelessWidget {
  final Style style;

  const PlatformCircularProgressIndicator({
    super.key,
    this.style = Style.platform,
  });

  @override
  Widget build(BuildContext context) {
    return style.isCupertino
        ? const CupertinoActivityIndicator()
        : const CircularProgressIndicator();
  }
}
