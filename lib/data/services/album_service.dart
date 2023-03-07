import 'package:dio/dio.dart';
import 'package:flutter_test_one/data/api/album_api/album_api.dart';
import 'package:flutter_test_one/data/model/album/album_model.dart';
import 'package:flutter_test_one/data/model/photo/photo_model.dart';

abstract class IAlbumService {

  Future<List<Album>> getAllAlbums();

  Future<List<Album>> getAlbumsByTitle({required String title});

  Future<Album> getAlbumById({required String id});

  Future<List<Photo>> getAlbumWithPhotos({required int albumId});

}

class AlbumService extends IAlbumService {
  final AlbumApi albumApi = AlbumApi(Dio());

  @override
  Future<Album> getAlbumById({required String id}) {
    var response = albumApi.getAlbumById(albumId: id);
    return response;
  }

  @override
  Future<List<Photo>> getAlbumWithPhotos({required int albumId}) {
    var response = albumApi.getAlbumWithPhotos(albumId: albumId);
    return response;
  }

  @override
  Future<List<Album>> getAlbumsByTitle({required String title}) {
    var response = albumApi.getAlbumsByTitle(title: title);
    return response;
  }

  @override
  Future<List<Album>> getAllAlbums() {
    var response = albumApi.getAlbums();
    return response;
  }

}