import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:greenleaf_insurance/map.dart' as ApiMap;
import 'package:shared_preferences/shared_preferences.dart';

import 'exceptionutils.dart';

enum RequestType{GET,POST,PUT,DELETE}

Uri _getUri(String path, Map<String,String>? params){
  return ApiMap.baseUrlSSL ? Uri.https(ApiMap.baseUrl, path, params)
      : Uri.http(ApiMap.baseUrl, path, params);
}

Future<void> _checkInternet() async{
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return;
    }
    throw ApiException.create('Kindly confirm your internet connection',0);
  } on SocketException catch (_) {
    throw ApiException.create('Kindly confirm your internet connection',0);
  }
}

Future<Map<String,String>> _getHeader() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = await pref.getString('token')??'';
  Map<String,String> result = {
    'Content-Type': 'application/json',
    'Authorization':  'Bearer $token',
    'User-Agent':'GREENLEAF-MOB-APP'
  };

  return result;
}

Future<dynamic> makeRequest(RequestType type, String path, String? body, Map<String,String>? params) async {
  await _checkInternet();
  try {
    Uri uri = _getUri(path, params);
    print(uri.host);
    switch (type) {
      case RequestType.POST:
        return await http.post(uri,
            headers: await _getHeader(),
            body: body);
      case RequestType.PUT:
        return await http.put(uri,
            headers: await _getHeader(),
            body: body);
      default:
        return await http.get(uri,
            headers: await _getHeader());
    }
  } on IOException {
    throw ApiException.create("Unable to reach downstream service",500);
  } on http.ClientException {
    throw ApiException.create("Error during connection",400);
  }
}

getResponse(http.Response rsp) {
  if (rsp.body.isEmpty) {
    throw ApiException.create('Failed to complete request, no body',rsp.statusCode);
  }
  try {
    Map<String, dynamic> json = jsonDecode(rsp.body);
    if (rsp.statusCode~/100 != 2) {
      print(json);
      throw ApiException.create(json['error'],rsp.statusCode);
    }
    print(json);
    return json;
  }on FormatException{
    throw ApiException.create(rsp.reasonPhrase??'Failed to complete request, kindly try again later',rsp.statusCode);
  }

}