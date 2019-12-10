// To parse this JSON data, do
//
//     final referCode = referCodeFromJson(jsonString);

import 'dart:convert';

ReferCode referCodeFromJson(String str) => ReferCode.fromJson(json.decode(str));

String referCodeToJson(ReferCode data) => json.encode(data.toJson());

class ReferCode {
  String refCode;

  ReferCode({
    this.refCode,
  });

  factory ReferCode.fromJson(Map<String, dynamic> json) => ReferCode(
    refCode: json["ref_code"],
  );

  Map<String, dynamic> toJson() => {
    "ref_code": refCode,
  };
}