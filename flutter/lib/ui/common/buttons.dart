import 'package:flutter/material.dart';
import 'package:palliative_chat/config/constants.dart';

import 'texts.dart';

const _defaultTextColor = Colors.black;
const _defaultTextDisabledColor = Colors.black;
const _defaultTextSize = AppSize.fontSmall;
const _defaultButtonHeight = AppSize.buttonHeight;
const _defaultFontWeight = FontWeight.bold;
const _defaultFontWeightDisabled = FontWeight.normal;
const _defaultButtonColor = AppColors.blue;
const _defaultButtonDisabledColor = AppColors.blueTransparent;
const _defaultIconColor = Colors.white;
const _defaultIconColorRed = AppColors.redOpacity50;

class Buttons extends StatelessWidget {
  //
  final GlobalKey key;
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final Color textDisabledColor;
  final double margin;
  final bool wrapContent;
  final double width;
  final double textSize;
  final double height;
  final bool progress;
  final bool outlined;
  final bool transparent;
  final bool flat;
  final String iconPath;
  final IconData iconData;
  final FontWeight fontWeight;
  final FontWeight fontWeightDisabled;
  final Color buttonColor;
  final Color buttonDisabledColor;
  final bool iconTrailing;
  final bool isRed;
  final bool noCaps;
  final Color borderColor;

  const Buttons({
    this.key,
    this.text,
    this.onPressed,
    this.textColor,
    this.textDisabledColor,
    this.margin = 0.0,
    this.wrapContent = false,
    this.width,
    this.textSize,
    this.height,
    this.progress = false,
    this.outlined = false,
    this.transparent = false,
    this.flat = false,
    this.iconPath,
    this.iconData,
    this.fontWeight,
    this.fontWeightDisabled,
    this.buttonColor,
    this.buttonDisabledColor,
    this.iconTrailing = false,
    //this.iconColor,
    this.isRed = false,
    this.noCaps = false,
    this.borderColor,
  });

  const Buttons.blue({
    key,
    text,
    onPressed,
    progress = false,
    iconData,
    double textSize,
  }) : this(
          key: key,
          text: text,
          onPressed: onPressed,
          buttonColor: AppColors.blue,
          progress: progress,
          iconData: iconData,
          textSize: textSize,
        );

  const Buttons.red({
    key,
    text,
    onPressed,
    progress = false,
  }) : this(
          key: key,
          text: text,
          onPressed: onPressed,
          buttonColor: AppColors.red,
          progress: progress,
          isRed: true,
        );

  const Buttons.green({
    key,
    text,
    onPressed,
    progress = false,
  }) : this(
          key: key,
          text: text,
          onPressed: onPressed,
          buttonColor: AppColors.green,
          progress: progress,
        );

  const Buttons.flat({
    key,
    text,
    iconData,
    onPressed,
    progress = false,
    wrapContent = false,
    buttonColor,
    textColor,
    double textSize,
    FontWeight fontWeight,
    double height,
  }) : this(
          key: key,
          text: text,
          flat: true,
          iconData: iconData,
          onPressed: onPressed,
          buttonColor: buttonColor ?? Colors.white10,
          buttonDisabledColor: AppColors.white5,
          progress: progress,
          wrapContent: wrapContent,
          textColor: textColor,
          textSize: textSize,
          fontWeight: fontWeight,
          height: height,
        );

  const Buttons.flatSmall({
    iconData,
    text,
    key,
    onPressed,
    progress = false,
    wrapContent = false,
    buttonColor,
    textColor,
    fontWeight,
    iconTrailing = false,
    double textSize,
  }) : this(
          key: key,
          text: text,
          iconData: iconData,
          onPressed: onPressed,
          progress: progress,
          wrapContent: wrapContent,
          flat: true,
          buttonColor: buttonColor ?? Colors.white10,
          height: AppSize.buttonHeightSmall,
          textColor: textColor ?? Colors.white54,
          textSize: textSize ?? AppSize.fontSmall,
          fontWeight: fontWeight ?? FontWeight.w600,
          iconTrailing: iconTrailing,
        );

  const Buttons.flatSmallRed({
    iconData,
    text,
    key,
    onPressed,
    progress = false,
    wrapContent = false,
  }) : this(
          key: key,
          text: text,
          iconData: iconData,
          onPressed: onPressed,
          progress: progress,
          wrapContent: wrapContent,
          flat: true,
          buttonColor: Colors.white10,
          height: AppSize.buttonHeightSmall,
          textColor: AppColors.redOpacity50,
          textSize: AppSize.fontSmall,
          fontWeight: FontWeight.w600,
          iconTrailing: true,
          isRed: true,
        );

