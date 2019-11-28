import 'dart:convert';

import 'package:credify/Models/travel_loan_response_model.dart';
import 'package:http/http.dart' as http;

String url =
    "http://ec2-3-133-147-228.us-east-2.compute.amazonaws.com:5000/api/v1";
var headers = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<TravelLoan> travelLoanService(
    String userId,
    String startDate,
    String endDate,
    String commuteType,
    int commuteCode,
    List<String> travellers,
    bool isActive,
    int loanAmount,
    String packageCode,
    String packageId) async {
  String endPoint = "/travel/add";
  String uri = url + endPoint;

  var json = {
    "user_id": userId,
    "start_date": startDate,
    "end_date": endDate,
    "commute_type": commuteType,
    "commute_code": commuteCode,
    "travelers": travellers,
    "is_active": isActive,
    "loan_amount_pm": loanAmount,
    "package_code": packageCode,
    "package_id": packageId
  };

  try {
    http.Response response =
        await client.post(uri, body: jsonEncode(json), headers: headers);
    final jsonResponse = jsonDecode(response.body);
    TravelLoan travelLoanResponse = new TravelLoan.fromJson(jsonResponse);
    print(jsonResponse);
    return travelLoanResponse;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
