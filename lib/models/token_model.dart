class TokenModel {
  final String token;

  TokenModel({this.token});

  Map<String, dynamic> toMap() {
    return {'token': token};
  }

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      token: json['token'],
    );
  }
}
