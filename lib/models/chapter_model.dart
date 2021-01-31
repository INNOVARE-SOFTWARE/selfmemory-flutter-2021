import 'package:json_annotation/json_annotation.dart';

part 'chapter_model.g.dart';

@JsonSerializable()
class Chapter {
  final String id;
  final String title;
  final String text;
  final String memoryId;

  Chapter({this.id, this.title, this.text, this.memoryId});

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterToJson(this);
}
