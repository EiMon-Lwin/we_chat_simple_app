import 'package:json_annotation/json_annotation.dart';

part 'message_vo.g.dart';

@JsonSerializable()
class MessageVO {
  String? message;
  String? currentUserID;
  String? id;
  String? currentUserName;
  String? currentUserProfile;

  MessageVO(
    this.message,
    this.currentUserID,
    this.id,
    this.currentUserName,
    this.currentUserProfile,
  );

  factory MessageVO.fromJson(Map<String, dynamic> json) =>
      _$MessageVOFromJson(json);

  Map<String, dynamic> toJson() => _$MessageVOToJson(this);
}
