import 'package:authentication/bloc/base/base_event.dart';

abstract class AccountListEvent extends BaseEvent {}

class GetUserEvent extends AccountListEvent{
}
class UpdateRemoveUserEvent extends AccountListEvent{
  int index;
  String? status;
  UpdateRemoveUserEvent({required this.index,this.status});
}

class UpdateUserEvent extends UpdateRemoveEvent{
  String status;
  String id;
  UpdateUserEvent(this.status,this.id,super.index);
}

class DeleteUserEvent extends UpdateRemoveEvent{
  String id;
  DeleteUserEvent(this.id,super.index);
}

abstract class UpdateRemoveEvent extends BaseEvent{
  int index;
  UpdateRemoveEvent(this.index);
}