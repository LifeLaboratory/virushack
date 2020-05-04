import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palliative_chat/util/screen_util.dart';

abstract class StatelessBaseScreen extends StatelessWidget {
  const StatelessBaseScreen({Key key}) : super(key: key);

  @protected
  close(BuildContext context) => ScreenUtil.close(context);

  @protected
  returnBack(BuildContext context, Object object) =>
      ScreenUtil.returnBack(context, object);

  @protected
  openScreen(BuildContext context, Widget widget) =>
      ScreenUtil.openScreen(context, widget);

  @protected
  Future popAndOpenScreen(BuildContext context, Widget widget) =>
      ScreenUtil.popAndOpenScreen(context, widget);

  @protected
  Future<T> openScreenForResult<T>(BuildContext context, Widget widget) =>
      ScreenUtil.openScreenForResult(context, widget);

  @protected
  replaceScreen(BuildContext context, Widget widget) =>
      ScreenUtil.replaceScreen(context, widget);

  @protected
  popToCloseOpenedDialog(BuildContext context) =>
      ScreenUtil.popToCloseOpenedDialog(context);

  @protected
  showSnackBar(BuildContext context, String message, {bool error}) =>
      ScreenUtil.showSnackBar(context, message, error);

  @protected
  sendEvent<T extends Bloc>(BuildContext context, dynamic event) {
    BlocProvider.of<T>(context).add(event);
  }

  @protected
  T bloc<T extends Bloc>(BuildContext context) {
    return BlocProvider.of<T>(context);
  }
}

// todo rename to StatefulBaseWidget
abstract class StatefulBaseScreen extends StatefulWidget {
  const StatefulBaseScreen({Key key}) : super(key: key);
}

abstract class BaseState<T extends StatefulBaseScreen> extends State<T> {
  @protected
  close() => ScreenUtil.close(context);

  @protected
  returnBack(Object object) => ScreenUtil.returnBack(context, object);

  @protected
  openScreen(Widget widget) => ScreenUtil.openScreen(context, widget);

  @protected
  Future popAndOpenScreen(Widget widget) =>
      ScreenUtil.popAndOpenScreen(context, widget);

  @protected
  Future<T> openScreenForResult<T>(Widget widget) =>
      ScreenUtil.openScreenForResult(context, widget);

  @protected
  replaceScreen(Widget widget) => ScreenUtil.replaceScreen(context, widget);

  @protected
  popToCloseOpenedDialog() => ScreenUtil.popToCloseOpenedDialog(context);

  @protected
  showSnackBar(String message, {bool error = false, BuildContext context}) =>
      ScreenUtil.showSnackBar(context ?? this.context, message, error);

  @protected
  sendEvent<T extends Bloc>(BuildContext context, dynamic event) {
    BlocProvider.of<T>(context).add(event);
  }

  @protected
  T bloc<T extends Bloc>(BuildContext context) {
    return BlocProvider.of<T>(context);
  }
}
