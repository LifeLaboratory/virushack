part 'message.g.dart';

class Message {
  int messageId;
  String text;
  int senderId;
  int senderName;

  //
  factory Message.fromJson(Map<String, dynamic> json) => Message()
    ..messageId = json['messageId'] as int
    ..text = json['text'] as String
    ..senderId = json['senderId'] as int
    ..senderName = json['senderName'] as int;

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  Message();
}
