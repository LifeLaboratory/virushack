import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palliative_chat/ui/main_screen.dart';

import 'blocs/chat/bloc.dart';
import 'blocs/main/bloc.dart';
import 'blocs/simple_bloc_delegate.dart';
import 'config/constants.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(
          create: (c) => MainBloc()..add(AppOpened()),
        ),
        BlocProvider<ChatBloc>(
          create: (c) => ChatBloc()..add(Opened()),
        ),
      ],
      child: MaterialApp(
        title: 'Забота',
        home: MainScreen(),
        theme: _theme(context),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  //
  ThemeData _theme(BuildContext context) {
    return ThemeData(
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColors.fontMain,
            displayColor: AppColors.fontMain,
            decorationColor: AppColors.fontMain,
            fontFamily: 'NunitoSans',
          ),
      //canvasColor: AppColors.backgroundWithWhiteFiveOverlay,
      brightness: Brightness.light,
      primaryColor: Colors.white,
      //scaffoldBackgroundColor: AppColors.background,
      accentColor: Colors.redAccent,
      toggleableActiveColor: AppColors.blue,
      /*popupMenuTheme: Theme.of(context).popupMenuTheme.copyWith(
            color: AppColors.backgroundWithWhiteFiveOverlay,
          ),*/
      dialogBackgroundColor: AppColors.backgroundLight5,
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
            color: Colors.white,
          ),
    );
  }
}
