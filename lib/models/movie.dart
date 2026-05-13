import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String id;
  final String title;
  final String poster;
  final String backdrop;
  final String description;
  final String genre;
  final double rating;
  final String duration;
  final String streamUrl;
  final String drmType; // 'none', 'widevine', 'clearkey'

  const Movie({
    required this.id,
    required this.title,
    required this.poster,
    required this.backdrop,
    required this.description,
    required this.genre,
    required this.rating,
    required this.duration,
    required this.streamUrl,
    this.drmType = 'none',
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      poster: json['poster'] ?? '',
      backdrop: json['backdrop'] ?? '',
      description: json['description'] ?? '',
      genre: json['genre'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      duration: json['duration'] ?? '',
      streamUrl: json['stream_url'] ?? '',
      drmType: json['drm_type'] ?? 'none',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'poster': poster,
    'backdrop': backdrop,
    'description': description,
    'genre': genre,
    'rating': rating,
    'duration': duration,
    'stream_url': streamUrl,
    'drm_type': drmType,
  };

  @override
  List<Object?> get props => [id, title, streamUrl];
}
