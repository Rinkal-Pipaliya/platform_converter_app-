import 'package:shared_preferences/shared_preferences.dart';

class ShareHelper {
  void saveIntrostatus() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    await shr.setBool('Intro status', true);
  }

  Future<bool?> readIntrostatus() async {
    SharedPreferences shr = await SharedPreferences.getInstance();

    bool? status = shr.getBool('Intro status');
    return status;
  }
}
