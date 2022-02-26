
import 'package:audio_player/providers/audio_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPlayerView extends StatefulWidget {
  const AudioPlayerView({Key? key}) : super(key: key);

  @override
  _AudioPlayerViewState createState() => _AudioPlayerViewState();
}

class _AudioPlayerViewState extends State<AudioPlayerView> {

  @override
  void initState() {
      WidgetsBinding.instance?.addPostFrameCallback((_) => afterBuildContext());
    super.initState();
  }

  afterBuildContext(){
    Provider.of<AudioPlayerProvider>(context, listen: false).loadSongsFromAssets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        children: [
          ElevatedButton(onPressed: (){
            Provider.of<AudioPlayerProvider>(context, listen: false).playLocal();
          }, child: const Text('Play'))
        ],
        ),
      ),
    );
  }
}
