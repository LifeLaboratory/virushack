// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..userId = json['userId'] as int
    ..name = json['name'] as String
    ..diagnosisId = json['diagnosisId'] as int
    ..hash = json['hash'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'diagnosisId': instance.diagnosisId,
      'hash': instance.hash,
    };
