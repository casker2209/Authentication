
class AuthenticationEvent{}

class LoginButtonPressed extends AuthenticationEvent{
}

class UsernameChanged extends AuthenticationEvent{
  String text;
  UsernameChanged(this.text);
}
class PasswordChanged extends AuthenticationEvent{
  String text;
  PasswordChanged(this.text);
}

class TextChanged extends AuthenticationEvent{
  String? username;
  String? password;
  TextChanged({String? username,String? password});
}

class ShowPassword extends AuthenticationEvent{
  ShowPassword(this.onChanged);
  bool onChanged;
}
class RememberPassword extends AuthenticationEvent{
  RememberPassword(this.onChanged);
  bool onChanged;
}