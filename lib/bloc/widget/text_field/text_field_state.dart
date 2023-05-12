class TextFieldState{
  bool showPassword = false;
  TextFieldState({this.showPassword = false});

  TextFieldState copyWith({
    bool? showPassword,
  }) {
    return TextFieldState(
      showPassword: showPassword ?? this.showPassword,
    );
  }
}