import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:palliative_chat/config/constants.dart';

const _defaultTextColor = Colors.black;
const _defaultTextLinkColor = AppColors.blue;
const _defaultTextLinkColorDisabled = Colors.white54;
const _defaultTextSize = AppSize.fontRegular;
const _defaultFontWeight = FontWeight.w500;

class Texts extends StatelessWidget {
  //
  final String text;
  final Color color;
  final double textSize;
  final bool isCenter;
  final bool isRight;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  final int maxLines;
  final double height;
  final double letterSpacing;
  final bool capitalize;
  final onPressed;
  final isLink;
  final List<RichTextData> richTextDatas;
  final TextDecoration decoration;

  //
  const Texts(
    this.text, {
    this.color,
    this.textSize,
    this.isCenter = false,
    this.isRight = false,
    this.fontWeight,
    this.overflow,
    this.maxLines,
    this.height,
    this.letterSpacing,
    this.capitalize,
    this.onPressed,
    this.isLink = false,
    this.richTextDatas,
    this.decoration,
  });

  const Texts.small(
    String text, {
    FontWeight fontWeight,
    Color color,
    bool isCenter = false,
    bool isRight = false,
  }) : this(
          text,
          textSize: AppSize.fontSmall,
          isRight: isRight,
          isCenter: isCenter,
          color: color,
          fontWeight: fontWeight,
        );

  const Texts.smallVery(
    String text, {
    FontWeight fontWeight,
    Color color,
    bool isCenter = false,
    bool isRight = false,
  }) : this(
          text,
          textSize: AppSize.fontSmallVery,
          isRight: isRight,
          isCenter: isCenter,
          color: color,
          fontWeight: fontWeight,
        );

  const Texts.big(
    String text, {
    FontWeight fontWeight,
    Color color,
    bool isCenter = false,
    bool isRight = false,
  }) : this(
          text,
          textSize: AppSize.fontBig,
          isRight: isRight,
          isCenter: isCenter,
          color: color,
          fontWeight: fontWeight,
        );

  const Texts.semiBold(
    String text, {
    double textSize,
    Color color,
    bool isCenter = false,
  }) : this(
          text,
          fontWeight: FontWeight.w600,
          textSize: textSize,
          color: color,
          isCenter: isCenter,
        );

  const Texts.bold(String text, {double textSize, Color color})
      : this(
          text,
          fontWeight: FontWeight.bold,
          textSize: textSize,
          color: color,
        );

  const Texts.smallBold(
    String text, {
    FontWeight fontWeight = FontWeight.bold,
    Color color,
    bool isCenter = false,
    bool isRight = false,
  }) : this(
          text,
          textSize: AppSize.fontSmall,
          fontWeight: fontWeight,
          color: color,
          isCenter: isCenter,
          isRight: isRight,
        );

  const Texts.blue(
    String text, {
    FontWeight fontWeight,
  }) : this(
          text,
          color: AppColors.blue,
          fontWeight: fontWeight,
        );

  const Texts.blueBold(
    String text, {
    double textSize,
  }) : this(
          text,
          color: AppColors.blue,
          fontWeight: FontWeight.bold,
          textSize: textSize,
        );
  const Texts.black(
    String text, {
    double textSize,
  }) : this(
          text,
          color: Colors.black,
        );

  const Texts.blueSmall(
    String text, {
    FontWeight fontWeight,
  }) : this(
          text,
          color: AppColors.blue,
          textSize: AppSize.fontSmall,
          fontWeight: fontWeight,
        );

  const Texts.red(
    String text, {
    FontWeight fontWeight,
  }) : this(
          text,
          color: AppColors.red,
          fontWeight: fontWeight,
        );

  const Texts.secondaryBlack(
    String text, {
    FontWeight fontWeight,
    TextOverflow overflow,
  }) : this(
          text,
          color: Colors.black54,
          fontWeight: fontWeight,
          overflow: overflow,
        );

  const Texts.secondaryBlackSmall(
    String text, {
    FontWeight fontWeight,
    TextOverflow overflow,
  }) : this(
          text,
          color: Colors.black54,
          fontWeight: fontWeight,
          overflow: overflow,
          textSize: AppSize.fontSmall,
        );

  const Texts.whiteMedium(
    String text, {
    bool isCenter = false,
  }) : this(
          text,
          textSize: AppSize.fontMedium,
          isCenter: isCenter,
        );

  const Texts.green(
    String text, {
    FontWeight fontWeight,
  }) : this(
          text,
          color: AppColors.greenLight,
          fontWeight: fontWeight,
        );

