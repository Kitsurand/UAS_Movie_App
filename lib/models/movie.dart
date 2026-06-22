class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final double rating;
  final String synopsis;
  final int durationMinutes;
  final List<String> genres;

  const Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.rating,
    required this.synopsis,
    required this.durationMinutes,
    required this.genres,
  });
}
