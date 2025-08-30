import 'package:metal_health_app/features/songs/data/data_source/song_remote_data_source.dart';
import 'package:metal_health_app/features/songs/domain/entities/domain.dart';

class GetAllSong {
  final SongRemoteDataSourceImpl repository;

  GetAllSong({required this.repository});
  Future<List<Song>> call() async {
    return await repository.getAllSongs();
  }
}
