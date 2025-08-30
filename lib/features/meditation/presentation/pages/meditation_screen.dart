import 'package:flutter/material.dart';
import 'package:metal_health_app/core/helper/extension.dart';
import 'package:metal_health_app/core/theme.dart';
import 'package:metal_health_app/features/meditation/presentation/widgets/feeling_button.dart';
import 'package:metal_health_app/features/meditation/presentation/widgets/task_card.dart';

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
                    onTap: () {},
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
              Text(
                'Todays Task',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              15.vs(),
              TaskCard(
                title: "Morning",
                description:
                    'Lets open up to the thing that matters among the people  ',
                color: DefaultColors.task1,
              ),15.vs(),
              TaskCard(
                title: "Noon",
                description:
                    'Lets open up to the thing that matters among the people  ',
                color: DefaultColors.task2,
              ),15.vs(),
              TaskCard(
                title: "Evening",
                description:
                    'Lets open up to the thing that matters among the people  ',
                color: DefaultColors.task3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
