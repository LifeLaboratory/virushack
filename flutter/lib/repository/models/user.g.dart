// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..userId = json['userId'] as int
    ..name = json['name'] as String
    ..deviceId = json['deviceId'] as String
    ..chatId = json['chatId'] as int;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'deviceId': instance.deviceId,
      'chatId': instance.chatId,
    };
