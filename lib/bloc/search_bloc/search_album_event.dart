import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
abstract class SearchAlbumEvent {}

class SearchAlbum extends SearchAlbumEvent{
  final String searchText;
  SearchAlbum({required this.searchText});
}