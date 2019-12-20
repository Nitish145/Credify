// To parse this JSON data, do
//
//     final panVerificationResponse = panVerificationResponseFromJson(jsonString);

import 'dart:convert';

PanVerificationResponse panVerificationResponseFromJson(String str) =>
    PanVerificationResponse.fromJson(json.decode(str));

String panVerificationResponseToJson(PanVerificationResponse data) =>
    json.encode(data.toJson());

class PanVerificationResponse {
  String messageCode;
  int statusCode;
  Data data;
  bool success;
  dynamic message;

  PanVerificationResponse({
    this.messageCode,
    this.statusCode,
    this.data,
    this.success,
    this.message,
  });

  factory PanVerificationResponse.fromJson(Map<String, dynamic> json) =>
      PanVerificationResponse(
        messageCode: json["message_code"],
        statusCode: json["status_code"],
        data: Data.fromJson(json["data"]),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message_code": messageCode,
        "status_code": statusCode,
        "data": data.toJson(),
        "success": success,
        "message": message,
      };
}

class Data {
  String panNumber;
  String clientId;
  String fullName;

  Data({
    this.panNumber,
    this.clientId,
    this.fullName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        panNumber: json["pan_number"],
        clientId: json["client_id"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "pan_number": panNumber,
        "client_id": clientId,
        "full_name": fullName,
      };
}
