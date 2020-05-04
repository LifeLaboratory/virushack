import 'package:json_annotation/json_annotation.dart';
import 'package:palliative_chat/repository/models/message.dart';

part 'room.g.dart';

@JsonSerializable()
class Room {
  int roomId;
  String title;
  List<Message> messages;

  //
  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);

  Room();
}
