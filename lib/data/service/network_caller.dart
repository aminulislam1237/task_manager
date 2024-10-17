import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screen/sing_in_screen.dart';

class networkcaller {
  static Future<networkResponse> getRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      // Change headers to Map<String, String>
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'token': Authcontroller.accessToken.toString()
      };
      debugPrint(url);
      printRequest(url, body, headers);

      final Response response =
          await post(uri, headers: headers, body: jsonEncode(body));

      printResponse(url, response);

      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return networkResponse(
            isSuccess: true,
            statuscode: response.statusCode,
            responseDate: decodeData);
      } else if (response.statusCode == 401) {
        _movetoLogin();
        return networkResponse(
            isSuccess: false,
            statuscode: response.statusCode,
            errormassage: "Unauthenticated");
      } else {
        return networkResponse(
          isSuccess: false,
          statuscode: response.statusCode,
        );
      }
    } catch (e) {
      return networkResponse(
        isSuccess: false,
        statuscode: -1,
        errormassage: e.toString(),
      );
    }
  }

  static Future<networkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      // Change headers to Map<String, String>
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'token': Authcontroller.accessToken.toString()
      };
      debugPrint(url);
      printRequest(url, body, headers);

      final Response response =
          await post(uri, headers: headers, body: jsonEncode(body));

      printResponse(url, response);

      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return networkResponse(
            isSuccess: true,
            statuscode: response.statusCode,
            responseDate: decodeData);
      } else if (response.statusCode == 401) {
        _movetoLogin();
        return networkResponse(
            isSuccess: false,
            statuscode: response.statusCode,
            errormassage: "Unauthenticated");
      } else {
        return networkResponse(
          isSuccess: false,
          statuscode: response.statusCode,
        );
      }
    } catch (e) {
      return networkResponse(
        isSuccess: false,
        statuscode: -1,
        errormassage: e.toString(),
      );
    }
  }

  static void printRequest(
      String url, Map<String, dynamic>? body, Map<String, dynamic>? header) {
    debugPrint(
      'REQUEST:\nURL:$url\nBODY: $body}\nHEADER: $header',
    );
  }

  static void printResponse(String url, Response response) {
    debugPrint(
        'URL:$url\n RESPONSE CODE:${response.statusCode}\nBODY: ${response.body}');
  }

  static void _movetoLogin() async {
    await Authcontroller.clearUserData();
    final context = taskmanager.navigatorkey.currentContext;

    if (context != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => singinscreen()),
        (route) => false,
      );
    } else {
      debugPrint('Navigation context is null');
    }
  }
}
