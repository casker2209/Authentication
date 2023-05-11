import 'package:authentication/bloc/base/base_bloc.dart';
import 'package:authentication/bloc/base/base_state.dart';
import 'package:authentication/bloc/network/network_event.dart';
import 'package:authentication/bloc/network/network_state.dart';
class NetworkBloc extends BaseBloc<NetworkEvent,NetworkState>{
  NetworkBloc(S):super(S);

}