import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyYoutubePlayer extends StatefulWidget {
  const MyYoutubePlayer({super.key});

  @override
  State<MyYoutubePlayer> createState() => _MyYoutubePlayerState();
}

class _MyYoutubePlayerState extends State<MyYoutubePlayer> {
  final videoURL =
      'https://www.youtube.com/watch?v=JL5NMI4YSyA&ab_channel=%D7%A0%D7%A8%D7%99%D7%94%D7%96%D7%95%D7%93%D7%99';
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
