import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:palliative_chat/config/constants.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String label;
  final String counterText;
  final Widget trailingWidget;
  final double paddingTop;
  final double paddingBottom;
  final bool suffixBold;
  final bool digitsOnly;
  final bool noPunctuation;
  final bool bold;
  final bool enabled;
  final String suffix;
  final int maxLength;
  final Color textColor;
  final FocusNode focusNode;
  final bool error;

  const Input({
    Key key,
    this.controller,
    this.onChanged,
    this.label,
    this.trailingWidget,
    this.paddingTop = 14.0,
    this.paddingBottom,
    this.suffixBold = false,
    this.digitsOnly = false,
    this.noPunctuation = false,
    this.bold = false,
    this.counterText,
    this.enabled,
    this.suffix,
    this.maxLength,
    this.textColor,
    this.focusNode,
    this.error = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide: BorderSide(
        color: Colors.black.withOpacity(0.1),
        style: BorderStyle.solid,
        width: 0.5,
      ),
    );
    var textField = TextField(
      focusNode: focusNode,
      keyboardType: TextInputType.multiline,

      //keyboardType: digitsOnly ? TextInputType.number : null,
      inputFormatters:
          noPunctuation ? [WhitelistingTextInputFormatter.digitsOnly] : null,
      //maxLines: 1,
      maxLength: maxLength,
      style: TextStyle(
        fontSize: AppSize.fontRegular,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: error ? AppColors.red : (textColor ?? Colors.white),
        //height: 1.0,
      ),
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        fillColor: Colors.black.withOpacity(0.05),
        filled: true,
        border: border,
        focusedBorder: border,
        enabledBorder: border,
        errorBorder: border,
        disabledBorder: border,
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.only(
          //top: AppSize.paddingMedium,
          left: AppSize.paddingMedium,
          right: AppSize.paddingMedium,
          bottom: AppSize.paddingBig,
        ),
        suffixText: suffix,
        suffixStyle: suffixBold
            ? TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              )
            : null,
        counterText: counterText ?? '',
        labelText: label,
      ),
      onChanged: onChanged,
      enabled: enabled,
    );

    if (trailingWidget != null) {
      return Stack(
        children: [
          textField,
          Positioned(
            top: 0.0,
            bottom: 0.0,
            right: 0.0,
            child: trailingWidget,
          )
        ],
      );
    }

    return textField;
  }
}
