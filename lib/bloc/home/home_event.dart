import 'package:authentication/bloc/base/base_event.dart';
import 'package:authentication/network/get_me.dart';

class HomeEvent extends BaseEvent{}

class GetMeEvent extends HomeEvent{
  GetMeEvent();
}

class IndexChangedEvent extends HomeEvent{
  int index;
  IndexChangedEvent(this.index);
}
