class LoginModel {
  final String email;
  final String password;

  LoginModel({this.email, this.password});

  Map<String, dynamic> toMap() {
    return {'username': email, 'password': password};
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'],
      password: json['password'],
    );
  }
}