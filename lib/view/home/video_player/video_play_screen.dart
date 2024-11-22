import 'package:flutter/material.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../model/video_item.dart';

class VideoPlayerScreen extends StatelessWidget {
  final VideoItem video;

  const VideoPlayerScreen({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(video.title)),
      body: Center(
        child: video.videoType == 'YouTube'
            ? YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId:
                      YoutubePlayer.convertUrlToId(video.videoUrl) ?? '',
                  flags: YoutubePlayerFlags(autoPlay: false),
                ),
              )
            : VimeoPlayer(
                videoId: video.videoUrl.split('/').last,
              ),
      ),
    );
  }
}
