// To parse this JSON data, do
//
//     final otpResponse = otpResponseFromJson(jsonString);

import 'dart:convert';

OtpResponse otpResponseFromJson(String str) =>
    OtpResponse.fromJson(json.decode(str));

String otpResponseToJson(OtpResponse data) => json.encode(data.toJson());

class OtpResponse {
  bool exists;
  String isSent;

  OtpResponse({
    this.exists,
    this.isSent,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
        exists: json["exists"],
        isSent: json["is_sent"],
      );

  Map<String, dynamic> toJson() => {
        "exists": exists,
        "is_sent": isSent,
      };
}
