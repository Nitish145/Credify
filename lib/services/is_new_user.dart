import 'dart:convert';

import 'package:credify/Models/is_new_user_model.dart';
import 'package:http/http.dart' as http;

String url = "http://ec2-18-216-85-124.us-east-2.compute.amazonaws.com:5000/api/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<IsNewUser> isNewUser(String mobileNumber) async {
  String endPoint = "/users/" + mobileNumber;
  String uri = url + endPoint;

  try {
    var response = await client.get(uri);
    final jsonResponse = jsonDecode(response.body);
    IsNewUser isNewUser = new IsNewUser.fromJson(jsonResponse);
    print(jsonResponse);
    return isNewUser;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
