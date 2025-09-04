part of 'mood_messege_bloc.dart';

@immutable
abstract class MoodMessageEvent {}

class LoadMoodMessage extends MoodMessageEvent{
final String mood;
LoadMoodMessage(this.mood);
}
