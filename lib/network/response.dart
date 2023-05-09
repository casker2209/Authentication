import 'package:authentication/network/response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';
@JsonSerializable()
class BaseResponse{
  bool success;
  String? message;
  BaseResponse({required this.success,this.message});
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);

  factory BaseResponse.fromJson(Map<String, dynamic> map) => _$BaseResponseFromJson(map);

  static BaseResponse? BaseResponseFromJsonWithErrorHandling(Map<String,dynamic> map){
    try{
      return BaseResponse.fromJson(map);
    }
    catch(e,stacktrace){
      return null;
    }
  }
}