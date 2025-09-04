import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:metal_health_app/features/meditation/data/data_source/quote_remote_data_source.dart';
import 'package:metal_health_app/features/meditation/domain/use_case/get_daily_quote.dart';
import 'package:metal_health_app/features/meditation/domain/use_case/get_mood_message.dart';
import 'package:metal_health_app/features/meditation/presentation/mood_messege_bloc/mood_messege_bloc.dart';
 import 'package:metal_health_app/features/songs/data/data_source/song_remote_data_source.dart';
 import 'package:metal_health_app/features/songs/domain/usecase/get_all_song.dart';
import 'package:metal_health_app/features/songs/presentation/bloc/song_bloc.dart';
import 'package:metal_health_app/presentsaion/bottom_nav_bar/bloc/navigation_bloc.dart';
import 'package:metal_health_app/presentsaion/home_page/home_page.dart';

import 'features/meditation/presentation/daily_quote_bloc/daily_quote_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MoodMessageBloc(GetMoodMessage(repository: QuoteRemoteDataSourceImpl() ))),

        BlocProvider(
          create: (_) => DailyQuoteBloc(
            getDailyQuote: GetDailyQuote(
              repository: QuoteRemoteDataSourceImpl(),
            ),
          ),//..add(LoadDailyQuote()),
        ),
        BlocProvider(create: (_) => NavigationBloc()),
        BlocProvider(
          create: (_) => SongBloc(
            getAllSong: GetAllSong(
              repository: SongRemoteDataSourceImpl(client: http.Client()),
            ),
          )..add(FetchSong()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        showSemanticsDebugger: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: HomePage(),
      ),
    );
  }
}
