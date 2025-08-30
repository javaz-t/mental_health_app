import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:metal_health_app/features/songs/domain/usecase/get_all_song.dart';

import '../../domain/entities/domain.dart';

part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final GetAllSong getAllSong;
  SongBloc({required this.getAllSong}) : super(SongInitial()) {
    on<SongEvent>((event, emit) async {
      emit(SongLoading());
      try {
        final song = await getAllSong();
        emit(SongLoaded(songs: song));
      } catch (e) {
        emit(SongError(errorMessage: e.toString()));
      }
    });
  }
}
