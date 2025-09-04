import 'package:metal_health_app/features/meditation/domain/entities/daily_quote.dart';
import 'package:metal_health_app/features/meditation/domain/entities/mood_message.dart';

abstract class DailyQuoteRepository{
  Future<DailyQuote>getDailyQuote();
  Future<MoodMessage>getMoodMessage(String mood);
}
