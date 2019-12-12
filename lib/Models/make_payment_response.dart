// To parse this JSON data, do
//
//     final makePaymentResponse = makePaymentResponseFromJson(jsonString);

import 'dart:convert';

MakePaymentResponse makePaymentResponseFromJson(String str) =>
    MakePaymentResponse.fromJson(json.decode(str));

String makePaymentResponseToJson(MakePaymentResponse data) =>
    json.encode(data.toJson());

class MakePaymentResponse {
  String id;
  bool updated;

  MakePaymentResponse({
    this.id,
    this.updated,
  });

  factory MakePaymentResponse.fromJson(Map<String, dynamic> json) =>
      MakePaymentResponse(
        id: json["id"],
        updated: json["updated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "updated": updated,
      };
}
