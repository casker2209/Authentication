import 'package:authentication/bloc/base/base_state.dart';

enum Loading{
  LOADING,LOADED,DEFAULT
}

abstract class NetworkState<T> extends BaseState{
  String message;
  bool success;
  bool loading;
  T? response;

  NetworkState({required this.message, required this.success, required this.loading, this.response});


}