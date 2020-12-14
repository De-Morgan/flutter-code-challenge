import 'package:flutter/services.dart';

class VideoPlayerController {
  MethodChannel _channel;

  VideoPlayerController.init(int id) {
    _channel = new MethodChannel('video_player_$id');
  }

  Future<void> loadUrl(String url) async {
    assert(url != null);
    return _channel.invokeMethod('loadUrl', url);
  }
}
