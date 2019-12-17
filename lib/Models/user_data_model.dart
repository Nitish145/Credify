// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  String id;
  bool bankDetailsProvided;
  String bankingId;
  bool bankingVerified;
  String cardNumber;
  String documentsId;
  int documentsProgress;
  bool documentsUploaded;
  List<dynamic> groupId;
  bool isProfileUpdated;
  String kycId;
  int kycProgress;
  bool kycStatus;
  String loanId;
  bool loanTaken;
  String mobileNumber;
  List<dynamic> packages;
  int referrBonus;
  String referralCode;
  String referredBy;

  UserData({
    this.id,
    this.bankDetailsProvided,
    this.bankingId,
    this.bankingVerified,
    this.cardNumber,
    this.documentsId,
    this.documentsProgress,
    this.documentsUploaded,
    this.groupId,
    this.isProfileUpdated,
    this.kycId,
    this.kycProgress,
    this.kycStatus,
    this.loanId,
    this.loanTaken,
    this.mobileNumber,
    this.packages,
    this.referrBonus,
    this.referralCode,
    this.referredBy,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["_id"],
        bankDetailsProvided: json["bank_details_provided"],
        bankingId: json["banking_id"],
        bankingVerified: json["banking_verified"],
        cardNumber: json["card_number"],
        documentsId: json["documents_id"],
        documentsProgress: json["documents_progress"],
        documentsUploaded: json["documents_uploaded"],
        groupId: List<dynamic>.from(json["group_id"].map((x) => x)),
        isProfileUpdated: json["is_profile_updated"],
        kycId: json["kyc_id"],
        kycProgress: json["kyc_progress"],
        kycStatus: json["kyc_status"],
        loanId: json["loan_id"],
        loanTaken: json["loan_taken"],
        mobileNumber: json["mobile_number"],
        packages: List<dynamic>.from(json["packages"].map((x) => x)),
        referrBonus: json["referr_bonus"],
        referralCode: json["referral_code"],
        referredBy: json["referred_by"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "bank_details_provided": bankDetailsProvided,
        "banking_id": bankingId,
        "banking_verified": bankingVerified,
        "card_number": cardNumber,
        "documents_id": documentsId,
        "documents_progress": documentsProgress,
        "documents_uploaded": documentsUploaded,
        "group_id": List<dynamic>.from(groupId.map((x) => x)),
        "is_profile_updated": isProfileUpdated,
        "kyc_id": kycId,
        "kyc_progress": kycProgress,
        "kyc_status": kycStatus,
        "loan_id": loanId,
        "loan_taken": loanTaken,
        "mobile_number": mobileNumber,
        "packages": List<dynamic>.from(packages.map((x) => x)),
        "referr_bonus": referrBonus,
        "referral_code": referralCode,
        "referred_by": referredBy,
      };
}
