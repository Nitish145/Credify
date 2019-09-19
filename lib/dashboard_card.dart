import 'package:flutter/material.dart';

class DashboardCard extends StatefulWidget {
  final String imageLocation;
  final bool isAtBottom;
  final String heading;
  final String subheading;
  final bool isDark;

  const DashboardCard(
      {Key key,
      this.isAtBottom,
      this.heading,
      this.subheading,
      this.isDark,
      this.imageLocation})
      : super(key: key);
  @override
  _DashboardCardState createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: MediaQuery.of(context).size.height / 3.4,
          width: MediaQuery.of(context).size.width / 1.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(229, 93, 135, .2),
                    Color.fromRGBO(95, 195, 228, .2)
                  ])),
          child: Stack(children: <Widget>[
            Image.asset(widget.imageLocation, fit: BoxFit.fill),
            Column(
              mainAxisAlignment: widget.isAtBottom
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.heading,
                      style: widget.isDark
                          ? Theme.of(context)
                              .accentTextTheme
                              .display2
                              .copyWith(fontWeight: FontWeight.bold)
                          : Theme.of(context)
                              .primaryTextTheme
                              .display2
                              .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 15, top: 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.subheading,
                      style: widget.isDark
                          ? Theme.of(context)
                              .accentTextTheme
                              .display4
                              .copyWith(fontWeight: FontWeight.w400)
                          : Theme.of(context)
                              .primaryTextTheme
                              .display4
                              .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            )
          ])),
    );
  }
}
