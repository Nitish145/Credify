// To parse this JSON data, do
//
//     final totalReferralBonus = totalReferralBonusFromJson(jsonString);

import 'dart:convert';

TotalReferralBonus totalReferralBonusFromJson(String str) => TotalReferralBonus.fromJson(json.decode(str));

String totalReferralBonusToJson(TotalReferralBonus data) => json.encode(data.toJson());

class TotalReferralBonus {
  int referrBonus;

  TotalReferralBonus({
    this.referrBonus,
  });

  factory TotalReferralBonus.fromJson(Map<String, dynamic> json) => TotalReferralBonus(
    referrBonus: json["referr_bonus"],
  );

  Map<String, dynamic> toJson() => {
    "referr_bonus": referrBonus,
  };
}
