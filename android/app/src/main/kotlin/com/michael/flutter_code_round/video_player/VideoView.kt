package com.michael.flutter_code_round.video_player

import android.content.Context
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import cn.jzvd.Jzvd
import cn.jzvd.JzvdStd
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.platform.PlatformView


class VideoView(context: Context, viewId: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val jzvdStd: JzvdStd
    private val TAG = VideoView::class.simpleName;

    override fun getView(): View {
        return jzvdStd
    }


    override fun dispose() {}
    private fun getJzvStd(context: Context): JzvdStd {
        return LayoutInflater.from(context).inflate(layout.jz_video, null) as JzvdStd
    }

    fun playVideo(url: String) {
        jzvdStd.setUp(url, "", Jzvd.SCREEN_NORMAL)
    }


    init {
        jzvdStd = getJzvStd(context);
        Log.d(TAG, "\"Rendered on a native Android view (id: $viewId)\"")
    }
}
