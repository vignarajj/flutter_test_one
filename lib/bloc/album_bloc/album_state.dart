import 'package:equatable/equatable.dart';
import 'package:flutter_test_one/data/model/album/album_model.dart';

abstract class AlbumState extends Equatable {
  @override
  List<Object> get props => [];
}

class AlbumInitState extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Album> albums;

  AlbumLoaded({required this.albums});
}

class AlbumListError extends AlbumState {
  final error;

  AlbumListError({this.error});
}
