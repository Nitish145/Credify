import 'package:flutter/material.dart';

Widget getCustomProgressLoader(String message, BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 1.3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
            Text(
              message,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
