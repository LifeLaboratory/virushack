class Message {
  int messageId;
  String text;
  int userId;
  int roomId;
  int parentChatId;
  int createdAt;

  //
  factory Message.fromJson(Map<String, dynamic> json) => Message()
    ..messageId = json['id_message'] as int
    ..text = json['text_message'] as String
    ..userId = json['id_user'] as int
    ..roomId = json['id_room'] as int
    ..parentChatId = json['id_parent_chat'] as int
    ..createdAt = json['created_at'] as int;

  Map<String, dynamic> toJson() => null;

  Message();
}
