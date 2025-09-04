import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:metal_health_app/features/meditation/domain/entities/daily_quote.dart';
import 'package:metal_health_app/features/meditation/domain/use_case/get_daily_quote.dart';

part 'daily_quote_event.dart';
part 'daily_quote_state.dart';

class DailyQuoteBloc extends Bloc<DailyQuoteEvent, DailyQuoteState> {
  final GetDailyQuote getDailyQuote;

  DailyQuoteBloc({required this.getDailyQuote}) : super(DailyQuoteInitial()) {
    on<LoadDailyQuote>((event, emit) async {
      // ✅ Don’t refetch if already loaded
      if (state is DailyQuoteLoaded) return;

      emit(DailyQuoteLoading());
      try {
        final quote = await getDailyQuote();
        emit(DailyQuoteLoaded(dailyQuote: quote));
      } catch (e) {
        emit(DailyQuoteError(message: e.toString()));
      }
    });
  }
}
