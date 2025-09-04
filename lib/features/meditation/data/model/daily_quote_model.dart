
import '../../domain/entities/daily_quote.dart';

class DailyQuoteModel extends  DailyQuote {
  DailyQuoteModel({
    required super.eveningQuote,
    required super.morningQuote,
    required super.noonQuote,
  });

  factory DailyQuoteModel.fromJson(Map<String, dynamic> json) {
    print(json);
    print(json['eveningQuote']);
    return DailyQuoteModel(
      eveningQuote: json['eveningQuote'] as String,
      morningQuote: json['morningQuote'] as String,
      noonQuote: json['noonQuote'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eveningQuote': eveningQuote,
      'morningQuote': morningQuote,
      'noonQuote': noonQuote,
    };
  }
}
