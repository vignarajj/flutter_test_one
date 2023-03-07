
import 'package:equatable/equatable.dart';

import '../../data/model/album/album_model.dart';

abstract class SearchAlbumState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchAlbumStart extends SearchAlbumState{}

class SearchAlbumLoading extends SearchAlbumState{}

class AlbumSearched extends SearchAlbumState {
  final List<Album> albums;
  AlbumSearched({required this.albums});
}
class NoAlbumFound extends SearchAlbumState {}

class AlbumSearchError extends SearchAlbumState {
  final error;
  AlbumSearchError({this.error});
}