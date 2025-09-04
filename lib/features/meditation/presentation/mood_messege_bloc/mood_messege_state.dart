part of 'mood_messege_bloc.dart';

@immutable
abstract class MoodMessageState {}

class MoodMessageInitial extends MoodMessageState {}
class MoodMessageLoading extends MoodMessageState {}
class MoodMessageLoaded extends MoodMessageState {
  final MoodMessage moodMessage;
  MoodMessageLoaded({required this.moodMessage});
}
class MoodMessageError extends MoodMessageState {
  final String errorMessage;
  MoodMessageError({required this.errorMessage});
}