  const Buttons.flatRed({
    iconData,
    text,
    key,
    onPressed,
    progress = false,
    wrapContent = false,
    double textSize,
  }) : this(
          key: key,
          text: text,
          iconData: iconData,
          onPressed: onPressed,
          progress: progress,
          wrapContent: wrapContent,
          flat: true,
          buttonColor: AppColors.white5,
          height: AppSize.buttonHeightSmall,
          textColor: AppColors.redOpacity50,
          textSize: textSize,
          fontWeight: FontWeight.w600,
          iconTrailing: true,
          isRed: true,
        );

  Buttons.outlined({
    String text,
    VoidCallback onPressed,
    Color borderColor,
    Color textColor,
    bool progress = false,
    double textSize,
  }) : this(
          text: text,
          outlined: true,
          onPressed: onPressed,
          borderColor: borderColor,
          textColor: textColor,
          progress: progress,
          textSize: textSize,
        );

  Buttons.transparent({
    String text,
    VoidCallback onPressed,
    bool noCaps = false,
  }) : this(
          text: text,
          transparent: true,
          noCaps: noCaps,
          onPressed: onPressed,
        );

  @override
  Widget build(BuildContext context) {
    if (wrapContent == true && width != null) {
      throw new Exception("if width != null, then wrapContent should be false");
    }

    double minWidth;
    if (wrapContent) {
      minWidth = 0.0;
    } else if (width != null) {
      minWidth = width;
    } else {
      minWidth = AppSize.buttonWidth;
    }

    var shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    );
    var child = _content();

    var button;
    if (outlined) {
      button = OutlineButton(
        padding: AppPadding.allZero,
        key: key,
        borderSide: BorderSide(
          width: 0.5,
          color: borderColor ?? AppColors.blue,
          style: BorderStyle.solid,
        ),
        disabledBorderColor: buttonDisabledColor ?? _defaultButtonDisabledColor,
        color: buttonColor ?? _defaultButtonColor,
        shape: shape,
        onPressed: onPressed,
        child: child,
      );
    } else if (flat) {
      button = FlatButton(
        padding: AppPadding.allZero,
        key: key,
        disabledColor: buttonDisabledColor ?? _defaultButtonDisabledColor,
        color: buttonColor ?? _defaultButtonColor,
        shape: shape,
        onPressed: onPressed,
        child: child,
      );
    } else if (transparent) {
      button = FlatButton(
        padding: AppPadding.allZero,
        key: key,
        disabledColor: buttonDisabledColor ?? _defaultButtonDisabledColor,
        color: Colors.transparent,
        shape: shape,
        onPressed: onPressed,
        child: child,
      );
    } else {
      button = RaisedButton(
        padding: AppPadding.allZero,
        key: key,
        disabledColor: buttonDisabledColor ?? _defaultButtonDisabledColor,
        color: buttonColor ?? _defaultButtonColor,
        shape: shape,
        onPressed: onPressed,
        child: child,
      );
    }

    return ButtonTheme(
      minWidth: minWidth,
      height: height ?? _defaultButtonHeight,
      child: button,
    );
  }

  //
  Widget _content() {
    var widgets;
    var color = onPressed == null
        ? textDisabledColor ?? _defaultTextDisabledColor
        : textColor ?? _defaultTextColor;

    if (progress) {
      widgets = [
        SizedBox(
          width: 16.0,
          height: 16.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeWidth: 1.5,
          ),
        )
      ];
    } else {
      var iconByPath = iconPath != null
          ? Padding(
              padding: AppPadding.horizontalMicro,
              child: Image(
                image: AssetImage(iconPath),
                width: 16.0,
                height: 16.0,
                color:
                    (isRed && flat) ? _defaultIconColorRed : _defaultIconColor,
              ),
            )
          : null;

      var iconByData = iconData != null
          ? Padding(
              padding: AppPadding.horizontalMicro,
              child: Icon(
                iconData,
                size: 16.0,
                color:
                    (isRed && flat) ? _defaultIconColorRed : _defaultIconColor,
              ),
            )
          : null;

      widgets = [
        if (iconPath != null && !iconTrailing) iconByPath,
        if (iconData != null && !iconTrailing) iconByData,
        if (text != null)
          Texts(
            noCaps ? text : text.toUpperCase(),
            color: color,
            textSize: textSize ?? _defaultTextSize,
            fontWeight: onPressed == null
                ? fontWeightDisabled ?? _defaultFontWeightDisabled
                : fontWeight ?? _defaultFontWeight,
          ),
        if (iconData != null && iconTrailing) iconByData,
        if (iconPath != null && iconTrailing) iconByPath,
      ];
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }
}
