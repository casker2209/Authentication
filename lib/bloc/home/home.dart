import 'package:authentication/bloc/base/base_bloc.dart';
import 'package:authentication/bloc/home/home_event.dart';
import 'package:authentication/bloc/home/home_state.dart';
import 'package:authentication/network/get_me.dart';
import 'package:authentication/utils/shared_preferences_utils.dart';
class HomeBloc extends BaseBloc<HomeEvent,HomeState>{
  int index;
  HomeBloc(this.index):super(HomeState(index: index)){
    on<HomeEvent>((event,emit) async{
      if(event is IndexChangedEvent) {
        emit(state.copyWith(index:event.index));
      }
      else if(event is GetMeEvent){
        GetMeResponse? response = await SharedPreferencesUtils.getMe();
        emit(state.copyWith(response:response));
      }
    });
  }
}