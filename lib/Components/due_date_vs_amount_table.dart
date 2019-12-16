import 'dart:math';

import 'package:credify/colors.dart';
import 'package:credify/globals.dart';
import 'package:flutter/material.dart';

class DashBoardLoanTable extends StatelessWidget {
  final Map<String, double> relationMap;

  const DashBoardLoanTable({Key key, this.relationMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget getDueDateAmountRow(String date, double amount, Color color) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 75,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: credifyBlack, width: 1.5)),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 24,
                    width: 100,
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: credifyBlack,
                        )),
                  ),
                  Container(
                    height: 48,
                    width: 100,
                    child: Center(
                      child: Text(date),
                    ),
                  )
                ],
              ),
            ),
            Text(amount.toString())
          ],
        ),
      );
    }

    Color getRandomColor() {
      var rng = new Random();
      return colorMap[rng.nextInt(colorMap.length).toString()];
    }

    List<Widget> getMultipleRows() {
      List<Widget> rowList = [];
      relationMap.forEach((dueDate, amount) {
        rowList.add(getDueDateAmountRow(dueDate, amount, getRandomColor()));
      });
      return rowList;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Due Date",
                  style: Theme.of(context)
                      .accentTextTheme
                      .display4
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Amount",
                  style: Theme.of(context)
                      .accentTextTheme
                      .display4
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Column(
              children: getMultipleRows(),
            )
          ],
        ),
      ),
    );
  }
}
