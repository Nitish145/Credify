// To parse this JSON data, do
//
//     final submitLoanRequestResponse = submitLoanRequestResponseFromJson(jsonString);

import 'dart:convert';

SubmitLoanRequestResponse submitLoanRequestResponseFromJson(String str) =>
    SubmitLoanRequestResponse.fromJson(json.decode(str));

String submitLoanRequestResponseToJson(SubmitLoanRequestResponse data) =>
    json.encode(data.toJson());

class SubmitLoanRequestResponse {
  String id;
  bool updated;

  SubmitLoanRequestResponse({
    this.id,
    this.updated,
  });

  factory SubmitLoanRequestResponse.fromJson(Map<String, dynamic> json) =>
      SubmitLoanRequestResponse(
        id: json["id"],
        updated: json["updated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "updated": updated,
      };
}
