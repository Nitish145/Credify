import 'dart:convert';

import 'package:credify/Models/is_new_user_model.dart';
import 'package:credify/globals.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<IsNewUser> isNewUser(String mobileNumber, String referredBy) async {
  String endPoint = "/users/" + mobileNumber;
  String uri = url + endPoint;

  var json = {"referred_by": referredBy};

  try {
    var response =
        await client.post(uri, body: jsonEncode(json), headers: header);
    final jsonResponse = jsonDecode(response.body);
    IsNewUser isNewUser = new IsNewUser.fromJson(jsonResponse);
    print(jsonResponse);
    return isNewUser;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
