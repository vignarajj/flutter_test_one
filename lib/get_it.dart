import 'package:flutter_test_one/data/services/album_service.dart';
import 'package:get_it/get_it.dart';

void setupGetIt() {
  GetIt.instance.registerSingleton<AlbumService>(AlbumService());
}