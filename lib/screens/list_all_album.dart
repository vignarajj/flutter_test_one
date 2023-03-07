import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_one/bloc/album_bloc/album_bloc.dart';
import 'package:flutter_test_one/bloc/album_bloc/album_event.dart';
import 'package:flutter_test_one/data/model/album/album_model.dart';
import 'package:flutter_test_one/screens/list_all_photos.dart';
import 'package:flutter_test_one/screens/search_album.dart';
import 'package:flutter_test_one/widgets/list_skeleton.dart';

import '../bloc/album_bloc/album_state.dart';

class ListAllAlbums extends StatefulWidget {
  const ListAllAlbums({Key? key}) : super(key: key);

  @override
  State<ListAllAlbums> createState() => _ListAllAlbumsState();
}

class _ListAllAlbumsState extends State<ListAllAlbums> {

  late AlbumBloc bloc;

  @override
  void initState() {
    bloc = context.read<AlbumBloc>();
    bloc.add(LoadAllAlbums());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Albums"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.search),
              color: Colors.white,
              onPressed: (){
                Navigator.of(context).push(
                  SearchAlbumView.route(context));
              },
            ),
          )
        ],
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        bloc: bloc,
        builder: (context, state){
          if(state is AlbumLoaded) {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.black45,),
                itemBuilder: (context, index) {
                  Album album = state.albums[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(ListPhotosByIdView.route(context, album.id));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 12, left: 6),
                          child: Text(album.title, style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87
                          ),),
                        ),
                      ],
                    ),
                  );
                }, itemCount: state.albums.length,);
          }
          if(state is AlbumListError){
            final error = state.error;
            return Expanded(
              child: Center(
                child: Text(
                  error.message,
                  style: const TextStyle(color: Colors.red, fontSize: 20,),
                ),
              ),
            );

          }

          if(state is AlbumLoading){
            return const ListShimmerEffect();
          }

          return const ListShimmerEffect();
        }
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
