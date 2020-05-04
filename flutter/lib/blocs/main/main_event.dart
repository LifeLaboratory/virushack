import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  get props => null;
}

class AppOpened extends MainEvent {}
