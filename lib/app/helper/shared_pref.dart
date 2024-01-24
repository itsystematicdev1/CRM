import 'package:salesman/main.dart';

class SharedPreferencesService {
  Future<void> saveUid(String uid) async {
    sharedpref!.setString('uid', uid);
  }

  Future<String?> getUid() async {
    return sharedpref!.getString('uid');
  }

  Future<void> clearUid() async {
    sharedpref!.remove('uid');
  }

  //? bool is login to app

  Future<void> setIsLoggedIn(bool login) =>
      sharedpref!.setBool('logged_in', login);

  bool isLoggedIn() => sharedpref!.getBool('logged_in') ?? false;
}
