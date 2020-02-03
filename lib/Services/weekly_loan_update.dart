import 'dart:convert';

import 'package:credify/Models/auto_weekly_update_response.dart';
import 'package:credify/globals.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<AutoWeeklyUpdateResponse> weeklyLoanUpdate(String id, int week,
    int week1, int week2, int week3, int week4, int weeklyAmountPaid) async {
  String endPoint = "/user/$id/loan/wupdate";
  String uri = url + endPoint;

  var json = {
    "week": week,
    "week1": week1,
    "week2": week2,
    "week3": week3,
    "week4": week4,
    "weekly_amount_paid": weeklyAmountPaid
  };

  try {
    http.Response response =
        await client.post(uri, body: jsonEncode(json), headers: header);
    final jsonResponse = jsonDecode(response.body);
    AutoWeeklyUpdateResponse weeklyUpdateResponse =
        new AutoWeeklyUpdateResponse.fromJson(jsonResponse);
    print(jsonResponse);
    return weeklyUpdateResponse;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
