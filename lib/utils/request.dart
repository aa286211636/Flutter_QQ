import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class Request {
  static Future<dynamic> get({String action}) async {
    return Request.mock(action: action);
  }

  static Future<dynamic> mock({String action}) async {
    var responseStr = await rootBundle.loadString('mock/$action.json');
    var responseJson = json.decode(responseStr);
    return responseJson['data'];
  }
}
