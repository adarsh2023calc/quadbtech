class Movie {
  final String title;
  final String summary;
  final String imageUrl;

  Movie({required this.title, required this.summary, required this.imageUrl});

  factory Movie.fromJson(Map<String, dynamic> json) {
    final show = json['show'];
    return Movie(
      title: show['name'] ?? 'N/A',
      summary: show['summary'] ?? 'No summary available.',
      imageUrl: show['image']?['medium'] ?? '',
    );
  }
}
