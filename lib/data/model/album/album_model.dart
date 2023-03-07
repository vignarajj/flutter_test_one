import 'package:freezed_annotation/freezed_annotation.dart';

part 'album_model.g.dart';

@JsonSerializable()
class Album {
  final int userId;
  final int id;
  final String title;
  String? error;

  Album({
    required this.userId,
    required this.id,
    required this.title,
    this.error,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}