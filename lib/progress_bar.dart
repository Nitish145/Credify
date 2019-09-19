import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final double progress;
  final double height;
  final LinearGradient linearGradient;
  final Color backgroundColor;
  final BorderRadius borderRadius;

  const ProgressBar(
      {Key key,
      this.progress = 0,
      this.backgroundColor = Colors.white,
      this.height = 70.0,
      this.borderRadius,
      this.linearGradient})
      : super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: widget.borderRadius),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius,
                gradient: widget.linearGradient,
              ),
            ),
            flex: widget.progress ~/ 10,
          ),
          Expanded(
            child: Container(
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius,
                color: widget.backgroundColor,
              ),
            ),
            flex: 10 - widget.progress ~/ 10,
          ),
        ],
      ),
    );
  }
}
