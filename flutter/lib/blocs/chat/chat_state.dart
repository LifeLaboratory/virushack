import 'package:equatable/equatable.dart';
import 'package:palliative_chat/repository/models/message.dart';
import 'package:palliative_chat/repository/models/room.dart';

class ChatState extends Equatable {
  final List<Room> rooms;
  final List<Message> messages;
  final Room room;
  final bool sendingMessage;

  const ChatState({
    this.room,
    this.rooms,
    this.messages,
    this.sendingMessage,
  });

  const ChatState.idle()
      : room = null,
        rooms = null,
        messages = null,
        sendingMessage = false;

  ChatState copyWith({
    Room room,
    List<Room> rooms,
    List<Message> messages,
    bool sendingMessage,
  }) {
    return ChatState(
      room: room ?? this.room,
      rooms: rooms ?? this.rooms,
      messages: messages ?? this.messages,
      sendingMessage: sendingMessage ?? this.sendingMessage,
    );
  }

  @override
  get props => [room, rooms, sendingMessage, messages];
}
