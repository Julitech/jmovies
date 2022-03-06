import 'package:flutter/material.dart';
import 'package:jmovies/helpers/values.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jmovies/widget/widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:android_intent/android_intent.dart';
import 'package:firebase_admob/firebase_admob.dart';

class MovieTrailer extends StatefulWidget {
  final String trailerCode;

  MovieTrailer(this.trailerCode);

  @override
  _MovieTrailerState createState() => _MovieTrailerState();
}

class _MovieTrailerState extends State<MovieTrailer> {
  YoutubePlayerController controller;
  YoutubeMetaData metaData;
  bool isPlayerReady = false;
  String videoStatus = "Video is Loading...Please wait";

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
      initialVideoId: widget.trailerCode,
      flags: YoutubePlayerFlags(
        hideControls: false,
        controlsVisibleAtStart: false,
        autoPlay: false,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Status: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    videoStatus,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: MyValues.mainBlue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: MyValues.accentColor, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: YoutubePlayer(
                    controller: controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.orange,
                    progressColors: ProgressBarColors(
                      playedColor: Colors.orange,
                      handleColor: Colors.orangeAccent,
                      backgroundColor: Colors.orange,
                    ),
                    onEnded: (metaData) {
                      setState(() {
                        videoStatus = "Video Ended";
                        isPlayerReady = false;
                      });
                    },
                    onReady: () {
                      videoStatus = "Video Loaded";
                      metaData = controller.metadata;
                      setState(() {
                        isPlayerReady = true;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.clear),
                    label: Text(
                      "CLOSE",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    elevation: 8,
                    color: Colors.white,
                    textColor: MyValues.mainBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(width: 2, color: MyValues.mainBlue),
                    ),
                  ),
                  RaisedButton.icon(
                    onPressed: () {
                      setState(() {
                        videoStatus = " Video Playing";
                      });
                      controller.play();
                    },
                    icon: Icon(Icons.play_arrow),
                    label: Text(
                      "PLAY",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    elevation: 8,
                    color: Colors.white,
                    textColor: MyValues.mainBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(width: 2, color: MyValues.mainBlue),
                    ),
                  ),
                  RaisedButton.icon(
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        videoStatus = " Video Stopped";
                      });
                      controller.pause();
                    },
                    icon: Icon(
                      Icons.stop,
                      color: Colors.white,
                    ),
                    label: Text(
                      "STOP",
                      style: TextStyle(color: Colors.white),
                    ),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              RaisedButton(
                onPressed: () {
                  AndroidIntent intent = AndroidIntent(
                    action: "action_view",
                    data: Uri.encodeFull(
                        "https://www.youtube.com/watch?v=${widget.trailerCode}"),
                  );
                  intent.launch();
                },
                color: Colors.white,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  "assets/images/youtube.png",
                  fit: BoxFit.fill,
                  height: 30,
                  width: 134,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrailerContainer extends StatefulWidget {
  final String ytTrailerCode;

  TrailerContainer(this.ytTrailerCode);

  @override
  _TrailerContainerState createState() => _TrailerContainerState();
}

class _TrailerContainerState extends State<TrailerContainer> {
  bool adLoaded = false;
  bool rewarded = false;
  bool watchClicked = false;

  Future<bool> loadAd(BuildContext ctx) async {
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: <String>["05B389ACB343AF5FABA03B5833C94C51"],
    );
    RewardedVideoAd.instance.load(
//      adUnitId: RewardedVideoAd.testAdUnitId,
      adUnitId: "ca-app-pub-1263747631032473/6637844470",
      targetingInfo: targetingInfo,
    );
    RewardedVideoAd.instance.listener = (
      RewardedVideoAdEvent event, {
      String rewardType,
      int rewardAmount,
    }) {
      if (event == RewardedVideoAdEvent.loaded) {
        if (watchClicked) {
          Navigator.pop(context);
          RewardedVideoAd.instance.show();
        }
      }
      if (event == RewardedVideoAdEvent.rewarded) {
        showToast("Close this Ad to watch Trailer");
        setState(() {
          rewarded = true;
        });
      }
      if (event == RewardedVideoAdEvent.closed) {
        if (rewarded) {
          showDialog(
            context: ctx,
            barrierDismissible: false,
            builder: (ctx) => Container(
              color: Colors.white.withOpacity(.3),
              child: MovieTrailer(widget.ytTrailerCode),
            ),
          );
        }
      }
    };
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.orange, width: 3),
      ),
      child: widget.ytTrailerCode.isEmpty
          ? Container(
              color: MyValues.mainBlue.withOpacity(.3),
              child: Center(
                child: Text(
                  "No Trailer Available",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            )
          : Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: CachedNetworkImage(
                      imageUrl: YoutubePlayer.getThumbnail(
                          videoId: widget.ytTrailerCode),
                      fit: BoxFit.cover,
                      height: 190,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: MyValues.mainBlue.withOpacity(.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () async {
                        bool ad = await loadAd(context);
                        showDialog(
                          context: context,
                          builder: (ctx) {
                            return Dialog(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    color: MyValues.mainBlue, width: 2),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Watch Trailer",
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "To Watch this Movie Trailer, just watch a short intersting Ad.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    MyFlatButton(
                                      Icons.play_circle_filled,
                                      "Watch",
                                      () {
                                        setState(() {
                                          watchClicked = true;
                                        });
                                        Navigator.pop(ctx);
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (cotx) {
                                            return Dialog(
                                              backgroundColor:
                                                  MyValues.mainWhite,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                side: BorderSide(
                                                    width: 2,
                                                    color: MyValues.mainBlue),
                                              ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    MyLoadingSpinner(),
                                                    SizedBox(height: 15),
                                                    Text(
                                                      "Loading...Please wait",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    FlatButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      textColor: Colors.red,
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      child: Text("Cancel"),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                        /*if (adLoaded) {
                                        Navigator.pop(context);
                                        showAd(context);
                                      } else {

                                        showToast("Please Wait For Ad to Load");
                                      }*/
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.play_circle_outline,
                            size: 60,
                            color: Colors.white,
                          ),
                          Text(
                            "Watch Trailer",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
