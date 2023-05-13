
import 'package:authentication/network/response/response.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_user.g.dart';
enum Status{
  ACTIVATED,
  DEACTIVATED,
  SMS

}
@JsonSerializable()
class GetUserResponse extends BaseResponse {
  GetUserResponse({
      required this.total,
      this.data,
      required bool success}):super(success:success);

  int total;
  List<User>? data;

  factory GetUserResponse.fromJson(dynamic json) => _$GetUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserResponseToJson(this);

}

class User extends Equatable{
  User({
      this.id,
      this.username,
      this.name,
      this.role,
      this.admin,
      this.rocketId,
      this.createdAt,
      this.status,});

  User.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    role = json['role'];
    admin = json['admin'];
    rocketId = json['rocketId'];
    createdAt = json['createdAt'];
    status = json['status'];
  }
  num? id;
  String? username;
  String? name;
  String? role;
  String? admin;
  String? rocketId;
  String? createdAt;
  String? status;
User copyWith({  num? id,
  String? username,
  String? name,
  String? role,
  String? admin,
  String? rocketId,
  String? createdAt,
  String? status,
}) => User(  id: id ?? this.id,
  username: username ?? this.username,
  name: name ?? this.name,
  role: role ?? this.role,
  admin: admin ?? this.admin,
  rocketId: rocketId ?? this.rocketId,
  createdAt: createdAt ?? this.createdAt,
  status: status ?? this.status,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['name'] = name;
    map['role'] = role;
    map['admin'] = admin;
    map['rocketId'] = rocketId;
    map['createdAt'] = createdAt;
    map['status'] = status;
    return map;
  }

  @override
  List<Object?> get props =>[id,
    username,
    name,
    role, admin,
    rocketId,
    createdAt,
    status];

}