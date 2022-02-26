import 'package:json_annotation/json_annotation.dart';

part 'audio.g.dart';

@JsonSerializable()
class Audio {
  String? name;
  String? imageUrl;
  String? audioUrl;

  Audio();

  factory Audio.fromJson(Map<String, dynamic> json) => _$AudioFromJson(json);

}