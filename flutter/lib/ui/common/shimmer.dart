import 'package:flutter/material.dart';
import 'package:palliative_chat/config/constants.dart';
import 'package:shimmer/shimmer.dart' as Lib;

const _defaultHeight = 20.0;
const _borderRadius = 4.0;

class Shimmer extends StatelessWidget {
  final double width;
  final double height;
  final bool rounded;

  const Shimmer({
    this.width,
    this.height = _defaultHeight,
    this.rounded = true,
    Key key,
  }) : super(key: key);

  const Shimmer.normal({
    this.width,
    this.height = AppSize.paddingNormal,
    this.rounded = true,
    Key key,
  }) : super(key: key);

  const Shimmer.medium({
    this.width,
    this.height = AppSize.paddingMedium,
    this.rounded = true,
    Key key,
  }) : super(key: key);

  const Shimmer.small({
    this.width,
    this.height = AppSize.paddingSmall,
    this.rounded = true,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lib.Shimmer.fromColors(
      baseColor: Colors.white30,
      highlightColor: Colors.white12,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: rounded
              ? BorderRadius.circular(_borderRadius)
              : BorderRadius.zero,
          color: Colors.white30,
        ),
        height: height,
        width: width,
      ),
    );
  }
}
