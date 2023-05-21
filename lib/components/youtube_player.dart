import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyYoutubePlayer extends StatefulWidget {
  const MyYoutubePlayer({super.key});

  @override
  State<MyYoutubePlayer> createState() => _MyYoutubePlayerState();
}

class _MyYoutubePlayerState extends State<MyYoutubePlayer> {
  final videoURL =
      'https://www.youtube.com/watch?v=YMx8Bbev6T4&ab_channel=FlutterUIDev';
  late YoutubePlayerController youtubeController;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    youtubeController = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
          child: YoutubePlayer(
        controller: youtubeController,
        showVideoProgressIndicator: true,
        bottomActions: [
          CurrentPosition(),
          ProgressBar(
            isExpanded: true,
          )
        ],
      )),
    );
  }
}
