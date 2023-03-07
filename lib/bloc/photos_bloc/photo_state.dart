
import 'package:equatable/equatable.dart';

import '../../data/model/photo/photo_model.dart';

abstract class PhotoState extends Equatable {
  @override
  List<Object> get props => [];
}

class PhotoInitState extends PhotoState{}

class PhotoLoading extends PhotoState{}

class PhotosLoaded extends PhotoState{
  final List<Photo> photos;
  PhotosLoaded({required this.photos});
}

class PhotoListError extends PhotoState {
  final error;
  PhotoListError({this.error});
}

class NoPhotos extends PhotoState{}