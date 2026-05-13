import 'package:equatable/equatable.dart';

class Reel extends Equatable {
  final String id;
  final String title;
  final String thumbnail;
  final String videoUrl;
  final String description;
  final String creator;
  final int views;
  final int likes;
  final double duration;
  final String drmType; // 'none', 'widevine', 'clearkey'

  const Reel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.videoUrl,
    required this.description,
    required this.creator,
    required this.views,
    required this.likes,
    required this.duration,
    this.drmType = 'none',
  });

  factory Reel.fromJson(Map<String, dynamic> json) {
    return Reel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      videoUrl: json['video_url'] ?? '',
      description: json['description'] ?? '',
      creator: json['creator'] ?? '',
      views: json['views'] ?? 0,
      likes: json['likes'] ?? 0,
      duration: (json['duration'] ?? 0.0).toDouble(),
      drmType: json['drm_type'] ?? 'none',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'thumbnail': thumbnail,
    'video_url': videoUrl,
    'description': description,
    'creator': creator,
    'views': views,
    'likes': likes,
    'duration': duration,
    'drm_type': drmType,
  };

  @override
  List<Object?> get props => [id, title, videoUrl];
}
