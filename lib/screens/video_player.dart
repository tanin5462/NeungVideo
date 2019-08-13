import 'package:flutter/material.dart';
import 'package:neung_video/models/video_model.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayer extends StatefulWidget {
  final VideoModel videoModel;
  VideoPlayer({Key key, this.videoModel}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  // Explicit

  VideoModel videoModel;
  String urlVideo = '';
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  // Methods

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      videoModel = widget.videoModel;
      urlVideo = videoModel.videoPath;
      print('UrlVideo = $urlVideo');
      videoPlayerController = VideoPlayerController.network(urlVideo);
      chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          aspectRatio: 3 / 2,
          autoPlay: true,
          looping: true);
    });
  }

  @override
  // dispose หมายถึง destroy package ทั้งหมดในหน้านี้เมื่อกด back หรือปิด
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}
