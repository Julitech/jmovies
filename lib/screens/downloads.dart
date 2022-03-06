import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jmovies/helpers/logic.dart';
import 'package:jmovies/helpers/values.dart';
import 'package:jmovies/providers/movie_downloads.dart';
import 'package:jmovies/widget/widgets.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:device_apps/device_apps.dart';
import 'package:android_intent/android_intent.dart';

class MovieDownloads extends StatefulWidget {
  @override
  _MovieDownloadsState createState() => _MovieDownloadsState();
}

class _MovieDownloadsState extends State<MovieDownloads> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MovieDownloadsProvider.listMovies(),
        builder: (BuildContext context,
            AsyncSnapshot<List<FileSystemEntity>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: MyLoadingSpinner());
          } else {
            if (snapshot.data.length < 1) {
              return Container(
                color: MyValues.mainWhite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/images/no_internet.jpeg",
                          fit: BoxFit.fill,
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                    Text(
                      "No Movies",
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Text(
                      "You haven't downloaded any movies yet!!!",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            } else {
              //Sort Files By Date
              snapshot.data.sort(
                (a, b) => b.statSync().changed.compareTo(a.statSync().changed),
              );
              return Container(
                color: Theme.of(context).backgroundColor,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, index) {
                    String movieTitle = snapshot.data[index].path.substring(38);
                    FileStat movieFileDetails = snapshot.data[index].statSync();

                    final date = movieFileDetails.changed;

                    final now = new DateTime.now();

                    final diff = now.difference(date);

                    var movieDownloadDate = now.subtract(diff);
                    String time = timeAgo.format(movieDownloadDate);
                    return Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                              offset: Offset(2, 2),
                              spreadRadius: 0.2)
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          movieTitle,
                          style: TextStyle(
                            color: MyValues.mainBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () async {
                          bool isFludInstalled =
                              await DeviceApps.isAppInstalled(
                                  "com.delphicoder.flud");
                          if (isFludInstalled) {
                            MyLogic.openFileChannel(
                              filePath: snapshot.data[index].path,
                            );
                          } else {
                            AndroidIntent intent = AndroidIntent(
                              action: "action_view",
                              data: Uri.encodeFull(
                                  "market://details?id=com.delphicoder.flud"),
                            );
                            intent.launch();
                          }
                        },
                        subtitle:
                            Text(time, style: TextStyle(color: Colors.black)),
                        trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              File(snapshot.data[index].path).delete();
                              showToast("Deleted Successfully");
                              setState(() {});
                            }),
                      ),
                    );
                  },
                ),
              );
            }
          }
        });
  }
}
