import 'dart:convert';

import 'package:credify/Models/make_payment_response.dart';
import 'package:http/http.dart' as http;

String url =
    "http://ec2-3-133-147-228.us-east-2.compute.amazonaws.com:5000/api/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<MakePaymentResponse> makeLoanPayment(
    String id, int weeklyAmountPaid, int payAmount) async {
  String endPoint = "/user/$id/loan/payment";
  String uri = url + endPoint;

  var json = {"weekly_amount_paid": weeklyAmountPaid, "pay_amount": payAmount};

  try {
    http.Response response =
        await client.post(uri, body: jsonEncode(json), headers: header);
    final jsonResponse = jsonDecode(response.body);
    MakePaymentResponse makePaymentResponse =
        new MakePaymentResponse.fromJson(jsonResponse);
    print(jsonResponse);
    return makePaymentResponse;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}