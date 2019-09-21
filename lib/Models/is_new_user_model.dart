// To parse this JSON data, do
//
//     final isNewUser = isNewUserFromJson(jsonString);

import 'dart:convert';

IsNewUser isNewUserFromJson(String str) => IsNewUser.fromJson(json.decode(str));

String isNewUserToJson(IsNewUser data) => json.encode(data.toJson());

class IsNewUser {
  bool exists;
  String id;

  IsNewUser({
    this.exists,
    this.id,
  });

  factory IsNewUser.fromJson(Map<String, dynamic> json) => IsNewUser(
        exists: json["exists"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "exists": exists,
        "id": id,
      };
}