  const Texts.redNormal(
    String text, {
    FontWeight fontWeight,
  }) : this(
          text,
          color: AppColors.red,
          textSize: AppSize.fontNormal,
          fontWeight: fontWeight,
        );

  const Texts.normal(
    String text, {
    FontWeight fontWeight,
    Color color,
  }) : this(
          text,
          color: color,
          textSize: AppSize.fontNormal,
          fontWeight: fontWeight,
        );

  const Texts.redSmallBold(text)
      : this(
          text,
          color: AppColors.red,
          textSize: AppSize.fontSmall,
          fontWeight: FontWeight.bold,
        );

  const Texts.redBold(text)
      : this(
          text,
          color: AppColors.red,
          fontWeight: FontWeight.bold,
        );

  const Texts.redSmall(
    String text, {
    FontWeight fontWeight,
    bool isCenter = false,
  }) : this(
          text,
          color: AppColors.red,
          textSize: AppSize.fontSmall,
          fontWeight: fontWeight,
          isCenter: isCenter,
        );

  const Texts.greenSmall(
    String text, {
    FontWeight fontWeight,
    bool isCenter = false,
  }) : this(
          text,
          color: AppColors.greenLight,
          textSize: AppSize.fontSmall,
          isCenter: isCenter,
          fontWeight: fontWeight,
        );

  const Texts.grey(
    String text, {
    isCenter = false,
    isRight = false,
    double textSize,
    TextOverflow overflow,
  }) : this(
          text,
          color: Colors.white54,
          isCenter: isCenter,
          isRight: isRight,
          textSize: textSize,
          overflow: overflow,
        );

  const Texts.greySemiBold(
    String text, {
    bool isCenter = false,
    double textSize,
  }) : this(
          text,
          color: Colors.white54,
          isCenter: isCenter,
          fontWeight: FontWeight.w600,
          textSize: textSize,
        );

  const Texts.greyBold(
    String text, {
    bool isCenter = false,
    double height,
  }) : this(
          text,
          color: Colors.white54,
          isCenter: isCenter,
          fontWeight: FontWeight.bold,
          height: height,
        );

  const Texts.greySmall(
    String text, {
    bool isCenter = false,
    bool isRight = false,
    FontWeight fontWeight,
  }) : this(
          text,
          color: Colors.white54,
          textSize: AppSize.fontSmall,
          isCenter: isCenter,
          isRight: isRight,
          fontWeight: fontWeight,
        );

  const Texts.greySmallVery(
    String text, {
    bool isCenter = false,
    bool isRight = false,
    FontWeight fontWeight,
  }) : this(
          text,
          color: Colors.white54,
          textSize: 10.0,
          isCenter: isCenter,
          isRight: isRight,
          fontWeight: fontWeight,
        );

  const Texts.greySmallBold(
    String text, {
    bool isCenter = false,
    bool isRight = false,
    FontWeight fontWeight = FontWeight.bold,
  }) : this(
          text,
          color: Colors.white54,
          textSize: AppSize.fontSmall,
          fontWeight: fontWeight,
          isCenter: isCenter,
          isRight: isRight,
        );

  const Texts.link(
    String text, {
    @required VoidCallback onPressed,
    double textSize,
    bool isCenter = false,
  }) : this(
          text,
          fontWeight: FontWeight.bold,
          isLink: true,
          onPressed: onPressed,
          textSize: textSize,
          isCenter: isCenter,
        );

  const Texts.title(
    String text, {
    bool isCenter = false,
    bool isRight = false,
  }) : this(
          text,
          textSize: AppSize.fontBig,
          fontWeight: FontWeight.w600,
          isCenter: isCenter,
          isRight: isRight,
        );

  const Texts.subtitle(
    String text, {
    bool isCenter = false,
    bool isRight = false,
  }) : this(
          text,
          color: Colors.white54,
          isCenter: isCenter,
          isRight: isRight,
        );

  const Texts.rich(
    List<RichTextData> richTextDatas, {
    bool isCenter = false,
    bool isRight = false,
    double textSize,
    FontWeight fontWeight,
  }) : this(
          null,
          richTextDatas: richTextDatas,
          textSize: textSize,
          fontWeight: fontWeight,
          isCenter: isCenter,
          isRight: isRight,
        );

  const Texts.richSmall(
    List<RichTextData> richTextDatas, {
    bool isCenter = false,
    bool isRight = false,
    double textSize = AppSize.fontSmall,
    FontWeight fontWeight,
    Color color,
  }) : this(
          null,
          richTextDatas: richTextDatas,
          textSize: textSize,
          fontWeight: fontWeight,
          isCenter: isCenter,
          isRight: isRight,
          color: color,
        );

