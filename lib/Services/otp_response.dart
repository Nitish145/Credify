import 'dart:convert';

import 'package:credify/Models/otp_response_model.dart';
import 'package:credify/globals.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<OtpResponse> otpResponseService(String mobileNumber) async {
  String endPoint = "/send-message";
  String uri = url + endPoint;

  var json = {
    "mobile_number": "91$mobileNumber",
    "sms_type": "otp",
    "sms_message": ""
  };

  try {
    http.Response response =
        await client.post(uri, body: jsonEncode(json), headers: header);
    final jsonResponse = jsonDecode(response.body);
    OtpResponse otpResponse = new OtpResponse.fromJson(jsonResponse);
    print(jsonResponse);
    return otpResponse;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
