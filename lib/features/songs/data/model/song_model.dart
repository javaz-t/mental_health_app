import 'package:metal_health_app/features/songs/domain/entities/domain.dart';

class SongModel extends Song {


  SongModel({
    required  super.title,
    required super.id,
    required super.author,
    required super.songLink,
  });

  // Factory constructor to create Song from JSON
  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      songLink: json['songLink'] as String,
    );
  }

  // Method to convert Song object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'songLink': songLink,
    };
  }
}
