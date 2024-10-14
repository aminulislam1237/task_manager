import 'package:shared_preferences/shared_preferences.dart';

class Authcontroller {
  static final String _accessTokenkey = 'access-token';
  static String? accessToken;

 static Future<void> saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('access-token', token);
    accessToken= token;
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token =sharedPreferences.getString(_accessTokenkey);
    accessToken = token;
    return token;
  }
  static bool isLoggedIn(){
    return accessToken !=null;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
