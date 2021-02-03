import 'package:json_annotation/json_annotation.dart';

part 'memory_model.g.dart';

@JsonSerializable()
class Memory {
  final String id;
  String title;
  String subtitle;
  final String userId;
  final DateTime created;

  Memory({this.id, this.title, this.subtitle, this.userId, this.created});

  factory Memory.fromJson(Map<String, dynamic> json) => _$MemoryFromJson(json);

  Map<String, dynamic> toJson() => _$MemoryToJson(this);
}
