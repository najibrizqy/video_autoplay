// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

VideoModel videoModelFromJson(String str) =>
    VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  VideoModel({
    required this.id,
    required this.aspect,
    required this.aspectRatio,
    required this.assets,
    required this.contributor,
    required this.description,
    required this.duration,
    required this.hasModelRelease,
    required this.mediaType,
    required this.originalFilename,
    required this.isPlay,
  });

  String id;
  double aspect;
  String aspectRatio;
  Assets assets;
  Contributor contributor;
  String description;
  int duration;
  bool hasModelRelease;
  String mediaType;
  String originalFilename;
  bool isPlay;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"],
        aspect: json["aspect"]?.toDouble(),
        aspectRatio: json["aspect_ratio"],
        assets: Assets.fromJson(json["assets"]),
        contributor: Contributor.fromJson(json["contributor"]),
        description: json["description"],
        duration: json["duration"],
        hasModelRelease: json["has_model_release"],
        mediaType: json["media_type"],
        originalFilename: json["original_filename"],
        isPlay: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "aspect": aspect,
        "aspect_ratio": aspectRatio,
        "assets": assets.toJson(),
        "contributor": contributor.toJson(),
        "description": description,
        "duration": duration,
        "has_model_release": hasModelRelease,
        "media_type": mediaType,
        "original_filename": originalFilename,
        "isPlay": isPlay,
      };
}

class Assets {
  Assets({
    required this.thumbWebm,
    required this.thumbMp4,
    required this.previewWebm,
    required this.previewMp4,
    required this.thumbJpg,
    required this.previewJpg,
  });

  PreviewJpg thumbWebm;
  PreviewJpg thumbMp4;
  PreviewJpg previewWebm;
  PreviewJpg previewMp4;
  PreviewJpg thumbJpg;
  PreviewJpg previewJpg;

  factory Assets.fromJson(Map<String, dynamic> json) => Assets(
        thumbWebm: PreviewJpg.fromJson(json["thumb_webm"]),
        thumbMp4: PreviewJpg.fromJson(json["thumb_mp4"]),
        previewWebm: PreviewJpg.fromJson(json["preview_webm"]),
        previewMp4: PreviewJpg.fromJson(json["preview_mp4"]),
        thumbJpg: PreviewJpg.fromJson(json["thumb_jpg"]),
        previewJpg: PreviewJpg.fromJson(json["preview_jpg"]),
      );

  Map<String, dynamic> toJson() => {
        "thumb_webm": thumbWebm.toJson(),
        "thumb_mp4": thumbMp4.toJson(),
        "preview_webm": previewWebm.toJson(),
        "preview_mp4": previewMp4.toJson(),
        "thumb_jpg": thumbJpg.toJson(),
        "preview_jpg": previewJpg.toJson(),
      };
}

class PreviewJpg {
  PreviewJpg({
    required this.url,
  });

  String url;

  factory PreviewJpg.fromJson(Map<String, dynamic> json) => PreviewJpg(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Contributor {
  Contributor({
    required this.id,
  });

  String id;

  factory Contributor.fromJson(Map<String, dynamic> json) => Contributor(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
