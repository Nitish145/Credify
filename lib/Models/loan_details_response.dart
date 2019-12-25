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
  String purposeOfLoan;
  String startDate;
  int totalAmount;
  int week;
  double week1;
  double week2;
  double week3;
  double week4;
  int weeklyAmountPaid;

  LoanDetailsResponse({
    this.id,
    this.purposeOfLoan,
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
        purposeOfLoan: json["purpose_of_loan"],
        startDate: json["start_date"],
        totalAmount: json["total_amount"],
        week: json["week"],
        week1: double.parse(json["week1"].toString()),
        week2: double.parse(json["week2"].toString()),
        week3: double.parse(json["week3"].toString()),
        week4: double.parse(json["week4"].toString()),
        weeklyAmountPaid: json["weekly_amount_paid"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "purpose_of_loan": purposeOfLoan,
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
