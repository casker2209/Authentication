import 'package:json_annotation/json_annotation.dart';
part 'create_user.g.dart';

@JsonSerializable()
class CreateUserRequest {
  CreateUserRequest({
      this.username, 
      this.password, 
      this.name,});

  String? username;
  String? password;
  String? name;
CreateUserRequest copyWith({  String? username,
  String? password,
  String? name,
}) => CreateUserRequest(  username: username ?? this.username,
  password: password ?? this.password,
  name: name ?? this.name,
);

  Map<String, dynamic> toJson() => _$CreateUserRequestToJson(this);

  factory CreateUserRequest.fromJson(Map<String, dynamic> map) => _$CreateUserRequestFromJson(map);

}
