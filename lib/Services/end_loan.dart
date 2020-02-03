import 'dart:convert';

import 'package:credify/Models/end_loan_response.dart';
import 'package:credify/globals.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<EndLoanResponse> endLoan(String id) async {
  String endPoint = "/user/$id/loan/end";
  String uri = url + endPoint;

  try {
    var response = await client.get(uri, headers: header);
    final jsonResponse = jsonDecode(response.body);
    EndLoanResponse endLoanResponse =
        new EndLoanResponse.fromJson(jsonResponse);
    print(jsonResponse);
    return endLoanResponse;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
