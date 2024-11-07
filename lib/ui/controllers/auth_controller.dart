import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/models/user_model.dart';

class Authcontroller {
  static final String _accessTokenkey = 'access-token';
  static final String _userDatakey = 'Userdata';
  
  static String? accessToken;
  static UserModel? userData;

  static Future<void> saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('access-token', token);
    accessToken = token;
  }

  static Future<void> saveUserData(UserModel usermodel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDatakey,jsonEncode(usermodel.toJson()));
    userData = usermodel;
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenkey);
    accessToken = token;
    return token;
  }

  static Future<UserModel?> getuserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userEncodedData = sharedPreferences.getString(_userDatakey);
    if (userEncodedData == null) {
      return null;
    }
    UserModel userModel = UserModel.fromJson(jsonDecode(userEncodedData));
    userData = userModel;
    return userModel;
  }

  static bool isLoggedIn() {
    return accessToken != null;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
