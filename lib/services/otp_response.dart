import 'dart:convert';

import 'package:credify/Models/otp_response_model.dart';
import 'package:http/http.dart' as http;

String url = "http://ec2-18-216-85-124.us-east-2.compute.amazonaws.com/api/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<OtpResponse> otpResponseService(
    String mobileNumber, String smsType, String smsMessage) async {
  String endPoint = "/send-message";
  String uri = url + endPoint;

  var json = {
    "mobile_number": mobileNumber,
    "sms_type": smsType,
    "sms_message": smsMessage
  };

  try {
    var response = await client.post(uri, body: json);
    final jsonResponse = jsonDecode(response.body);
    OtpResponse otpResponse = new OtpResponse.fromJson(jsonResponse);
    print(jsonResponse);
    return otpResponse;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
