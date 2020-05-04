import 'package:flutter/material.dart';
import 'package:palliative_chat/ui/common/texts.dart';

class ScreenUtil {
  static close(BuildContext context) {
    Navigator.pop(context);
  }

  static returnBack(BuildContext context, Object object) {
    Navigator.pop(context, object);
  }

  static openScreen(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  static Future popAndOpenScreen(BuildContext context, Widget widget) {
    Navigator.pop(context);
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  static Future<T> openScreenForResult<T>(BuildContext context, Widget widget) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  static replaceScreen(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  static popToCloseOpenedDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static showSnackBar(BuildContext context, String message, bool error) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: error ? Colors.red : Colors.green,
        content: Texts(message),
        duration: Duration(
          seconds: 2,
        ),
      ),
    );
  }
}
