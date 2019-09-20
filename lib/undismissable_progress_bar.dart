import 'package:flutter/material.dart';

class UndismissableProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.8,
          child: const ModalBarrier(
            dismissible: false,
            color: Colors.black45,
          ),
        ),
        Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
      ],
    );
  }
}
