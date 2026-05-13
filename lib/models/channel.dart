import 'package:equatable/equatable.dart';

class Channel extends Equatable {
  final String id;
  final String name;
  final String logo;
  final String category;
  final String streamUrl;
  final String? description;
  final bool isLive;
  final String? currentProgram;
  final String drmType; // 'none', 'widevine', 'clearkey'

  const Channel({
    required this.id,
    required this.name,
    required this.logo,
    required this.category,
    required this.streamUrl,
    this.description,
    this.isLive = true,
    this.currentProgram,
    this.drmType = 'none',
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      category: json['category'] ?? '',
      streamUrl: json['stream_url'] ?? '',
      description: json['description'],
      isLive: json['is_live'] ?? true,
      currentProgram: json['current_program'],
      drmType: json['drm_type'] ?? 'none',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'logo': logo,
    'category': category,
    'stream_url': streamUrl,
    'description': description,
    'is_live': isLive,
    'current_program': currentProgram,
    'drm_type': drmType,
  };

  @override
  List<Object?> get props => [id, name, streamUrl, isLive, drmType];

  Channel copyWith({
    String? id,
    String? name,
    String? logo,
    String? category,
    String? streamUrl,
    String? description,
    bool? isLive,
    String? currentProgram,
    String? drmType,
  }) {
    return Channel(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      category: category ?? this.category,
      streamUrl: streamUrl ?? this.streamUrl,
      description: description ?? this.description,
      isLive: isLive ?? this.isLive,
      currentProgram: currentProgram ?? this.currentProgram,
      drmType: drmType ?? this.drmType,
    );
  }
}
