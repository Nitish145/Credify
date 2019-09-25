import 'dart:convert';

import 'package:credify/Models/get_groups.dart';
import 'package:http/http.dart' as http;

String url =
    "http://ec2-18-216-85-124.us-east-2.compute.amazonaws.com:5000/api/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<GroupData> getGroupData(String id) async {
  String endPoint = "/group/" + id;
  String uri = url + endPoint;

  try {
    var response = await client.get(uri, headers: header);
    final jsonResponse = jsonDecode(response.body);
    GroupData groupData = new GroupData.fromJson(jsonResponse);
    print(jsonResponse);
    return groupData;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
