class LoginResponseModel {
  String? token;
  String? error;

  LoginResponseModel({this.token, this.error});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"] != null ? json["token"] : "",
      error: json["error"] != null ? json["error"] : "",
    );
  }
}

class LoginRequestModel {
  String account;
  String username;
  String password;

  LoginRequestModel({
    required this.account,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'account': account.trim(),
      'username': username.trim(),
      'password': password.trim(),
    };

    return map;
  }
}
