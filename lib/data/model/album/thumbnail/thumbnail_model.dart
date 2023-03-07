class Thumbnail {
  final int albumId;
  final String url;
  String? error;

  Thumbnail({
    required this.albumId,
    required this.url,
    this.error,
  });
}