import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code_round/priority_high/constant.dart';
import 'package:flutter_code_round/priority_high/video_player_controller.dart';

import 'video_player_callback.dart';

class NativeVideoView extends StatelessWidget {
  final VideoPlayerCreatedCallback onCreated;

  const NativeVideoView({Key key, @required this.onCreated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String vT = viewType;
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return PlatformViewLink(
      viewType: vT,
      surfaceFactory:
          (BuildContext context, PlatformViewController controller) {
        return AndroidViewSurface(
          controller: controller,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (PlatformViewCreationParams params) {
        onCreated(VideoPlayerController.init(params.id));
        return PlatformViewsService.initSurfaceAndroidView(
          id: params.id,
          viewType: vT,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: StandardMessageCodec(),
        )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..create();
      },
    );
  }
}
