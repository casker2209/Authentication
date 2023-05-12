import 'package:authentication/bloc/base/base_event.dart';

class ChangePasswordEvent extends BaseEvent{}

class CheckShowOldPassword extends ChangePasswordEvent{
  bool canShow;
  CheckShowOldPassword(this.canShow);
}

class CheckShowNewPassword extends ChangePasswordEvent{
  bool canShow;
  CheckShowNewPassword(this.canShow);
}

class CheckShowConfirmedPassword extends ChangePasswordEvent{
  bool canShow;
  CheckShowConfirmedPassword(this.canShow);
}

class CheckCanClickEvent extends ChangePasswordEvent{
  bool canClick;
  CheckCanClickEvent(this.canClick);
}

class ButtonPressedEvent extends ChangePasswordEvent{
  String oldPassword;
  String newPassword;

  ButtonPressedEvent({required this.newPassword,required this.oldPassword});
}