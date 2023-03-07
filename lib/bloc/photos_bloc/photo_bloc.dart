
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_one/bloc/photos_bloc/photo_event.dart';
import 'package:flutter_test_one/bloc/photos_bloc/photo_state.dart';
import 'package:flutter_test_one/data/services/album_service.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final IAlbumService service;

  PhotoBloc({required this.service}): super(PhotoInitState()) {
    on<LoadAllPhotos>((event, emit) async {
      try{
        emit(PhotoLoading());
        final photos = await service.getAlbumWithPhotos(albumId: event.albumId);
        if(photos.isNotEmpty) {
          emit(PhotosLoaded(photos: photos));
        }else{
          emit(NoPhotos());
        }
      }catch(e){
        emit(PhotoListError(error: "Error loading photos"));
      }
    });
  }
}