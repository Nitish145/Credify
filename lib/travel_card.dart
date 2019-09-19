import 'package:credify/detail_screen.dart';
import 'package:flutter/material.dart';

class TravelCard extends StatefulWidget {
  final String imageLocation;
  final String place;
  final String daysNights;
  final String price;
  final String timeSpan;

  const TravelCard(
      {Key key,
      this.imageLocation,
      this.place,
      this.daysNights,
      this.price,
      this.timeSpan})
      : super(key: key);
  @override
  _TravelCardState createState() => _TravelCardState();
}

class _TravelCardState extends State<TravelCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TravelDetailScreen(
                        imageLocation: widget.imageLocation,
                        place: widget.place,
                        daysNights: widget.daysNights,
                        price: widget.price,
                        timeSpan: widget.timeSpan,
                      )));
        },
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.place,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .display1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 5, top: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.daysNights,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .display4
                            .copyWith(fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.price,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .display2
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 2),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.timeSpan,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .display4
                            .copyWith(fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ],
              )
            ])),
      ),
    );
  }
}
