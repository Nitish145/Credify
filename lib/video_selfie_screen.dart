import 'package:flutter/material.dart';

class VideoSelfieScreen extends StatefulWidget {
  @override
  _VideoSelfieScreenState createState() => _VideoSelfieScreenState();
}

class _VideoSelfieScreenState extends State<VideoSelfieScreen> {
  var formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 4, 5, 1),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 30),
                child: Text(
                  "Credify",
                  style: Theme.of(context).primaryTextTheme.display2,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 30),
                child: Text(
                  " Upload",
                  style: Theme.of(context).primaryTextTheme.display1,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 0, left: 30),
                child: Text(
                  "  1/2",
                  style: Theme.of(context).primaryTextTheme.display3,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 30),
                child: Text(
                  "  Video Selfie",
                  style: Theme.of(context).primaryTextTheme.display4,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Text(
                      ' Upload Video Selfie saying "I am Tanmay Joshi and i will repay my debt"',
                      style: Theme.of(context).primaryTextTheme.display3,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        child: GestureDetector(
                            onTap: () {},
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset(
                                      "assets/images/camera.png",
                                      height: 50,
                                      width: 50,
                                    ))))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 30.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      elevation: 5.0,
                      color: Color.fromRGBO(45, 156, 219, 1),
                      shape: new RoundedRectangleBorder(
                          side: BorderSide(
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                          borderRadius: new BorderRadius.circular(5)),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
                        child: new Text('Continue',
                            style: new TextStyle(
                                fontSize: 18.0, color: Colors.white)),
                      ),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
