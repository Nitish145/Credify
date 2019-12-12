import 'dart:convert';

import 'package:credify/Models/loan_details_response.dart';
import 'package:http/http.dart' as http;

String url =
    "http://ec2-3-133-147-228.us-east-2.compute.amazonaws.com:5000/api/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<LoanDetailsResponse> getLoanDetails(String id) async {
  String endPoint = "/user/$id/loan/details";
  String uri = url + endPoint;

  try {
    var response = await client.get(uri, headers: header);
    final jsonResponse = jsonDecode(response.body);
    LoanDetailsResponse loanDetailsResponse =
        new LoanDetailsResponse.fromJson(jsonResponse);
    print(jsonResponse);
    return loanDetailsResponse;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
