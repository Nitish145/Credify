import 'package:credify/Screens/complete_KYC_1_screen.dart';
import 'package:credify/Screens/complete_KYC_2_screen.dart';
import 'package:credify/Screens/complete_KYC_3_screen.dart';
import 'package:credify/Screens/travel_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TravelCard extends StatefulWidget {
  final bool isLocked;
  final String imageLocation;
  final String place;
  final String daysNights;
  final String price;
  final String timeSpan;
  final bool kycStatus;
  final int kycProgress;

  const TravelCard(
      {Key key,
      this.imageLocation,
      this.place,
      this.daysNights,
      this.price,
      this.timeSpan,
      this.isLocked,
      this.kycStatus,
      this.kycProgress})
      : super(key: key);
  @override
  _TravelCardState createState() => _TravelCardState();
}

class _TravelCardState extends State<TravelCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          if (widget.kycStatus != null && widget.kycProgress != null) {
            if (!widget.isLocked) {
              if (!widget.kycStatus) {
                switch (widget.kycProgress) {
                  case 0:
                    {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CompleteKYC1()));
                    }
                    break;
                  case 1:
                    {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CompleteKYC2()));
                    }
                    break;
                  case 2:
                    {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CompleteKYC3()));
                    }
                }
              } else {
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
              }
            } else {
              Fluttertoast.showToast(
                  msg: "This Travel location is locked",
                  toastLength: Toast.LENGTH_LONG);
            }
          }
        },
        child: Container(
            height: 250,
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
              Container(
                  foregroundDecoration: widget.isLocked
                      ? BoxDecoration(
                          color: Colors.grey,
                          backgroundBlendMode: BlendMode.saturation,
                          borderRadius: BorderRadius.circular(8),
                        )
                      : BoxDecoration(),
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: FittedBox(
                        fit: BoxFit.fill,
                        child:
                            Center(child: Image.asset(widget.imageLocation))),
                  )),
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
              ),
              Positioned.fill(
                left: MediaQuery.of(context).size.width / 2,
                child: widget.isLocked
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.lock_outline, color: Colors.white),
                                Text(
                                  "Locked",
                                  textAlign: TextAlign.end,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .display3,
                                )
                              ],
                            )))
                    : Container(),
              ),
            ])),
      ),
    );
  }
}
