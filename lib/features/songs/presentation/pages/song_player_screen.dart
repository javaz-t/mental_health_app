import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../core/theme.dart';
import '../../domain/entities/domain.dart';

class SongPlayerScreen extends StatefulWidget {
  final Song song;
  const SongPlayerScreen({super.key, required this.song});

  @override
  State<SongPlayerScreen> createState() => _SongPlayerScreenState();
}

class _SongPlayerScreenState extends State<SongPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool isLooping = false;
  @override
  void initState() {
    _audioPlayer = AudioPlayer();//todo: need to add these songs in in the db
    _audioPlayer.setUrl("https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3");
    super.initState();
  }

  void togglePlayPause() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  void seekBackward() {
    final currentPosition = _audioPlayer.position;
    final newPosition = currentPosition - Duration(seconds: 10);
    _audioPlayer.seek(
      newPosition >= Duration.zero ? newPosition : Duration.zero,
    );
  }

  void seekForward() {
    final currentPosition = _audioPlayer.position;
    final newPosition = currentPosition + Duration(seconds: 10);
    _audioPlayer.seek(newPosition);
  }

  void toggleLoop() {
    setState(() {
      isLooping = !isLooping;
      _audioPlayer.setLoopMode(isLooping ? LoopMode.one : LoopMode.off);
    });
  }

  void seekRestart(){
    _audioPlayer.seek(Duration.zero);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: Image.asset('assets/down_arrow.png'),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Image.asset('assets/transcript_icon.png'),
          const SizedBox(width: 16),
        ],
      ),
      backgroundColor: DefaultColors.white,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // artwork
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/child_with_dog.png',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "widget.song.title",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              'By :  widget.song.author}',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const Spacer(),
            StreamBuilder(
              stream: _audioPlayer.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final total = _audioPlayer.duration ?? Duration.zero;
                return ProgressBar(
                  progress: position,
                  total: total,
                  onSeek: (duration) {
                    _audioPlayer.seek(duration);
                  },
                );
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.shuffle, color: DefaultColors.pink),
                ),
                IconButton(
                  onPressed: () {
                    seekBackward();
                  },
                  icon: Icon(Icons.skip_previous, color: DefaultColors.pink),
                ),
                StreamBuilder(stream: _audioPlayer.playerStateStream, builder: (context,snapshot){
                  final playerState =  snapshot.data;
                  final processingState = playerState?.processingState??ProcessingState.idle;
                  final playing = playerState?.playing??false;
                  if(processingState==ProcessingState.loading||processingState==ProcessingState.buffering){
                    return Center(child:CircularProgressIndicator(),);
                  }else if(!playing){
                    return IconButton(
                      iconSize: 80,
                      onPressed: () {
                        togglePlayPause();
                      },
                      icon: Icon(Icons.pause_circle_rounded),
                      color: DefaultColors.pink,
                    );
                  }else if (processingState != ProcessingState.completed){
                    return IconButton(
                      iconSize: 80,
                      onPressed: () {
                        togglePlayPause();
                      },
                      icon: Icon(Icons.pause_circle_rounded),
                      color: DefaultColors.pink,
                    );
                  }else{
                    return    IconButton(
                      iconSize: 80,
                      onPressed: () {
                        seekRestart();
                      },
                      icon: Icon(Icons.replay_circle_filled),
                      color: DefaultColors.pink,
                    );
                  }
                })
                , //
                IconButton(
                  onPressed: () {
                    seekBackward();
                  },
                  icon: Icon(Icons.skip_next, color: DefaultColors.pink),
                ),
                IconButton(
                  onPressed: () {
                    toggleLoop();
                  },
                  icon: Icon(isLooping?Icons.repeat_one:Icons.repeat, color: DefaultColors.pink),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
