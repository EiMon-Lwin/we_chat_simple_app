// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      json['id'] as String?,
      json['name'] as String?,
      json['email'] as String?,
      json['phone'] as String?,
      json['region'] as String?,
      json['password'] as String?,
      json['file'] as String?,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'region': instance.region,
      'password': instance.password,
      'file': instance.file,
    };
