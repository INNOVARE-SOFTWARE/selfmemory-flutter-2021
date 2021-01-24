class User {
  final String email;
  final String username;
  final String firstname;
  final String lastname;

  User({this.email, this.username, this.firstname, this.lastname});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'firstname': firstname,
      'lastname': lastname
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        username: json['username'],
        firstname: json['firstname'],
        lastname: json['lastname']);
  }
}
