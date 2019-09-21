// To parse this JSON data, do
//
//     final pinInfo = pinInfoFromJson(jsonString);

import 'dart:convert';

List<PinInfo> pinInfoFromJson(String str) => List<PinInfo>.from(json.decode(str).map((x) => PinInfo.fromJson(x)));

String pinInfoToJson(List<PinInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PinInfo {
  String message;
  String status;
  List<PostOffice> postOffice;

  PinInfo({
    this.message,
    this.status,
    this.postOffice,
  });

  factory PinInfo.fromJson(Map<String, dynamic> json) => PinInfo(
    message: json["Message"],
    status: json["Status"],
    postOffice: List<PostOffice>.from(json["PostOffice"].map((x) => PostOffice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Status": status,
    "PostOffice": List<dynamic>.from(postOffice.map((x) => x.toJson())),
  };
}

class PostOffice {
  String name;
  dynamic description;
  String branchType;
  String deliveryStatus;
  String circle;
  String district;
  String division;
  String region;
  String block;
  String state;
  String country;
  String pincode;

  PostOffice({
    this.name,
    this.description,
    this.branchType,
    this.deliveryStatus,
    this.circle,
    this.district,
    this.division,
    this.region,
    this.block,
    this.state,
    this.country,
    this.pincode,
  });

  factory PostOffice.fromJson(Map<String, dynamic> json) => PostOffice(
    name: json["Name"],
    description: json["Description"],
    branchType: json["BranchType"],
    deliveryStatus: json["DeliveryStatus"],
    circle: json["Circle"],
    district: json["District"],
    division: json["Division"],
    region: json["Region"],
    block: json["Block"],
    state: json["State"],
    country: json["Country"],
    pincode: json["Pincode"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Description": description,
    "BranchType": branchType,
    "DeliveryStatus": deliveryStatus,
    "Circle": circle,
    "District": district,
    "Division": division,
    "Region": region,
    "Block": block,
    "State": state,
    "Country": country,
    "Pincode": pincode,
  };
}
