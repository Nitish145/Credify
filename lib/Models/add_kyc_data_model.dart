// To parse this JSON data, do
//
//     final addKycDataResponse = addKycDataResponseFromJson(jsonString);

import 'dart:convert';

AddKycDataResponse addKycDataResponseFromJson(String str) =>
    AddKycDataResponse.fromJson(json.decode(str));

String addKycDataResponseToJson(AddKycDataResponse data) =>
    json.encode(data.toJson());

class AddKycDataResponse {
  String id;
  bool updated;

  AddKycDataResponse({
    this.id,
    this.updated,
  });

  factory AddKycDataResponse.fromJson(Map<String, dynamic> json) =>
      AddKycDataResponse(
        id: json["id"],
        updated: json["updated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "updated": updated,
      };
}
