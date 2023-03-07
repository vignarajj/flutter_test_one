import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_one/bloc/album_bloc/album_bloc.dart';
import 'package:flutter_test_one/bloc/photos_bloc/photo_bloc.dart';
import 'package:flutter_test_one/bloc/search_bloc/search_album_bloc.dart';
import 'package:flutter_test_one/data/services/album_service.dart';
import 'package:flutter_test_one/screens/list_all_album.dart';
import 'package:get_it/get_it.dart';
import 'bloc/bloc_observer/app_bloc_observer.dart';
import 'get_it.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

void main() => runZonedGuarded<void>(
      () async {
        Bloc.observer = AppBlocObserver.instance();
        Bloc.transformer = bloc_concurrency.sequential<Object?>();
        setupGetIt();
        runApp(const MyApp());
      },
      (error, stack) {},
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AlbumService albumService = GetIt.instance<AlbumService>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AlbumBloc(service: albumService)),
        BlocProvider(
            create: (context) => SearchAlbumBloc(service: albumService)),
        BlocProvider(create: (context)=> PhotoBloc(service: albumService)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ListAllAlbums(),
      ),
    );
  }
}
