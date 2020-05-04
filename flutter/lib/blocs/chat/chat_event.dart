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
