import 'package:flutter/material.dart';
import 'package:palliative_chat/config/constants.dart';

import 'base_screen.dart';
import 'buttons.dart';
import 'texts.dart';

abstract class BaseDialog extends StatefulBaseScreen {
  BaseDialog({Key key}) : super(key: key);
}

abstract class BaseDialogState<T extends BaseDialog> extends BaseState<T> {
  ///
  var widthInfoFull = 240.0;

  ///
  @protected
  title({String text}) {
    return Container(
      padding: AppPadding.exceptBottomNormal,
      alignment: Alignment.center,
      child: Texts(
        text,
        isCenter: true,
        textSize: AppSize.fontNormal,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @protected
  subTitle({String text, bool isCenter = false}) {
    return Container(
      alignment: isCenter ? Alignment.center : Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        vertical: AppSize.paddingMedium,
      ),
      child: Texts(text),
    );
  }

  @protected
  actionButton({String text, Function onPressed}) {
    return Padding(
      padding: AppPadding.allZero,
      child: Buttons.blue(
        text: text,
        onPressed: onPressed,
      ),
    );
  }

  @protected
  okButton({Function onPressed}) {
    return actionButton(
      text: 'Ok',
      onPressed: onPressed,
    );
  }

  @protected
  Widget twoButtons({
    String textLeft,
    String textRight,
    Function onPressedLeft,
    Function onPressedRight,
    bool negativeRight = false,
    bool negativeLeft = false,
    bool dangerousRight = false,
    bool dangerousLeft = false,
  }) {
    if (textLeft == null) {
      textLeft = 'Отмена';
    }

    if (textRight == null) {
      textRight = 'Ok';
    }

    Color _buttonTextColor(bool negative, bool dangerous) {
      if (negative) {
        return Colors.red;
      } else if (dangerous) {
        return Colors.red;
      } else {
        return Colors.black;
      }
    }

    return Padding(
      padding: AppPadding.horizontalMedium,
      child: Padding(
        padding: AppPadding.bottom(6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Buttons.flat(
                text: textLeft,
                onPressed: onPressedLeft ?? close,
              ),
            ),
            Padding(
              padding: AppPadding.rightMedium,
            ),
            Expanded(
              child: Buttons.blue(
                text: textRight,
                onPressed: onPressedRight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @protected
  returnBack(Object object) {
    Navigator.pop(context, object);
  }

  @protected
  close() {
    Navigator.pop(context);
  }

  @protected
  List<Widget> widgets(List<Widget> widgets) {
    return widgets..removeWhere((w) => w == null);
  }
}
