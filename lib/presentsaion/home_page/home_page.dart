import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metal_health_app/features/meditation/presentation/pages/meditation_screen.dart';
import 'package:metal_health_app/presentsaion/bottom_nav_bar/bloc/navigation_bloc.dart';
import 'package:metal_health_app/presentsaion/bottom_nav_bar/widget/bottom_nav_bar.dart';
import '../../features/songs/presentation/pages/playlist_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> pages = [MeditationScreen(), PlaylistScreen()];
/*@override
  void initState() {
  context.read<DailyQuoteBloc>().add(LoadDailyQuote());
    super.initState();
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          int currentIndex = 0;

          if (state is NavigationChanged) {
            currentIndex = state.index;
          }
          final List<BottomNavigationBarItem> bottomNavBar = [
            customBottomNavBarItem(
              context,
              path: 'assets/menu_home.png',
              isActive: currentIndex == 0,
            ),
            customBottomNavBarItem(
              context,
              path: 'assets/menu_songs.png',
              isActive: currentIndex == 1,
            ),
          ];

          return BottomNavBar(items: bottomNavBar, currentIndex: currentIndex);
        },
      ),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          print('State name : $state');

          if (state is NavigationChanged) {

            return pages[state.index];
          }
          return pages[0];
        },
      ),
    );
  }

  BottomNavigationBarItem customBottomNavBarItem(
    BuildContext context, {
    required String path,
    required bool isActive,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        path,
        color: !isActive
            ? Theme.of(context).focusColor
            : Theme.of(context).primaryColor,
      ),
      label: '',
    );
  }
}
