import 'package:flutter/material.dart';

class TravelDetailScreen extends StatefulWidget {
  final String imageLocation;
  final String place;
  final String daysNights;
  final String price;
  final String timeSpan;

  const TravelDetailScreen(
      {Key key,
      this.imageLocation,
      this.place,
      this.daysNights,
      this.price,
      this.timeSpan})
      : super(key: key);
  @override
  _TravelDetailScreenState createState() => _TravelDetailScreenState();
}

class _TravelDetailScreenState extends State<TravelDetailScreen> {
  String dropdownValue = "Iteneary";
  DateTime initialSelectedDate = DateTime.now();
  DateTime finalSelectedDate = DateTime.now().add(Duration(days: 3));
  var formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Widget detailedScreenAppBar() {
      return Container(
        color: Colors.black,
        child: SafeArea(
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(children: <Widget>[
                Center(
                    child: Image.asset(
                  widget.imageLocation,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.fill,
                )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 5, top: 20),
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
                              padding: const EdgeInsets.only(
                                  left: 5, bottom: 5, top: 5),
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
                          ],
                        )
                      ],
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

    Future<Null> _selectInitialDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: initialSelectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != initialSelectedDate)
        setState(() {
          initialSelectedDate = picked;
        });
    }

    Future<Null> _selectFinalDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: finalSelectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != finalSelectedDate)
        setState(() {
          finalSelectedDate = picked;
        });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            detailedScreenAppBar(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(45, 156, 219, 1)),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 24,
                  elevation: 16,
                  style: Theme.of(context).accentTextTheme.display3,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Iteneary']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          value,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Select Dates",
                  style: Theme.of(context)
                      .accentTextTheme
                      .display3
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: GestureDetector(
                    child: Text(
                      initialSelectedDate
                          .toLocal()
                          .toIso8601String()
                          .substring(0, 10),
                      style: Theme.of(context)
                          .accentTextTheme
                          .display3
                          .copyWith(color: Colors.black45),
                    ),
                    onTap: () => _selectInitialDate(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 50, 5),
                  child: GestureDetector(
                    child: Text(
                      finalSelectedDate
                          .toLocal()
                          .toIso8601String()
                          .substring(0, 10),
                      style: Theme.of(context)
                          .accentTextTheme
                          .display3
                          .copyWith(color: Colors.black45),
                    ),
                    onTap: () => _selectFinalDate(context),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Add People",
                  style: Theme.of(context)
                      .accentTextTheme
                      .display3
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 30, right: 30, bottom: 10),
                    child: Container(
                      height: 40,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: Theme.of(context).accentTextTheme.display4,
                          decoration: InputDecoration(
                            labelText: "Person 1",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.black),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 30, right: 30, bottom: 10),
                    child: Container(
                      height: 40,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: Theme.of(context).accentTextTheme.display4,
                          decoration: InputDecoration(
                            labelText: "Person 2",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.black),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        elevation: 5.0,
                        color: Color.fromRGBO(45, 156, 219, 1),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new Text('+ Add More',
                              style: new TextStyle(
                                  fontSize: 18.0, color: Colors.white)),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Preferred Commute",
                        style: Theme.of(context)
                            .accentTextTheme
                            .display3
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/car.png",
                                  width: 50,
                                ),
                                Text(
                                  "Car",
                                  style: Theme.of(context)
                                      .accentTextTheme
                                      .display3,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/train.png",
                                  width: 50,
                                ),
                                Text(
                                  "Train",
                                  style: Theme.of(context)
                                      .accentTextTheme
                                      .display3,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(80.0, 5.0, 80.0, 50.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        elevation: 5.0,
                        color: Color.fromRGBO(45, 156, 219, 1),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5)),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                          child: new Text('Confirm Tickets',
                              style: new TextStyle(
                                  fontSize: 18.0, color: Colors.white)),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
