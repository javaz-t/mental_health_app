import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:metal_health_app/features/meditation/domain/entities/mood_message.dart';
import 'package:metal_health_app/features/meditation/domain/use_case/get_mood_message.dart';

part 'mood_messege_event.dart';
part 'mood_messege_state.dart';

class MoodMessageBloc extends Bloc<MoodMessageEvent, MoodMessageState> {
  final GetMoodMessage getMoodMessage;
  MoodMessageBloc(this.getMoodMessage) : super(MoodMessageInitial()) {
   
    on<LoadMoodMessage>((event,emit)async{
      emit(MoodMessageLoading());
      try{
        final moodMessage = await getMoodMessage(event.mood);
        emit(MoodMessageLoaded(moodMessage: moodMessage));
      }catch(e){
        emit(MoodMessageError(errorMessage: e.toString()));
      }
    });
  }
}
