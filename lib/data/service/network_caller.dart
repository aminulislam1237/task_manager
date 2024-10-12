import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:task_manager/data/models/network_response.dart';

class networkcaller {
  static Future<networkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(url);
      final Response response = await get(uri);
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return networkResponse(
            isSuccess: true,
            statuscode: response.statusCode,
            responseDate: decodeData);
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
  static Future<networkResponse>postRequest(String url, Map<String, dynamic>?body) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(url);
      final Response response = await post(uri,
          headers: {
        'Content-Type': 'application/json'
          },
          body: jsonEncode(body));
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return networkResponse(
            isSuccess: true,
            statuscode: response.statusCode,
            responseDate: decodeData);
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

  static void printResponse(String url, Response response) {
    debugPrint(
        'URL:$url\n RESPONSE CODE:${response.statusCode}\nBODY: ${response.body}');
  }
}
