import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_autoplay/src/cubit/video_cubit.dart';
import 'package:video_autoplay/src/models/video_model.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final VideoModel video;
  final GlobalKey globalKey;
  const VideoCard({super.key, required this.video, required this.globalKey});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _videoPlayerController;
  bool isMuted = false;
  bool isPlay = false;

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.network(widget.video.assets.thumbMp4.url)
          ..initialize().then((value) {
            _videoPlayerController.setLooping(true);
            _videoPlayerController.setVolume(0);
            if (widget.video.isPlay) {
              _videoPlayerController.play();
              if (mounted) {
                setState(() {
                  isPlay = true;
                });
              }
            } else {
              _videoPlayerController.pause();
              if (mounted) {
                setState(() {
                  isPlay = false;
                });
              }
            }
          });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoCubit, VideoState>(
      listener: ((context, state) {
        if (state is VideoSuccess) {
          for (int i = 0; i < state.video.length; i++) {
            if (widget.video.id == state.video[i].id) {
              if (state.video[i].isPlay) {
                _videoPlayerController.play();
                isPlay = true;
              } else {
                _videoPlayerController.pause();
                isPlay = false;
              }
            }
          }
        }
      }),
      builder: (context, state) {
        return Container(
          key: widget.globalKey,
          width: 130,
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  child: SizedBox(
                    width: _videoPlayerController.value.size.width,
                    height: _videoPlayerController.value.size.height,
                    child: VideoPlayer(_videoPlayerController),
                  ),
                ),
              ),
              isPlay
                  ? GestureDetector(
                      onTap: () {
                        if (isMuted) {
                          _videoPlayerController.setVolume(1);
                          setState(() {
                            isMuted = false;
                          });
                        } else {
                          _videoPlayerController.setVolume(0);
                          setState(() {
                            isMuted = true;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          isMuted
                              ? Icons.volume_off_outlined
                              : Icons.volume_up_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
