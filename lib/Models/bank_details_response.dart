// To parse this JSON data, do
//
//     final bankDetailsResponse = bankDetailsResponseFromJson(jsonString);

import 'dart:convert';

BankDetailsResponse bankDetailsResponseFromJson(String str) => BankDetailsResponse.fromJson(json.decode(str));

String bankDetailsResponseToJson(BankDetailsResponse data) => json.encode(data.toJson());

class BankDetailsResponse {
  String id;
  bool updated;

  BankDetailsResponse({
    this.id,
    this.updated,
  });

  factory BankDetailsResponse.fromJson(Map<String, dynamic> json) => BankDetailsResponse(
    id: json["id"],
    updated: json["updated"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "updated": updated,
  };
}
