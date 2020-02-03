import 'dart:convert';

import 'package:credify/Models/submit_loan_request_response.dart';
import 'package:credify/globals.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<SubmitLoanRequestResponse> makeLoanRequest(
    String id, int totalAmount, String purposeOfLoan) async {
  String endPoint = "/user/$id/loan/request";
  String uri = url + endPoint;

  var json = {
    "total_amount": totalAmount.toString(),
    "purpose_of_loan": purposeOfLoan
  };

  try {
    http.Response response =
        await client.post(uri, body: jsonEncode(json), headers: header);
    final jsonResponse = jsonDecode(response.body);
    SubmitLoanRequestResponse submitLoanRequestResponse =
        new SubmitLoanRequestResponse.fromJson(jsonResponse);
    print(jsonResponse);
    return submitLoanRequestResponse;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
