import 'package:metal_health_app/features/meditation/domain/entities/daily_quote.dart';
import 'package:metal_health_app/features/meditation/domain/entities/mood_message.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/daily_quote_model.dart';
import 'package:dio/dio.dart';

import '../model/mood_message_model.dart';

abstract class QuoteRemoteDataSource {
  Future<DailyQuote> getDailyQuote();
  Future<MoodMessage> getMoodMessage(String mood);
}

class QuoteRemoteDataSourceImpl extends QuoteRemoteDataSource {

  @override
  Future<DailyQuote> getDailyQuote() async {
    try {
      final url = Uri.parse("http://10.0.2.2:6000/meditation/dailyQuote");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Step 1: Get the string inside "quotes.text"
        final rawText = data['quotes']['text'] as String;
print(rawText);
        // Step 2: Clean up the string (remove ```json and ```)
        final cleaned = rawText
            .replaceAll("```json", "")
            .replaceAll("```", "")
            .trim();

        // Step 3: Decode the cleaned string into JSON
        final quotesJson = jsonDecode(cleaned);

        // Step 4: Map into model
        return DailyQuoteModel.fromJson(quotesJson);
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching daily quote: $e");
    }
  }

  @override
  Future<MoodMessage> getMoodMessage(String mood) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        "http://10.0.2.2:6000/meditation/myMood/$mood",
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // step 1: get the nested text
        final rawText = data['advice']?['text'] as String?;
        if (rawText == null) {
          throw Exception("No text found in API response");
        }

        // step 2: clean the markdown junk
        final cleaned = rawText
            .replaceAll("```json", "")
            .replaceAll("```", "")
            .trim();

        // step 3: decode the inner JSON string
        final Map<String, dynamic> innerJson = jsonDecode(cleaned);

        // step 4: build your model from the cleaned JSON
        return MoodMessageModel.fromJson(innerJson);
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching mood: $e");
    }
  }

}
