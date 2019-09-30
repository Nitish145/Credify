import 'dart:convert';

import 'package:credify/Models/user_data_model.dart';
import 'package:http/http.dart' as http;

String url =
    "http://ec2-18-216-85-124.us-east-2.compute.amazonaws.com:5000/api/v1";
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
