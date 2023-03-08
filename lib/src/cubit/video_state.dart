part of 'video_cubit.dart';

@immutable
abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoSuccess extends VideoState {
  List<VideoModel> video;
  VideoSuccess({required this.video});

  VideoSuccess copyWith({required List<VideoModel> video}) {
    return VideoSuccess(
      video: video,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [video];
}

class VideoFailed extends VideoState {
  final String message;
  VideoFailed(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
