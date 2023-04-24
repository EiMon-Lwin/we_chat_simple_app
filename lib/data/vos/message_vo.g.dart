// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVO _$MessageVOFromJson(Map<String, dynamic> json) => MessageVO(
      json['message'] as String?,
      json['currentUserID'] as String?,
      json['id'] as String?,
      json['currentUserName'] as String?,
      json['currentUserProfile'] as String?,
    );

Map<String, dynamic> _$MessageVOToJson(MessageVO instance) => <String, dynamic>{
      'message': instance.message,
      'currentUserID': instance.currentUserID,
      'id': instance.id,
      'currentUserName': instance.currentUserName,
      'currentUserProfile': instance.currentUserProfile,
    };
