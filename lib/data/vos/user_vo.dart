import 'package:json_annotation/json_annotation.dart';

part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: 'region')
  String? region;

  @JsonKey(name: 'password')
  String? password;

  @JsonKey(name: 'file')
  String? file;

  UserVO(this.id, this.name, this.email, this.phone, this.region, this.password,
      this.file);

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);
}
