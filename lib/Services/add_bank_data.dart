import 'dart:convert';

import 'package:credify/Models/bank_details_response.dart';
import 'package:credify/globals.dart';
import 'package:http/http.dart' as http;

http.Client client = new http.Client();
var header = {"Content-Type": "application/json"};

Future<BankDetailsResponse> addBankData(
    String id,
    String bankName,
    String accountNumber,
    String ifscCode,
    String accountName,
    String accountType) async {
  String endPoint = "/user/$id/kyc/bank";
  Uri uri = Uri.parse(url + endPoint);

  var json = {
    "bank_name": bankName,
    "ac_no": accountNumber,
    "ifsc_code": ifscCode,
    "ac_holder_name": accountName,
    "ac_type": accountType
  };

  try {
    var response =
        await client.post(uri, body: jsonEncode(json), headers: header);
    final jsonResponse = jsonDecode(response.body);
    BankDetailsResponse bankDetailsResponse =
        new BankDetailsResponse.fromJson(jsonResponse);
    print(jsonResponse);
    return bankDetailsResponse;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
