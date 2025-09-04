import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metal_health_app/core/helper/extension.dart';
import 'package:metal_health_app/core/theme.dart';
import 'package:metal_health_app/features/meditation/presentation/widgets/feeling_button.dart';
import 'package:metal_health_app/features/meditation/presentation/widgets/task_card.dart';

import '../daily_quote_bloc/daily_quote_bloc.dart';
import '../mood_messege_bloc/mood_messege_bloc.dart';

class MeditationScreen extends StatelessWidget {
  const MeditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/menu_burger.png'),
        actions: [
          CircleAvatar(backgroundImage: AssetImage('assets/profile.png')),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Welcome back , javaz!'),
              32.vs(),
              Text('How are you feeling today ? '),
              16.vs(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FeelingButton(
                    label: 'Happy',
                    image: 'assets/happy.png',
                    color: DefaultColors.pink,
                    onTap: () {
                      context.read<MoodMessageBloc>().add(LoadMoodMessage("happy"));

                      showCustomAlertDialog(
                        context,
                        title: "title",
                        message: "message",
                      );
                    },
                  ),
                  FeelingButton(
                    label: 'Calm',
                    image: 'assets/calm.png',
                    color: DefaultColors.pink,
                    onTap: () {},
                  ),
                  FeelingButton(
                    label: 'Relax',
                    image: 'assets/relax.png',
                    color: DefaultColors.pink,
                    onTap: () {},
                  ),
                  FeelingButton(
                    label: 'Focus',
                    image: 'assets/focus.png',
                    color: DefaultColors.pink,
                    onTap: () {},
                  ),
                ],
              ),
              20.vs(),
              BlocBuilder<DailyQuoteBloc, DailyQuoteState>(
                builder: (context, state) {
                  if (state is DailyQuoteLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is DailyQuoteLoaded) {
                    final quote = state.dailyQuote;
                    return Column(
                      children: [
                        Text(
                          'Today s Task',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        15.vs(),
                        TaskCard(
                          title: "Morning",
                          description: quote.morningQuote,
                          color: DefaultColors.task1,
                        ),
                        15.vs(),
                        TaskCard(
                          title: "Noon",
                          description: quote.noonQuote,
                          color: DefaultColors.task2,
                        ),
                        15.vs(),
                        TaskCard(
                          title: "Evening",
                          description: quote.eveningQuote,
                          color: DefaultColors.task3,
                        ),
                      ],
                    );
                  } else if (state is DailyQuoteError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('Something   wrong'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showCustomAlertDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = "OK",
    VoidCallback? onConfirm,
    String? cancelText,
    VoidCallback? onCancel,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap a button
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
           content: BlocBuilder<MoodMessageBloc, MoodMessageState>(
             builder: (context, state) {
               if (state is MoodMessageLoading) {
                 return SizedBox( height:20,width:20,child: CircularProgressIndicator());
               } else if (state is MoodMessageLoaded) {
                 return Text(state.moodMessage.text); // your entity field
               } else if (state is MoodMessageError) {
                 return Text("Error: ${state.errorMessage}");
               }
               return Text("Press button to load mood");
             },
           )
          ,
          actions: <Widget>[
            if (cancelText != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onCancel != null) onCancel();
                },
                child: Text(cancelText),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onConfirm != null) onConfirm();
              },
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }
}
