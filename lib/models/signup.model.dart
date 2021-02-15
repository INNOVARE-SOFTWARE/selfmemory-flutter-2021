class SignupModel {
  final String email;
  final String password;
  final String firstname;
  final String lastname;

  SignupModel({this.email, this.password, this.firstname, this.lastname});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'firstname': firstname,
      'lastname': lastname
    };
  }

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      email: json['email'],
      password: json['password'],
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }
}
