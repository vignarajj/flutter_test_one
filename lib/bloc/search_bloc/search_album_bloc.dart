import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_one/bloc/search_bloc/search_album_event.dart';
import 'package:flutter_test_one/bloc/search_bloc/search_album_state.dart';
import 'package:flutter_test_one/data/services/album_service.dart';

class SearchAlbumBloc extends Bloc<SearchAlbumEvent, SearchAlbumState> {
  final IAlbumService service;

  SearchAlbumBloc({required this.service}): super(SearchAlbumStart()) {
    on<SearchAlbum>((event, emit) async {
      try {
        emit(SearchAlbumLoading());
        final albums = await service.getAlbumsByTitle(title: event.searchText);
        if(albums.isNotEmpty) {
          emit(AlbumSearched(albums: albums));
        }else{
          emit(NoAlbumFound());
        }
      } catch (e) {
        emit(AlbumSearchError(error: "Error loading albums"));
      }
    });
  }

}