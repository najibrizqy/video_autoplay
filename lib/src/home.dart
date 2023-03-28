import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_autoplay/src/cubit/video_cubit.dart';
import 'package:video_autoplay/src/models/video_model.dart';
import 'package:video_autoplay/src/widgets/video_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController controller;
  List<GlobalKey> _key = [];
  List<VideoModel> videoData = [];

  @override
  void initState() {
    context.read<VideoCubit>().fetchVideos();
    controller = ScrollController();

    controller.addListener(() {
      if (controller.hasClients) {
        getPosition();
      }
    });
    super.initState();
  }

  void getPosition() {
    int index = videoData.indexWhere((value) => value.isPlay == true);
    if (_key[index].currentContext != null) {
      RenderBox box =
          _key[index].currentContext!.findRenderObject() as RenderBox;
      Offset position =
          box.localToGlobal(Offset.zero); //this is global position
      double y = position.dy;
      log('card position $index = $y');
      bool isEven = index == 0
          ? true
          : index % 2 == 0
              ? true
              : false;
      context
          .read<VideoCubit>()
          .setAutoPlay(y, isEven, videoData[index].id, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocBuilder<VideoCubit, VideoState>(
          builder: (context, state) {
            if (state is VideoSuccess) {
              videoData = state.video;
              for (int i = 0; i < state.video.length; i++) {
                _key.add(new GlobalKey());
              }
              return GridView.count(
                controller: controller,
                crossAxisCount: 2,
                childAspectRatio: 0.80,
                children: List.generate(state.video.length, (index) {
                  return VideoCard(
                    video: state.video[index],
                    globalKey: _key[index],
                  );
                }),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
