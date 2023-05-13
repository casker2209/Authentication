import 'package:authentication/bloc/base/base_state.dart';
import 'package:authentication/network/response/get_me.dart';

class HomeState extends BaseState{
  HomeState({this.response,required this.index});
  GetMeResponse? response;
  int index;
  @override
  HomeState copyWith({
    GetMeResponse? response,
    int? index
}) =>HomeState(
    response: response ?? this.response,
    index: index ?? this.index,
  );
  @override
  List get props => [response,index];
}