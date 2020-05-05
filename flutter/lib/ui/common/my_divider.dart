import 'package:flutter/material.dart';
import 'package:palliative_chat/config/constants.dart';

class MyDivider extends StatelessWidget {
  final bool isVertical;
  final double height;
  final double padding;
  final Color color;

  const MyDivider.horizontal({
    this.padding = 0.0,
    this.color,
  })  : isVertical = false,
        height = 0.0;

  const MyDivider.horizontalTen({
    this.padding = 10.0,
    this.color,
  })  : isVertical = false,
        height = 0.0;

  const MyDivider.vertical(
    this.height, {
    this.padding = 0.0,
    this.color,
  }) : isVertical = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isVertical
          ? AppPadding.vertical(padding)
          : AppPadding.horizontal(padding),
      color: color ?? Colors.black12,
      width: isVertical ? 1.0 : null,
      height: isVertical ? height : 1.0,
    );
  }
}
