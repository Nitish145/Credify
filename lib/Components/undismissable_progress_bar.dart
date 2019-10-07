import 'package:credify/Components/custom_progress_bar.dart';
import 'package:credify/globals.dart';
import 'package:flutter/material.dart';

class UndismissableProgressBar extends StatelessWidget {
  final String message;

  const UndismissableProgressBar({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
            child: Center(child: getCustomProgressLoader(message, context)),
          )
        ],
      );
    }
    return Container();
  }
}
