// To parse this JSON data, do
//
//     final travelLoan = travelLoanFromJson(jsonString);

import 'dart:convert';

TravelLoan travelLoanFromJson(String str) => TravelLoan.fromJson(json.decode(str));

String travelLoanToJson(TravelLoan data) => json.encode(data.toJson());

class TravelLoan {
  bool updated;

  TravelLoan({
    this.updated,
  });

  factory TravelLoan.fromJson(Map<String, dynamic> json) => TravelLoan(
    updated: json["updated"],
  );

  Map<String, dynamic> toJson() => {
    "updated": updated,
  };
}
