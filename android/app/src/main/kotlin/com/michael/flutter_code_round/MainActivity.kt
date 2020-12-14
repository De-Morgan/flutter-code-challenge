package com.michael.flutter_code_round

import android.util.Log
import cn.jzvd.Jzvd
import com.michael.flutter_code_round.video_player.VideoViewFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val viewType = "plugins.video_player/view";

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.platformViewsController
                .registry.registerViewFactory(viewType, VideoViewFactory { viewId, videoView ->

                    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "video_player_$viewId").setMethodCallHandler { call, result ->
                        Log.d("MainActivity", "\"MethodChannel Registered with ${call.method} \"")

                        when (call.method) {

                            "loadUrl" -> {
                                Log.d("MainActivity", "\"Inside loadUrl \"")

                                val url = call.arguments.toString()
                                Log.d("MainActivity", "\"loadUrl is call with $url\"")
                                videoView.playVideo(url)
                                result.success(null)
                            }
                            else -> result.notImplemented()
                        }
                    }
                })
    }
}


