import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  get props => null;
}

class Opened extends ChatEvent {}

class SendMessage extends ChatEvent {
  final String message;
  final int roomId;

  SendMessage(this.message, this.roomId);

  @override
  get props => [message, roomId];
}

class ChatDataReceived extends ChatEvent {
  final dynamic data;

  ChatDataReceived(this.data);

  @override
  get props => [data];
}

class EnterRoom extends ChatEvent {
  final int roomId;

  EnterRoom(this.roomId);

  @override
  get props => [roomId];
}

class LeaveRoom extends ChatEvent {
  final int roomId;

  LeaveRoom(this.roomId);

  @override
  get props => [roomId];
}
