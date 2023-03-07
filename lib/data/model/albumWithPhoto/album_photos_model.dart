import 'package:flutter_test_one/data/model/photo/photo_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'album_photos_model.g.dart';

@JsonSerializable()
class AlbumWithPhotos {
  final int albumId;
  final int userId;
  final List<Photo> photos;
  String? error;

  AlbumWithPhotos({
    required this.albumId,
    required this.userId,
    required this.photos,
    this.error,
  });

  factory AlbumWithPhotos.fromJson(Map<String, dynamic> json) =>
      _$AlbumWithPhotosFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumWithPhotosToJson(this);
}
