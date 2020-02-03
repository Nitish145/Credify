import 'dart:convert';

import 'package:credify/Models/user_data_model.dart';
import 'package:credify/globals.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<UserData> getUserData(String id) async {
  String endPoint = "/user/" + id;
  String uri = url + endPoint;

  try {
    var response = await client.get(uri, headers: header);
    final jsonResponse = jsonDecode(response.body);
    UserData userData = new UserData.fromJson(jsonResponse);
    print(jsonResponse);
    return userData;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
