import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:metal_health_app/features/songs/data/model/song_model.dart';

abstract class SongRemoteDataSource {
  Future<List<SongModel>> getAllSongs();
}

class SongRemoteDataSourceImpl implements SongRemoteDataSource {
  final http.Client client;

  SongRemoteDataSourceImpl({required this.client});
  @override
  Future<List<SongModel>>   getAllSongs() async {
    final response = await client.get(
      Uri.parse('http://10.0.2.2:6000/songs/all'),
    ); // use 10.0.2.2 for emulator instead of local host
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return jsonResponse.map((song) => SongModel.fromJson(song)).toList();
    } else {
      throw Exception('Failed to load songs');
    }
  }
}
