// To parse this JSON data, do
//
//     final autoWeeklyUpdateResponse = autoWeeklyUpdateResponseFromJson(jsonString);

import 'dart:convert';

AutoWeeklyUpdateResponse autoWeeklyUpdateResponseFromJson(String str) =>
    AutoWeeklyUpdateResponse.fromJson(json.decode(str));

String autoWeeklyUpdateResponseToJson(AutoWeeklyUpdateResponse data) =>
    json.encode(data.toJson());

class AutoWeeklyUpdateResponse {
  String id;
  bool updated;
  String message;

  AutoWeeklyUpdateResponse({
    this.id,
    this.updated,
    this.message,
  });

  factory AutoWeeklyUpdateResponse.fromJson(Map<String, dynamic> json) =>
      AutoWeeklyUpdateResponse(
        id: json["id"],
        updated: json["updated"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "updated": updated,
        "message": message,
      };
}
