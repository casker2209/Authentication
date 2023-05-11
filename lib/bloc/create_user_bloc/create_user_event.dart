import 'package:authentication/bloc/base/base_event.dart';

abstract class CreateUserEvent extends BaseEvent{}

//Event for input changed => no need for individual attribute
class TextChangedEvent extends CreateUserEvent{
  String? phoneNumber;
  String? name;
  String? password;
  //Constructor for each attribute
  TextChangedEvent.phoneNumber(this.phoneNumber);
  TextChangedEvent.name(this.name);
  TextChangedEvent.password(this.password);
}

class CheckConditionEvent extends CreateUserEvent{
  bool canClick;
  CheckConditionEvent(this.canClick);
}

class ButtonPressedEvent extends CreateUserEvent{
  String phoneNumber;
  String name;
  String password;

  ButtonPressedEvent({required this.phoneNumber, required this.name, required this.password});
}

class GetContactEvent extends CreateUserEvent{

}
class ClearTextEvent extends CreateUserEvent{

}

class DefaultPasswordEvent extends CreateUserEvent{}

class ShowPasswordEvent extends CreateUserEvent{
  bool show;
  ShowPasswordEvent(this.show);
}