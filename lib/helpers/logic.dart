import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:jmovies/helpers/values.dart';
import 'package:jmovies/widget/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:device_apps/device_apps.dart';
import 'package:android_intent/android_intent.dart';

class MyLogic {
  //Check Internet Connectivity
  static Future<bool> checkInternet() async {
    bool isInternetAvailable = false;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isInternetAvailable = true;
        return isInternetAvailable;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  //Convert minutes to h:min
  static String getDuration(int mins) {
    double hour = mins / 60;
    int minutes = mins % 60;
    return '${hour.floor().toString()}h : ${minutes.toString()}min';
  }

  static void openFileChannel({@required String filePath}) async {
    try {
      var platform = MethodChannel("opentorrent");
      await platform.invokeMethod("openTorrentFile", {"path": filePath});
    } on PlatformException catch (error) {
      print(error);
      showToast("An error occurred");
    }
  }

  static void downloadFile(
    String title,
    String url,
    BuildContext context,
  ) async {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: MyValues.mainBlue, width: 2),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text(
                "Downloading File...Please Wait",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2,
              )
            ],
          ),
        ),
      ),
    );

    try {
      final directory = await getExternalStorageDirectory();
      String mainDir = directory.path
          .replaceFirst('Android/data/com.julitech.jmovies/files', "");
      final myDir = await Directory("$mainDir" + "JMovies/Downloads")
          .create(recursive: true);

      final response = await http.get(url).timeout(
        Duration(seconds: 20),
        onTimeout: () {
          throw "Error";
        },
      );

      File downloadedFile = await File(myDir.path + '/$title.torrent')
          .writeAsBytes(response.bodyBytes);

      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (ctx) => Dialog(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: MyValues.mainBlue, width: 2),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "How To Complete Download",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: 20),
                      Text(
                          "1. Proceed to Install Flud Torrent Downloader and Open it"),
                      SizedBox(height: 10),
                      Text(
                          "2. Click on + icon and locate Internal Storage/JMovies/Downloads"),
                      SizedBox(height: 10),
                      Text(
                          "3. Select the Movie File and Click + icon to start Download"),
                      SizedBox(height: 10),
                      Center(
                        child: RaisedButton(
                          color: MyValues.mainBlue.withOpacity(.2),
                          elevation: 0,
                          child: Text(
                            "Continue Download",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side:
                                BorderSide(width: 2, color: MyValues.mainBlue),
                          ),
                          onPressed: () async {
                            bool isFludInstalled =
                                await DeviceApps.isAppInstalled(
                                    "com.delphicoder.flud");
                            if (isFludInstalled) {
                              MyLogic.openFileChannel(
                                filePath: downloadedFile.path,
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
                        ),
                      ),
                    ],
                  ),
                ),
              ));
    } catch (e) {
      Navigator.pop(context);
      showToast("Download Failed");
    }
  }
}
