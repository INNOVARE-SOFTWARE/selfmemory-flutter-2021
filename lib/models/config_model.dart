import 'package:json_annotation/json_annotation.dart';
part 'config_model.g.dart';

@JsonSerializable()
class Config {
  final String id;
  final String email1;
  final String email2;
  final String userId;


  Config({
    this.id,
    this.email1,
    this.email2,
    this.userId
  });


  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}
