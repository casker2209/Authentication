import 'package:authentication/bloc/base/base_event.dart';

class HomeEvent extends BaseEvent{}

class GetMeEvent extends HomeEvent{
  GetMeEvent();
}

class IndexChangedEvent extends HomeEvent{
  int index;
  IndexChangedEvent(this.index);
}
