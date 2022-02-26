
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/audio.dart';

class AudioPlayerProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  var playList = <Audio>[];
  int selectedSongIndex = 0;

  loadSongsFromAsset() async {
    final response = jsonDecode(await rootBundle.loadString('assets/audio_list.json'));
    playList =  response['data']
       .map<Audio>(
           (json) => Audio.fromJson(json))
        .toList();
  }



  playOrPause() async {
    var state = _audioPlayer.state;
    switch(state){
      case PlayerState.PLAYING:
        _audioPlayer.pause();
        break;
      case PlayerState.PAUSED:
        _audioPlayer.resume();
        break;
      case PlayerState.STOPPED:
        setSelectedSong();
        break;
    }
  }

  setSelectedSong() {
    _audioPlayer.play(playList[selectedSongIndex].audioUrl ?? '');
  }

  previousNextBtn([bool isPreviousBtn = false]){
    if(isPreviousBtn){
      --selectedSongIndex;
    }else{
      ++selectedSongIndex;
    }
    setSelectedSong();
  }

}