import 'dart:convert';

import 'package:http/http.dart' as http;

class Connect {
  final String _serverEndPoint = "http://192.168.35.152:3000";
  final Map<String, String> _headers = {"Mooky": "calendar", "content-type": "application/json"};

  Future<T?> reqPostServer<T>({required String path, required void Function(ReqModel) cb, Map<String, String>? headers, dynamic body}) async {
    String _path = path.trim();
    if (!path.trim().startsWith("/")) _path = "/" + _path;

    try {
      final http.Response _res = await http.post(Uri.parse(this._serverEndPoint + _path),
        headers: {...headers ?? {}, ...this._headers},
        body: json.encode(body),
      ).timeout(Duration(seconds: 13), onTimeout: () async => await http.Response("null", 404));
      cb(ReqModel(statusCode: _res.statusCode));

      print("connect-req post");
      return json.decode(_res.body) as T;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<T?> reqGetServer<T>({required String path, required void Function(ReqModel) cb, Map<String, String>? headers}) async {
    String _path = path.trim();
    if (!path.trim().startsWith("/")) _path = "/" + _path;

    try {
      final http.Response _res = await http.get(
          Uri.parse(this._serverEndPoint + _path),
          headers: {...headers ?? {}, ...this._headers}).timeout(Duration(seconds: 13), onTimeout: () async => http.Response("null", 404));
      cb(ReqModel(statusCode: _res.statusCode));

      print("connect-req get");
      return json.decode(_res.body) as T;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

class ReqModel {
  int statusCode;
  ReqModel({required this.statusCode});
}
