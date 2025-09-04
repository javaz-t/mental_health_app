import 'package:metal_health_app/features/meditation/domain/entities/daily_quote.dart';

import '../../data/data_source/quote_remote_data_source.dart';

class GetDailyQuote {
  final QuoteRemoteDataSourceImpl repository;
  GetDailyQuote({required this.repository});

  Future<DailyQuote> call() async {
   return await  repository.getDailyQuote();
  }
}
