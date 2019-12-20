import 'dart:convert';

import 'package:credify/Models/pan_verification_response.dart';
import 'package:http/http.dart' as http;

String token =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NzY3NjI0NDAsImp0aSI6IjhiOWE2MjVmLWIxOWEtNDkwOC05YzExLTc0OTNmNmUxZTNmNyIsInR5cGUiOiJhY2Nlc3MiLCJ1c2VyX2NsYWltcyI6eyJzY29wZXMiOlsicmVhZCJdfSwibmJmIjoxNTc2NzYyNDQwLCJmcmVzaCI6ZmFsc2UsImV4cCI6MTU4MTk0NjQ0MCwiaWRlbnRpdHkiOiJkZXYuY3JlZGZpbmFuY2VAYWFkaGFhcmFwaS5pbyJ9.AZNVrEsOs4zWv5LjwV9V6aoP5pTt-i85Abc7_Wy9JtE";
String uri = "https://sandbox.aadhaarapi.io/api/v1/pan/pan";

var headers = {
  "Content-Type": "application/json",
  "Authorization": "Bearer $token"
};

http.Client client = new http.Client();

Future<PanVerificationResponse> verifyPan(
  String panNumber,
) async {
  var json = {"id_number": panNumber};

  try {
    http.Response response =
        await client.post(uri, body: jsonEncode(json), headers: headers);
    final jsonResponse = jsonDecode(response.body);
    PanVerificationResponse panVerificationResponse =
        new PanVerificationResponse.fromJson(jsonResponse);
    print(jsonResponse);
    return panVerificationResponse;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
