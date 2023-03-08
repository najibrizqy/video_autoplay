import 'dart:convert';

import 'package:video_autoplay/src/models/video_model.dart';
import 'package:http/http.dart' as http;

class VideoService {
  Future<List<VideoModel>> fetchVideos() async {
    try {
      String url = 'https://api.shutterstock.com/v2/videos/search';
      String username = 'fYuG19H0SZK0rrXvBkyGpwOQKERrPSQB';
      String password = 'IrTcMnGBAXAg3rEu';
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': basicAuth,
        'User-Agent': 'ShutterstockWorkspace/1.1.30'
      };
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      print('${response.statusCode}');

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['data'];

        List<VideoModel> videoList = data
            .map<VideoModel>((video) => VideoModel.fromJson(video))
            .toList();
        return videoList;
      } else {
        throw Exception('Service : Gagal fetch video');
      }
    } catch (e) {
      throw e;
    }
  }
}
