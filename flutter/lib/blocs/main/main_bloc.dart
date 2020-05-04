import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:palliative_chat/repository/api.dart';

import './bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  @override
  MainState get initialState => InitialMainState();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is AppOpened) {
      // Make api constructor call and init the listeners
      Api();
    }
  }
}
