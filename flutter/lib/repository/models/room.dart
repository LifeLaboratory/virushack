class Room {
  //
  int roomId;
  String title;

  //
  factory Room.fromJson(Map<String, dynamic> json) => Room()
    ..roomId = json['id_room'] as int
    ..title = json['title'] as String;

  Map<String, dynamic> toJson() => null;

  Room();
}
