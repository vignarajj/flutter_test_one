import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_one/bloc/album_bloc/album_bloc.dart';
import 'package:flutter_test_one/bloc/search_bloc/search_album_bloc.dart';
import '../bloc/album_bloc/album_state.dart';
import '../bloc/search_bloc/search_album_event.dart';
import '../bloc/search_bloc/search_album_state.dart';
import '../data/model/album/album_model.dart';
import 'list_all_photos.dart';

class SearchAlbumView extends StatelessWidget {
  const SearchAlbumView({Key? key, required this.blocContext, }) : super(key: key);

  final BuildContext blocContext;

  static MaterialPageRoute<void> route(BuildContext context) => MaterialPageRoute(builder: (_)=>
   SearchAlbumView(blocContext: context));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=> BlocProvider.of<AlbumBloc>(blocContext),
    child: const _SearchAlbumView(),);
  }
}

class _SearchAlbumView extends StatefulWidget {
  const _SearchAlbumView({Key? key}) : super(key: key);

  @override
  State<_SearchAlbumView> createState() => _SearchAlbumViewState();
}

class _SearchAlbumViewState extends State<_SearchAlbumView> {
  late SearchAlbumBloc bloc;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    bloc = context.read<SearchAlbumBloc>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              controller: searchController,
              onSubmitted: (value) {
                if (value.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                      Text('Please enter the title to continue')));
                  return;
                }
                bloc.add(SearchAlbum(searchText: value));
              },
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      if(searchController.text.isNotEmpty){
                        searchController.clear();
                      }
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchAlbumBloc, SearchAlbumState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is AlbumSearched) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.black45,),
                itemBuilder: (context, index) {
                  Album album = state.albums[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(ListPhotosByIdView.route(context, album.id));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 12, left: 4),
                          child: Text(album.title, style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87
                          ),),
                        ),
                      ],
                    ),
                  );
                }, itemCount: state.albums.length,),
            );
          }

          if(state is AlbumLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AlbumSearchError) {
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

          if(state is NoAlbumFound){
            return const Center(
              child: Text("Searched Item, not found. Please try different title."),
            );
          }

          return const Center(
            child: Text("No items"),
          );
        },
      ),
    );
  }
}

