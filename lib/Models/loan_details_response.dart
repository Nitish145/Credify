// To parse this JSON data, do
//
//     final loanDetailsResponse = loanDetailsResponseFromJson(jsonString);

import 'dart:convert';

LoanDetailsResponse loanDetailsResponseFromJson(String str) =>
    LoanDetailsResponse.fromJson(json.decode(str));

String loanDetailsResponseToJson(LoanDetailsResponse data) =>
    json.encode(data.toJson());

class LoanDetailsResponse {
  String id;
  String startDate;
  int totalAmount;
  int week;
  int week1;
  int week2;
  int week3;
  int week4;
  int weeklyAmountPaid;

  LoanDetailsResponse({
    this.id,
    this.startDate,
    this.totalAmount,
    this.week,
    this.week1,
    this.week2,
    this.week3,
    this.week4,
    this.weeklyAmountPaid,
  });

  factory LoanDetailsResponse.fromJson(Map<String, dynamic> json) =>
      LoanDetailsResponse(
        id: json["_id"],
        startDate: json["start_date"],
        totalAmount: json["total_amount"],
        week: json["week"],
        week1: json["week1"],
        week2: json["week2"],
        week3: json["week3"],
        week4: json["week4"],
        weeklyAmountPaid: json["weekly_amount_paid"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "start_date": startDate,
        "total_amount": totalAmount,
        "week": week,
        "week1": week1,
        "week2": week2,
        "week3": week3,
        "week4": week4,
        "weekly_amount_paid": weeklyAmountPaid,
      };
}
