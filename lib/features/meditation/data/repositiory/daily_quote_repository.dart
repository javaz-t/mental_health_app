import 'package:metal_health_app/features/meditation/data/data_source/quote_remote_data_source.dart';
import 'package:metal_health_app/features/meditation/domain/repository/meditation_repository.dart';

import '../../domain/entities/daily_quote.dart';
import '../../domain/entities/mood_message.dart';

class DailyQuoteRepositoryImpl implements DailyQuoteRepository {
  final QuoteRemoteDataSource repository;
  DailyQuoteRepositoryImpl({required this.repository});

  @override
  Future<DailyQuote>getDailyQuote()async{
    return await repository.getDailyQuote();
  }

  @override
  Future<MoodMessage>getMoodMessage(String mood) async{
    return await repository.getMoodMessage(mood);
  }
}
