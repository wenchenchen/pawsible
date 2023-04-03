import 'dart:convert';
import 'package:flutter/services.dart';
//讀取設定檔案
//設定檔案放置在 assets/config/config.json
class AppConfig{
  static final AppConfig _instance = AppConfig._internal();
  AppConfig._internal() {
    // initialization logic
  }

  static Future<String?> getConfigString(String keyPath) async {

    final contents = await rootBundle.loadString('config/config.json');
    final json = jsonDecode(contents);
    if (json!=null){
      var value=getValueForKeyPath(json:json,path:keyPath);
      return value;
    }
  }

  static dynamic getValueForKeyPath({required Map<String, dynamic> json, required String path}) {
    final List<String> pathList = path.split('.');
    final List<String> remainingPath = path.split('.');

    for (String element in pathList) {
      remainingPath.remove(element);
      if (json[element] is Map<String, dynamic>) {
        return getValueForKeyPath(
            json: json[element], path: remainingPath.join('.'));
      } else {
        return json[element];
      }
    }
  }


}