import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_one/bloc/album_bloc/album_bloc.dart';
import 'package:flutter_test_one/bloc/photos_bloc/photo_bloc.dart';
import 'package:flutter_test_one/bloc/photos_bloc/photo_event.dart';
import 'package:flutter_test_one/widgets/list_skeleton.dart';
import '../bloc/photos_bloc/photo_state.dart';
import '../data/model/photo/photo_model.dart';

class ListPhotosByIdView extends StatelessWidget {
  const ListPhotosByIdView(
      {Key? key, required this.blocContext, required this.albumId})
      : super(key: key);

  final BuildContext blocContext;

  final int albumId;

  static MaterialPageRoute<void> route(BuildContext context, int albumId) =>
      MaterialPageRoute(
          builder: (_) => ListPhotosByIdView(
                blocContext: context,
                albumId: albumId,
              ));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlocProvider.of<AlbumBloc>(blocContext),
      child: ListAllPhotoView(albumId: albumId),
    );
  }
}

class ListAllPhotoView extends StatefulWidget {
  const ListAllPhotoView({Key? key, required this.albumId}) : super(key: key);
  final int albumId;

  @override
  State<ListAllPhotoView> createState() => _ListAllPhotoViewState();
}

class _ListAllPhotoViewState extends State<ListAllPhotoView> {
  late PhotoBloc bloc;

  int get _albumId => widget.albumId;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    bloc = context.read<PhotoBloc>();
    bloc.add(LoadAllPhotos(albumId: _albumId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Photos"),
      ),
      body: BlocBuilder<PhotoBloc, PhotoState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is PhotosLoaded) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                itemCount: state.photos.length,
                itemBuilder: (BuildContext context, index) {
                  Photo photo = state.photos[index];
                  return InkWell(
                    onTap: () {
                      showThumbNail(photo.thumbnailUrl, photo.title);
                    },
                    child: Image.network(
                      photo.url,
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                  );
                });
          }

          if (state is PhotoListError) {
            final error = state.error;
            return Expanded(
              child: Center(
                child: Text(
                  error.message,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }

          if (state is NoPhotos) {
            return const Center(
              child: Text("No photos in this album, Try other!"),
            );
          }

          return const GridShimmerEffect();
        },
      ),
    );
  }

  showThumbNail(String thumbnailUrl, String title) {
    showModalBottomSheet(
        context: context,
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius:  BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )
        ),
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.network(
                thumbnailUrl,
                height: 200,
                width: 200,
              )
            ],
          );
        });
  }
}
