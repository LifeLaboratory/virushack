import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int userId;
  String name;
  int diagnosisId;
  String hash;

  //
  factory User.fromJson(Map<String, dynamic> json) => User()
    ..userId = json['id_user'] as int
    ..name = json['name'] as String
    ..diagnosisId = json['id_diagnosis'] as int
    ..hash = json['hash'] as String;

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User();
}
