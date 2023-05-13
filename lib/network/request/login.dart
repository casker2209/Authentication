class SignInRequest{
  SignInRequest(this.username,this.password);
  String username;
  String password;

  Map<String, dynamic> toJson() {
    return {
      'username': this.username,
      'password': this.password,
    };
  }

  factory SignInRequest.fromJson(Map<String, dynamic> map) {
    return SignInRequest(
      map['username'] as String,
      map['password'] as String,
    );
  }


}