  const Texts.richSmallVery(
    List<RichTextData> richTextDatas, {
    bool isCenter = false,
    bool isRight = false,
    double textSize = AppSize.fontSmallVery,
    FontWeight fontWeight,
    Color color,
  }) : this(
          null,
          richTextDatas: richTextDatas,
          textSize: textSize,
          fontWeight: fontWeight,
          isCenter: isCenter,
          isRight: isRight,
          color: color,
        );

  const Texts.richBold(
    List<RichTextData> richTextDatas, {
    bool isCenter = false,
    bool isRight = false,
    double textSize,
  }) : this(
          null,
          richTextDatas: richTextDatas,
          textSize: textSize ?? AppSize.fontRegular,
          fontWeight: FontWeight.bold,
          isCenter: isCenter,
          isRight: isRight,
        );

  const Texts.richSemiBold(
    List<RichTextData> richTextDatas, {
    bool isCenter = false,
    bool isRight = false,
    double textSize,
  }) : this(
          null,
          richTextDatas: richTextDatas,
          textSize: textSize ?? AppSize.fontRegular,
          fontWeight: FontWeight.w600,
          isCenter: isCenter,
          isRight: isRight,
        );

  const Texts.richSmallBold(
    List<RichTextData> richTextDatas, {
    bool isCenter = false,
    bool isRight = false,
    double textSize = AppSize.fontSmall,
    FontWeight fontWeight = FontWeight.bold,
  }) : this(
          null,
          richTextDatas: richTextDatas,
          textSize: textSize,
          fontWeight: fontWeight,
          isCenter: isCenter,
          isRight: isRight,
        );

  @override
  Widget build(BuildContext context) {
    var color = this.color ?? _defaultTextColor;
    if (isLink) {
      color = onPressed == null
          ? _defaultTextLinkColorDisabled
          : _defaultTextLinkColor;
    }

    var style = TextStyle(
      fontSize: textSize ?? _defaultTextSize,
      color: color,
      fontWeight: fontWeight ?? _defaultFontWeight,
      height: height,
      letterSpacing: letterSpacing,
      fontFamily: 'NunitoSans',
    );

    if (isLink) {
      return Text.rich(
        TextSpan(
          text: capitalize == true ? text.toUpperCase() : text,
          recognizer: TapGestureRecognizer()..onTap = onPressed,
          style: style,
        ),
        textAlign: isCenter
            ? TextAlign.center
            : (isRight ? TextAlign.right : TextAlign.left),
        overflow: overflow,
        maxLines: maxLines,
      );
    }

    if (richTextDatas != null && richTextDatas.isNotEmpty) {
      return Text.rich(
        TextSpan(
          children: richTextDatas
              .map(
                (data) => TextSpan(
                  text: data.text,
                  style: TextStyle(
                    color: data.color,
                    fontWeight:
                        data.fontWeight ?? fontWeight ?? _defaultFontWeight,
                    fontSize: this.textSize ?? _defaultTextSize,
                    fontFamily: 'NunitoSans',
                  ),
                ),
              )
              .toList(),
        ),
        textAlign: isCenter
            ? TextAlign.center
            : (isRight ? TextAlign.right : TextAlign.left),
      );
    }

    return Text(
      capitalize == true ? text.toUpperCase() : text,
      textAlign: isCenter
          ? TextAlign.center
          : (isRight ? TextAlign.right : TextAlign.left),
      overflow: overflow,
      maxLines: maxLines,
      style: style,
    );
  }
}

class RichTextData {
  final String text;
  final Color color;
  final FontWeight fontWeight;

  RichTextData(
    this.text, {
    this.color = _defaultTextColor,
    this.fontWeight,
  });

  RichTextData.grey(
    this.text, {
    this.fontWeight,
  }) : color = Colors.white54;

  RichTextData.greyLight(
    this.text, {
    this.fontWeight,
  }) : color = Colors.white24;

  RichTextData.green(
    this.text, {
    this.fontWeight,
  }) : color = AppColors.green;

  RichTextData.greenLight(
    this.text, {
    this.fontWeight,
  }) : color = AppColors.green.withOpacity(0.4);

  RichTextData.red(
    this.text, {
    this.fontWeight,
  }) : color = AppColors.red;

  RichTextData.redLight(
    this.text, {
    this.fontWeight,
  }) : color = AppColors.red.withOpacity(0.4);
}
