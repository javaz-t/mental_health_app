
import 'package:metal_health_app/features/songs/domain/entities/domain.dart';

abstract class SongRepository{
  Future<List<Song>> getAllSongs();
}
