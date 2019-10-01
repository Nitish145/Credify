// To parse this JSON data, do
//
//     final cardData = cardDataFromJson(jsonString);

import 'dart:convert';

CardData cardDataFromJson(String str) => CardData.fromJson(json.decode(str));

String cardDataToJson(CardData data) => json.encode(data.toJson());

class CardData {
  String cardNumber;
  String userName;

  CardData({
    this.cardNumber,
    this.userName,
  });

  factory CardData.fromJson(Map<String, dynamic> json) => CardData(
    cardNumber: json["card_number"],
    userName: json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "card_number": cardNumber,
    "user_name": userName,
  };
}
