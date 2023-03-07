import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
abstract class AlbumEvent {}

class LoadAllAlbums extends AlbumEvent{}