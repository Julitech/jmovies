import 'package:shared_preferences/shared_preferences.dart';

class MyPreferences {
  //Save first time launch details
  Future<bool> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool("seen") ?? false);
    return seen;
  }

  Future setFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("seen", true);
  }
}
