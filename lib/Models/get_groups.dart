// To parse this JSON data, do
//
//     final groupData = groupDataFromJson(jsonString);

import 'dart:convert';

GroupData groupDataFromJson(String str) => GroupData.fromJson(json.decode(str));

String groupDataToJson(GroupData data) => json.encode(data.toJson());

class GroupData {
  String id;
  List<Friend> friends;
  String groupName;

  GroupData({
    this.id,
    this.friends,
    this.groupName,
  });

  factory GroupData.fromJson(Map<String, dynamic> json) => GroupData(
    id: json["_id"],
    friends: List<Friend>.from(json["friends"].map((x) => Friend.fromJson(x))),
    groupName: json["group_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "friends": List<dynamic>.from(friends.map((x) => x.toJson())),
    "group_name": groupName,
  };
}

class Friend {
  String mobileNumber;
  String name;

  Friend({
    this.mobileNumber,
    this.name,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
    mobileNumber: json["mobile_number"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "mobile_number": mobileNumber,
    "name": name,
  };
}
