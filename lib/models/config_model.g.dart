// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return Config(
    id: json['id'] as String,
    email1: json['email1'] as String,
    email2: json['email2'] as String,
    userId: json['userId'] as String,
  );
}

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'id': instance.id,
      'email1': instance.email1,
      'email2': instance.email2,
      'userId': instance.userId,
    };
