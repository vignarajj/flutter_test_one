import 'package:dio/dio.dart';
import 'package:flutter_test_one/data/model/album/album_model.dart';
import 'package:flutter_test_one/data/model/photo/photo_model.dart';
import 'package:retrofit/http.dart';

part 'album_api.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class AlbumApi {
  factory AlbumApi(Dio dio, {String baseUrl}) = _AlbumApi;

  @GET("/albums")
  Future<List<Album>> getAlbums();

  @GET("/albums?title={title}")
  Future<List<Album>> getAlbumsByTitle({@Path("title") required String title});

  @GET("/albums/{albumId}")
  Future<Album> getAlbumById({@Path("albumId") required String albumId});

  @GET("/albums/{albumId}/photos")
  Future<List<Photo>> getAlbumWithPhotos(
      {@Path("albumId") required int albumId});
}
