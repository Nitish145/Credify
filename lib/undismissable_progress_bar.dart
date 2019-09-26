import 'package:credify/globals.dart';
import 'package:flutter/material.dart';

class UndismissableProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1.65,
            child: Opacity(
              opacity: 0.8,
              child: const ModalBarrier(
                dismissible: false,
                color: Colors.black45,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          )
        ],
      );
    }
    return Container();
  }
}
