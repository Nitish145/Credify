import 'dart:convert';

import 'package:credify/Models/pin_info.dart';
import 'package:http/http.dart' as http;

String url = "https://api.postalpincode.in/pincode";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<PinInfo> pinInfoService(String pin) async {
  String endPoint = "/" + pin;
  String uri = url + endPoint;

  try {
    var response = await client.get(uri);
    final jsonResponse = jsonDecode(response.body);
    PinInfo pinInfo = new PinInfo.fromJson(jsonResponse[0]);
    print(jsonResponse[0]);
    return pinInfo;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
