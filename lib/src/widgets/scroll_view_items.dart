import 'package:flutter/material.dart';

class ScrollViewItems extends StatelessWidget {
  final Widget? Function(BuildContext, int) itemBuilder;
  final int? itemCount;
  final EdgeInsetsGeometry? padding;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final int numberOfColumns;
  final SliverGridDelegate? gridDelegate;

  const ScrollViewItems({
    super.key,
    required this.itemBuilder,
    this.itemCount,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
    this.controller,
    this.numberOfColumns = 1,
    this.gridDelegate,
  }) : assert(numberOfColumns > 0,
            '`numberOfColumns` should be positive and not zero!');

  @override
  Widget build(BuildContext context) {
    final columns = numberOfColumns;
    if (columns > 1) {
      return GridView.builder(
        controller: controller,
        padding: padding,
        gridDelegate: gridDelegate ??
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 10,
            ),
        scrollDirection: scrollDirection,
        shrinkWrap: shrinkWrap,
        physics: physics,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      );
    } else {
      return ListView.builder(
        controller: controller,
        padding: padding,
        scrollDirection: scrollDirection,
        shrinkWrap: shrinkWrap,
        physics: physics,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      );
    }
  }
}
