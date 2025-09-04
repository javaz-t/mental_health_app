import 'package:metal_health_app/features/meditation/domain/entities/mood_message.dart';

import '../../data/data_source/quote_remote_data_source.dart';

class GetMoodMessage{
   final QuoteRemoteDataSourceImpl repository;

  GetMoodMessage({required this.repository,});

  Future<MoodMessage>call(String mood)async{
    return await repository.getMoodMessage(mood);
  }
}
