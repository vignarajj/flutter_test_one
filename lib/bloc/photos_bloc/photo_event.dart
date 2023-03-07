import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
abstract class PhotoEvent {}

class LoadAllPhotos extends PhotoEvent{
  final int albumId;
  LoadAllPhotos({required this.albumId});
}