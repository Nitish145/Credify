import 'dart:convert';

import 'package:credify/Models/total_referral_bonus_model.dart';
import 'package:http/http.dart' as http;

String url =
    "http://ec2-3-133-147-228.us-east-2.compute.amazonaws.com:5000/api/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<TotalReferralBonus> getTotalReferral(String id) async {
  String endPoint = "/user/referral/" + id;
  String uri = url + endPoint;

  try {
    var response = await client.get(uri, headers: header);
    final jsonResponse = jsonDecode(response.body);
    TotalReferralBonus totalReferralBonus =
        new TotalReferralBonus.fromJson(jsonResponse);
    print(jsonResponse);
    return totalReferralBonus;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
