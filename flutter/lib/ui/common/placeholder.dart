import 'package:flutter/material.dart';
import 'package:palliative_chat/config/constants.dart';
import 'package:palliative_chat/ui/common/texts.dart';

class MyPlaceholder extends StatelessWidget {
  final String text;
  final IconData icon;

  const MyPlaceholder({
    Key key,
    this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.black26,
            size: 40.0,
          ),
          Padding(
            padding: AppPadding.exceptBottomNormal,
            child: Texts(
              text,
              color: Colors.black26,
              textSize: AppSize.fontNormal,
              isCenter: true,
            ),
          ),
        ],
      ),
    );
  }
}
