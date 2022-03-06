import 'dart:io';

import 'package:jmovies/widget/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MovieDownloadsProvider {
  static Future<List<FileSystemEntity>> listMovies() async {
    final permission = await Permission.storage.request();
    if (permission.isGranted) {
      List<FileSystemEntity> myDir;
      final directory = await getExternalStorageDirectory();
      String mainDir = directory.path
          .replaceFirst('Android/data/com.julitech.jmovies/files', "");
      try {
        myDir = Directory("$mainDir" + "JMovies/Downloads")
            .listSync(recursive: false);
      } catch (e) {
        myDir = [];
      }
      return myDir;
    } else {
      showToast("Grant Permission to Access your Movies");
      return [];
    }
  }
}
