
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AudioPlayerProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  var audioPaths = <String>[];

  loadSongsFromAssets() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

     audioPaths = manifestMap.keys
        .where((String key) => key.contains('songs/'))
        .toList();
  }

  playLocal() async {
    int result = await _audioPlayer.play(audioPaths.first, isLocal: true);
  }
}