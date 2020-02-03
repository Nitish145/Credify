import 'dart:convert';

import 'package:credify/Models/card_data_model.dart';
import 'package:credify/globals.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<CardData> getCardData(String id) async {
  String endPoint = "/user/$id/card";
  String uri = url + endPoint;

  try {
    var response = await client.get(uri, headers: header);
    final jsonResponse = jsonDecode(response.body);
    CardData cardData = new CardData.fromJson(jsonResponse);
    print(jsonResponse);
    return cardData;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
