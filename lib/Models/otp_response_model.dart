// To parse this JSON data, do
//
//     final otpResponse = otpResponseFromJson(jsonString);

import 'dart:convert';

OtpResponse otpResponseFromJson(String str) => OtpResponse.fromJson(json.decode(str));

String otpResponseToJson(OtpResponse data) => json.encode(data.toJson());

class OtpResponse {
  String isSent;

  OtpResponse({
    this.isSent,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
    isSent: json["is_sent"],
  );

  Map<String, dynamic> toJson() => {
    "is_sent": isSent,
  };
}
