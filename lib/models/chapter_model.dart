import 'package:json_annotation/json_annotation.dart';

part 'chapter_model.g.dart';

@JsonSerializable()
class Chapter {
  final String id;
  String title;
  String text;
  String memoryId;

  Chapter({this.id, this.title, this.text, this.memoryId});

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterToJson(this);
}
