import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:metal_health_app/features/songs/data/data_source/song_remote_data_source.dart';
import 'package:metal_health_app/features/songs/presentation/bloc/song_bloc.dart';
import 'package:metal_health_app/features/songs/presentation/pages/song_player_screen.dart';

import '../../../../core/theme.dart';

class PlaylistScreen extends StatelessWidget {
  PlaylistScreen({super.key});
  final List<Map<String, String>> songs = [
    {
      'title': 'Rain On Glass',
      'artist': 'Rain On Glass',
      'thumbnail': 'assets/child_with_dog.png',
    },
    {
      'title': 'Gentle Breeze',
      'artist': 'Soothing Sounds',
      'thumbnail': 'assets/child_with_dog.png',
    },
    {
      'title': 'Whispering Pines',
      'artist': 'Nature Vibes',
      'thumbnail': 'assets/child_with_dog.png',
    },
    {
      'title': 'Ocean Waves Breeze',
      'artist': 'Soothing Sounds',
      'thumbnail': 'assets/child_with_dog.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chill Playlist',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: DefaultColors.white,
        elevation: 1,
        centerTitle: false,
      ),
      body: BlocBuilder<SongBloc, SongState>(
        builder: (context, state) {
          if (state is SongLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SongLoaded) {
            return ListView.builder(
              itemCount: state.songs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage( songs[index]['thumbnail']!),//todo add image url in database
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 15),
                  title: Text(state.songs[index].title),
                  subtitle: Text(
                    state.songs[index].author,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  onTap: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SongPlayerScreen(song: state.songs[index],),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is SongError) {
            Center(child: Text(state.errorMessage));
          }
          return Center(child:  Text( 'No songs found'),);
        },
      ),
    );
  }
}
