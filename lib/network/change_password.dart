class ChangePasswordRequest{
  String oldPassword;
  String password;

  ChangePasswordRequest({required this.oldPassword, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'oldPassword': this.oldPassword,
      'newPassword': this.password,
    };
  }

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> map) {
    return ChangePasswordRequest(
      oldPassword: map['oldPassword'] as String,
      password: map['password'] as String,
    );
  }
}