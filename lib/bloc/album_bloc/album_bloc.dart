import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_one/bloc/album_bloc/album_event.dart';
import 'package:flutter_test_one/bloc/album_bloc/album_state.dart';

import '../../data/services/album_service.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final IAlbumService service;

  AlbumBloc({required this.service}) : super(AlbumInitState()) {
    on<LoadAllAlbums>((event, emit) async {
      try {
        emit(AlbumLoading());
        final albums = await service.getAllAlbums();
        emit(AlbumLoaded(albums: albums));
      } catch (e) {
        emit(AlbumListError(error: "Error loading albums"));
      }
    });

  }
}
