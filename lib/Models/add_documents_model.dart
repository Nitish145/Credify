// To parse this JSON data, do
//
//     final addDocuments = addDocumentsFromJson(jsonString);

import 'dart:convert';

AddDocuments addDocumentsFromJson(String str) =>
    AddDocuments.fromJson(json.decode(str));

String addDocumentsToJson(AddDocuments data) => json.encode(data.toJson());

class AddDocuments {
  bool uploaded;

  AddDocuments({
    this.uploaded,
  });

  factory AddDocuments.fromJson(Map<String, dynamic> json) => AddDocuments(
        uploaded: json["uploaded"],
      );

  Map<String, dynamic> toJson() => {
        "uploaded": uploaded,
      };
}
