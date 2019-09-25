// To parse this JSON data, do
//
//     final addGroup = addGroupFromJson(jsonString);

import 'dart:convert';

AddGroup addGroupFromJson(String str) => AddGroup.fromJson(json.decode(str));

String addGroupToJson(AddGroup data) => json.encode(data.toJson());

class AddGroup {
  bool updated;

  AddGroup({
    this.updated,
  });

  factory AddGroup.fromJson(Map<String, dynamic> json) => AddGroup(
        updated: json["updated"],
      );

  Map<String, dynamic> toJson() => {
        "updated": updated,
      };
}
