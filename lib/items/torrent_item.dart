import 'package:flutter/material.dart';
import 'package:jmovies/helpers/logic.dart';
import 'package:jmovies/models/movie.dart';
import 'package:jmovies/widget/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class TorrentItem extends StatelessWidget {
  final String title;
  final Torrents torrents;

  TorrentItem(this.torrents, this.title);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    String quality = torrents.quality;
    String type = torrents.type.toUpperCase();
    String url = torrents.url;
    String size = torrents.size;
    String date = torrents.dateUploaded.substring(0, 10);

    return FlatButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (ctx) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    color: Colors.transparent,
                    height: 300,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 45,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: theme.primaryColor, width: 3),
                            ),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TitleRow("Quality:", "$quality $type"),
                                  SizedBox(height: 15),
                                  TitleRow("Size:", "$size"),
                                  SizedBox(height: 15),
                                  TitleRow("Date:", "$date"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(35)),
                              child: Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Colors.blue,
                                      spreadRadius: 2,
//                                      blurRadius: 3,
                                      offset: Offset(5, 47))
                                ]),
                                child: Image.asset(
                                  "assets/images/download.png",
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: 100,
                            alignment: Alignment.center,
                            child: FlatButton(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              color: theme.accentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                      color: theme.primaryColor, width: 3)),
                              onPressed: () async {
                                final permission =
                                    await Permission.storage.request();
                                if (permission.isGranted) {
                                  Navigator.of(context).pop();
                                  MyLogic.downloadFile(
                                      title + quality, url, context);
                                } else {
                                  showToast(
                                      "Please Grant Permission to Download this movie");
                                }
                              },
                              child: Text(
                                "Download File",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ));
      },
      padding: const EdgeInsets.all(0),
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 3),
        leading: Container(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(0),
          child: Image.asset(
            "assets/images/download.png",
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          '$quality $type',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
    );
  }
}
