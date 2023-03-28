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
      double position, bool isEven, String id, int index) async {
    emit(VideoLoading());
    video.map((e) {
      if (e.id == id) {
        if (isEven) {
          if (position > -30 && position < 72) {
            e.isPlay = false;
            video[index + 1].isPlay = true;
          } else if (position > 216) {
            e.isPlay = false;
            video[index - 1].isPlay = true;
          }
        } else {
          if (position < -30) {
            e.isPlay = false;
            video[index + 1].isPlay = true;
          } else if (position > 72) {
            e.isPlay = false;
            video[index - 1].isPlay = true;
          }
        }
      }
    }).toList();
    emit(VideoSuccess(video: video));
  }
}
