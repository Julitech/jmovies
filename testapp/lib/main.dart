import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/movieList.dart';

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
        // is not restarted.
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  bool isPlayerReady = false;
//  YoutubeMetaData youtubeMetaData;
//  String playerState = "Video Loading...Please Wait";
//  YoutubePlayerController controller = YoutubePlayerController(
////    initialVideoId: 'iHibnmosKkM',
//    initialVideoId: "ptLZlrE8MrQ",
//    flags: YoutubePlayerFlags(
//      hideControls: false,
//      controlsVisibleAtStart: false,
//      autoPlay: false,
//    ),
//  );

  Future<void> openTorrent() async {
//    const platform = MethodChannel("openfile");
//    try {
//      await platform.invokeMethod(
//        "openTorrentFile",
//        {
//          "file":
//              "/storage/emulated/0/JMovies/Downloads/The Wishmas Tree (2020)720p.torrent"
//        },
//      );
//    } on PlatformException catch (e) {
//      print("Platform Error $e");
//    }
    try {
      String url =
          "https://yts.mx/api/v2/list_movies.json?genre=Action&sort_by=year&limit=20&page=3";
      print(url);
      final response = await http.get(url);
      final result = json.decode(response.body) as Map<String, dynamic>;
//      final List<dynamic> data = MovieList.fromJson(result).toJson()["movies"];
//      final List<dynamic> data = Wel.fromJson(result).data.toJson()["movies"];
      final List<dynamic> data =
          MovieList.fromJson(result).data.toJson()["movies"];
      print(data);
//      List cool = data[1]
      return data;
    } on ArgumentError catch (e) {
      print("An Error Occurred $e");
//      throw "Error";
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TestApp"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder(
            future: openTorrent(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                print(snapshot.data.toString());
                return Container();
              }
            }),

        /*child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  YoutubePlayer.getThumbnail(videoId: "ptLZlrE8MrQ"),
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(playerState),
//            Text(isPlayerReady ? "Playing" : "Not Playing"),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue, width: 2)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: YoutubePlayer(
                  controller: controller,
                  topActions: <Widget>[
                    Text("Movie Trailer"),
                  ],
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.orange,
                  progressColors: ProgressBarColors(
                    playedColor: Colors.orange,
                    handleColor: Colors.orangeAccent,
                    backgroundColor: Colors.orange,
                  ),
                  onEnded: (metaData) {
                    setState(() {
                      playerState = "Video Stopped";
                      isPlayerReady = false;
                    });
                  },
                  onReady: () {
                    youtubeMetaData = controller.metadata;
                    playerState = "Video Loaded";
                    setState(() {
                      isPlayerReady = true;
                    });
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton.icon(
                  color: Colors.orange,
                  onPressed: () {
                    controller.reload();
                  },
                  icon: Icon(
                    Icons.replay,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Replay",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                FlatButton.icon(
                  color: Colors.blue,
                  onPressed: !controller.value.isPlaying
                      ? () {
                          setState(() {
                            playerState = "Video Playing";
                          });
                          controller.play();
                        }
                      : () {
                          print("Video is Playing Already");
                        },
                  icon: Icon(Icons.play_circle_filled, color: Colors.white),
                  label: Text(
                    "Play",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                FlatButton.icon(
                  color: Colors.red,
                  onPressed: () {
                    controller.dispose();
                  },
                  icon: Icon(
                    Icons.stop,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Stop",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),*/
      ),
    );
  }
}
