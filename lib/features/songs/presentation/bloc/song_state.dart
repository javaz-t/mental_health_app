part of 'song_bloc.dart';

@immutable
abstract class SongState {}

class SongInitial extends SongState {}

class SongLoading extends SongState {}

class SongLoaded extends SongState {
  final List<Song> songs;
  SongLoaded({required this.songs});
}

class SongError extends SongState {
  final String errorMessage;
  SongError({required this.errorMessage});
}
