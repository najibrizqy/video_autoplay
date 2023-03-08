import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:video_autoplay/src/models/video_model.dart';
import 'package:video_autoplay/src/services/video_service.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoInitial());

  List<VideoModel> video = [];

  void fetchVideos() async {
    try {
      emit(VideoLoading());
      video = await VideoService().fetchVideos();
      emit(VideoSuccess(video: video));
      video.asMap().forEach((index, value) {
        if (index == 0) {
          value.isPlay = true;
        }
      });
    } catch (e) {
      log('error $e');
      emit(VideoFailed(e.toString()));
    }
  }

  Future<void> setAutoPlay(
      double position, String cardPosition, String id, int index) async {
    emit(VideoLoading());
    video.map((e) {
      if (e.id == id) {
        if (cardPosition == 'right') {
          if (position < 75.0 && position > 5.0) {
            e.isPlay = true;
          } else {
            e.isPlay = false;
          }
        } else {
          if (position > 75 && position < 255) {
            e.isPlay = true;
          } else {
            e.isPlay = false;
          }
        }
      }
    }).toList();
    emit(VideoSuccess(video: video));
  }
}
