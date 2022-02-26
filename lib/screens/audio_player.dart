
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
      // WidgetsBinding.instance?.addPostFrameCallback((_) => afterBuildContext());
      Provider.of<AudioPlayerProvider>(context, listen: false).loadSongsFromAsset();
      super.initState();
  }

  afterBuildContext(){
    Provider.of<AudioPlayerProvider>(context, listen: false).loadSongsFromAsset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    _buildContainer(Colors.white, true),
                    _buildContainer(Colors.grey.withOpacity(0.9), false)
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration:  BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage('https://dw1ixebl10gex.cloudfront.net/wp-content/uploads/2020/12/21193856/crop-LivingRoom-091_TREES_HH_AP20_40.jpg'),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text('Midnight Love \n Girl in red', textAlign: TextAlign.start, style: TextStyle(color: Colors.white, fontSize: 11),),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(onPressed: (){}, icon: Icon(Icons.fast_rewind_rounded, color: Colors.white,)),
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
                                child: Icon(Icons.pause_rounded, color: Colors.white,),
                              ),
                            ),
                            IconButton(onPressed: (){}, icon: Icon(Icons.fast_forward_rounded, color: Colors.white,)),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 160,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [

                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(Color color, bool isSwitchOnOrOff) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0)
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          FlutterSwitch(
              value: isSwitchOnOrOff,
              activeColor: Colors.orangeAccent,
              inactiveColor: Colors.white.withOpacity(0.6),
              toggleColor: Colors.white,
              inactiveToggleColor: Colors.white,
              toggleSize: 17,
              height: 23,
              width: 45,
              onToggle: (bool status) async{}
          ),
        ],
      ),
    );
  }
}
