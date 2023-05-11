import 'package:json_annotation/json_annotation.dart';
part 'update_user.g.dart';

@JsonSerializable(includeIfNull: false)
class UpdateUserRequest {
  UpdateUserRequest({
      this.username, 
      this.password, 
      this.name,
      this.status});

  String? username;
  String? password;
  String? name;
  String? status;
  UpdateUserRequest copyWith({  String? username,
  String? password,
  String? name,
  String? status
}) => UpdateUserRequest(  username: username ?? this.username,
  password: password ?? this.password,
  name: name ?? this.name,status: status ?? this.status
);

  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);

  factory UpdateUserRequest.fromJson(Map<String, dynamic> map) => _$UpdateUserRequestFromJson(map);

}
