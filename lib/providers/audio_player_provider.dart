
import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/audio.dart';

class AudioPlayerProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  var playList = <Audio>[];
  int selectedSongIndex = 1;
  var streamCtrl = StreamController.broadcast();

  loadSongsFromAsset() async {
    final response = jsonDecode(await rootBundle.loadString('assets/audio_list.json'));
    playList =  response['data']
       .map<Audio>(
           (json) => Audio.fromJson(json))
        .toList();
    if(playList.isNotEmpty) {
      streamCtrl.add(playList);
      return;
    }
    streamCtrl.addError('No Songs are available to show');
  }



  playOrPause() async {
    var state = _audioPlayer.state;
    switch(state){
      case PlayerState.PLAYING:
       await _audioPlayer.pause();
        break;
      case PlayerState.PAUSED:
        await _audioPlayer.resume();
        break;
      case PlayerState.STOPPED:
        setSelectedSong();
        break;
    }
    notifyListeners();
  }

  setSelectedSong() async{
    await _audioPlayer.play(playList[selectedSongIndex].audioUrl ?? '');
    notifyListeners();
  }

  previousNextBtn([bool isPreviousBtn = false]) async{
    if(isPreviousBtn){
      --selectedSongIndex;
    }else{
      ++selectedSongIndex;
    }
    if(_audioPlayer.state == PlayerState.PLAYING) {
      await _audioPlayer.stop();
      setSelectedSong();
    }
    notifyListeners();
  }

  Audio get selectedAudio => playList[selectedSongIndex];

  /// Buttons status
  previousBtn() => selectedSongIndex != 0 ? previousNextBtn(true) : null;

  nextBtn() => selectedSongIndex >=  playList.length -1 ? null : previousNextBtn();

  bool isPlaying() => _audioPlayer.state == PlayerState.PLAYING;
}