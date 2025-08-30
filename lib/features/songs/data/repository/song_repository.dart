
import 'package:metal_health_app/features/songs/data/data_source/song_remote_data_source.dart';
import 'package:metal_health_app/features/songs/domain/entities/domain.dart';
import 'package:metal_health_app/features/songs/domain/repository/song_repository.dart';

class SongsRepositoryImpl implements SongRepository{
 final SongRemoteDataSource remoteSource;
 SongsRepositoryImpl({required this.remoteSource});

  @override
  Future<List<Song>> getAllSongs()async {
    final songModels = await remoteSource.getAllSongs();
    return songModels;
  }
}
