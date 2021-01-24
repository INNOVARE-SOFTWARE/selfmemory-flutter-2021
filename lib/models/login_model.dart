class LoginModel {
  final String username;
  final String password;

  LoginModel({this.username, this.password});

  Map<String, dynamic> toMap() {
    return {'username': username, 'password': password};
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      username: json['username'],
      password: json['password'],
    );
  }
}