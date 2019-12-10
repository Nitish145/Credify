import 'dart:convert';

import 'package:credify/Models/refer_code_response.dart';
import 'package:http/http.dart' as http;

String url =
    "http://ec2-3-133-147-228.us-east-2.compute.amazonaws.com:5000/api/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<ReferCode> getReferCode(String userId) async {
  String endPoint = "/user/referral";
  String uri = url + endPoint;

  var json = {"user_id": userId};

  try {
    var response =
        await client.post(uri, body: jsonEncode(json), headers: header);
    final jsonResponse = jsonDecode(response.body);
    ReferCode referCode = new ReferCode.fromJson(jsonResponse);
    print(jsonResponse);
    return referCode;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
