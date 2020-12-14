import 'package:flutter/material.dart';
import 'package:flutter_code_round/priority_high/native_video_view.dart';

import 'prioritt_low/priority_low.dart';
import 'priority_high/video_player_controller.dart';
import 'priority_medium/priority_medium.dart';
import 'utils/context_extension.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _AppLanding(),
    );
  }
}

class _AppLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Landing page"),
      ),
      body: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                context.push(MyHomePage(
                  title: "Priority High",
                ));
              },
              child: Container(
                  width: double.infinity,
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: Text("Priority High")),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                context.push(PriorityTwo());
              },
              child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  color: Colors.yellow,
                  child: Text("Priority Medium")),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                context.push(PriorityLowPage());
              },
              child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  color: Colors.lightBlue,
                  child: Text("Priority Low")),
            ),
          )
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VideoPlayerController _playerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        child: NativeVideoView(
          onCreated: (VideoPlayerController controller) {
            controller.loadUrl(
                "https://cdn.videvo.net/videvo_files/video/free/2014-02/small_watermarked/Microscope_5__Scientist__Videvo_preview.webm");
          }, /*
         x: 20,y: 20,height: 400,width: 500,*/
        ),
      ),
    );
  }
}
