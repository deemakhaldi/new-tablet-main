class UserConfigsModel {
  final String account;
  final String username;
  final String password;
  final String token;

  UserConfigsModel(this.account, this.username, this.password, this.token);

  // here because of user object is too long Im storing it as string
  // and that is actually not a good way to do this because of when you want to
  // fetch user and handle information it will be very hard to do those and also when testing
  // please map other properties in your json to model and that's the best way.
  UserConfigsModel.fromJson(dynamic obj)
      : this.account = obj['account'].toString(),
        this.username = obj['username'].toString(),
        this.password = obj['password'].toString(),
        this.token = obj['token'];

  Map<String, dynamic> toMap() => {
        'account': account,
        'username': username,
        'password': password,
        'token': token
      };
}
