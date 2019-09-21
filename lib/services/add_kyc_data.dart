import 'dart:convert';

import 'package:credify/Models/add_kyc_data_model.dart';
import 'package:http/http.dart' as http;

String url =
    "http://ec2-18-216-85-124.us-east-2.compute.amazonaws.com:5000/api/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<AddKycDataResponse> addKycData(String id, int stage,
    {String name,
    String dob,
    String pan,
    String aadhar,
    int pincode,
    String houseNumber,
    String locality,
    String city,
    String liveWith}) async {
  String endPoint = "/user/" + id + "/kyc/" + stage.toString();
  String uri = url + endPoint;

  var json = {};

  switch (stage) {
    case 1:
      {
        json = {
          "name": name,
          "dob": dob,
          "pan_number": pan,
          "aadhar_number": aadhar
        };
      }
      break;
    case 2:
      {
        json = {
          "pincode": pincode,
          "house_number": houseNumber,
          "locality": locality,
          "city": city,
        };
      }
      break;
    case 3:
      {
        json = {"live_with": liveWith};
      }
  }

  try {
    var response =
        await client.post(uri, body: jsonEncode(json), headers: header);
    final jsonResponse = jsonDecode(response.body);
    AddKycDataResponse addKycDataResponse =
        new AddKycDataResponse.fromJson(jsonResponse);
    print(jsonResponse);
    return addKycDataResponse;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
