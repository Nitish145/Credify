// To parse this JSON data, do
//
//     final endLoanResponse = endLoanResponseFromJson(jsonString);

import 'dart:convert';

EndLoanResponse endLoanResponseFromJson(String str) =>
    EndLoanResponse.fromJson(json.decode(str));

String endLoanResponseToJson(EndLoanResponse data) =>
    json.encode(data.toJson());

class EndLoanResponse {
  String id;
  bool updated;

  EndLoanResponse({
    this.id,
    this.updated,
  });

  factory EndLoanResponse.fromJson(Map<String, dynamic> json) =>
      EndLoanResponse(
        id: json["id"],
        updated: json["updated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "updated": updated,
      };
}
