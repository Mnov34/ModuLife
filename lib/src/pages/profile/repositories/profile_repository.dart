import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  static const String profileKey = 'profile_key';

  Future<void> saveProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  }
}
