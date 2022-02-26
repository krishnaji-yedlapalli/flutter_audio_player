
import 'package:audio_player/providers/audio_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class AudioPlayerView extends StatefulWidget {
  const AudioPlayerView({Key? key}) : super(key: key);

  @override
  _AudioPlayerViewState createState() => _AudioPlayerViewState();
}

class _AudioPlayerViewState extends State<AudioPlayerView> {

  @override
  void initState() {
      WidgetsBinding.instance?.addPostFrameCallback((_) => afterBuild());
      super.initState();
  }

  afterBuild(){
    Provider.of<AudioPlayerProvider>(context, listen: false).loadSongsFromAsset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildStream());
  }

  Widget _buildStream(){
    return StreamBuilder(
        stream: Provider.of<AudioPlayerProvider>(context, listen: false).streamCtrl.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Container(
                  alignment: Alignment.center,
                  child: Text('${snapshot.error}'),
                );
              } else {
                return _buildView();
              }
          }
        });
  }

  Widget _buildView() {
   return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://dw1ixebl10gex.cloudfront.net/wp-content/uploads/2020/12/21193856/crop-LivingRoom-091_TREES_HH_AP20_40.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Good Morning', style: TextStyle(color: Colors.white),),
                    Text('Chris Cooper', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
                  ],
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Icon(Icons.add, color: Colors.white,),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text('Living Room', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTempContainer(),
                  _buildPlayWall()

                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 150,
                  width: 160,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Consumer<AudioPlayerProvider>(
                      builder: (_, audioProvider, widget) {
                        var audio = audioProvider.selectedAudio;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            audio.imageUrl ?? ''),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(audio.name ?? '',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 11),),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildIcon(Icons.fast_rewind_rounded,
                                    audioProvider.previousBtn),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(14)
                                    ),
                                    alignment: Alignment.center,
                                    child: _buildIcon(
                                        audioProvider.isPlaying() ? Icons
                                            .pause_rounded : Icons.play_arrow,
                                        audioProvider.playOrPause),
                                  ),
                                ),
                                _buildIcon(Icons.fast_forward_rounded,
                                    audioProvider.nextBtn),
                              ],
                            ),

                          ],
                        );
                      })
                ),
                Container(
                  height: 150,
                  width: 160,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Smart TV', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                          Icon(Icons.chevron_right, color: Colors.white,)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text('Samsung UA55 4AC', style: TextStyle(color: Colors.white.withOpacity(0.8)),),
                      ),
                      _buildFlutterSwitch(false)
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon, VoidCallback? callBack) {
    return IconButton(onPressed: callBack, icon: Icon(icon, color: Colors.white,));
  }

  Widget _buildTempContainer() {
    return Container(
      width: 160,
      height: 180,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0)
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Text('Home \nTemperature', textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text('23', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
              ),
              Text('°C', style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
          _buildFlutterSwitch(true)
        ],
      ),
    );
  }


  Widget _buildPlayWall() {
    return Container(
      width: 160,
      height: 180,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10.0)
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Plug Wall', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              Icon(Icons.chevron_right, color: Colors.white,)
            ],
          ),
          Column(
            children: [
              _buildLabelWithBullet('Macbook Pro', Colors.white),
              _buildLabelWithBullet('HomePad', Color.fromRGBO(0, 0, 0, 0.5)),
              _buildLabelWithBullet('PlayStation 5', Colors.white),
            ],
          ),
          _buildFlutterSwitch(false)
        ],
      ),
    );
  }

  Widget _buildLabelWithBullet(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 5,
            width: 5,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color
            ),
          ),
          Text('$label', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),)
        ],
      ),
    );
  }

  Widget _buildFlutterSwitch(bool isSwitchOnOrOff) {
    return     FlutterSwitch(
        value: isSwitchOnOrOff,
        activeColor: Colors.orangeAccent,
        inactiveColor: Colors.white.withOpacity(0.6),
        toggleColor: Colors.white,
        inactiveToggleColor: Colors.white,
        toggleSize: 17,
        height: 23,
        width: 45,
        onToggle: (bool status) async{}
    );
  }
}
