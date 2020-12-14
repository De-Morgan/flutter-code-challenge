package com.michael.flutter_code_round.video_player


import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

internal class VideoViewFactory(var onViewCreated: (viewId: Int, videoView: VideoView) -> Unit) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        val videoView = VideoView(context, id, creationParams);
        onViewCreated(id, videoView);
        return videoView;

    }
}
