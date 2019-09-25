// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  String id;
  String mobileNumber;
  bool kycStatus;
  int kycProgress;
  String kycId;
  bool bankingVerified;
  String bankingId;
  int documentsProgress;
  bool documentsUploaded;
  String documentsId;
  List<String> packages;
  List<String> groupId;

  UserData({
    this.id,
    this.mobileNumber,
    this.kycStatus,
    this.kycProgress,
    this.kycId,
    this.bankingVerified,
    this.bankingId,
    this.documentsProgress,
    this.documentsUploaded,
    this.documentsId,
    this.packages,
    this.groupId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["_id"],
    mobileNumber: json["mobile_number"],
    kycStatus: json["kyc_status"],
    kycProgress: json["kyc_progress"],
    kycId: json["kyc_id"],
    bankingVerified: json["banking_verified"],
    bankingId: json["banking_id"],
    documentsProgress: json["documents_progress"],
    documentsUploaded: json["documents_uploaded"],
    documentsId: json["documents_id"],
    packages: List<String>.from(json["packages"].map((x) => x)),
    groupId: List<String>.from(json["group_id"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "mobile_number": mobileNumber,
    "kyc_status": kycStatus,
    "kyc_progress": kycProgress,
    "kyc_id": kycId,
    "banking_verified": bankingVerified,
    "banking_id": bankingId,
    "documents_progress": documentsProgress,
    "documents_uploaded": documentsUploaded,
    "documents_id": documentsId,
    "packages": List<dynamic>.from(packages.map((x) => x)),
    "group_id": List<dynamic>.from(groupId.map((x) => x)),
  };
}
