import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StatementUploadScreen extends StatefulWidget {
  @override
  _StatementUploadScreenState createState() => _StatementUploadScreenState();
}

class _StatementUploadScreenState extends State<StatementUploadScreen> {
  var formKey = new GlobalKey<FormState>();

  File _statementImage;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _statementImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 4, 5, 1),
      body: Column(
        children: <Widget>[
          SingleChildScrollView(
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
                      " Bank Statement",
                      style: Theme.of(context).primaryTextTheme.display1,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 40, bottom: 20),
                    child: Text(
                      " Upload Statement",
                      style: Theme.of(context).primaryTextTheme.display3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: _statementImage == null
                  ? Center(
                      child: GestureDetector(
                        onTap: getImage,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.asset(
                              "assets/images/camera.png",
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(30),
                      child: Container(
                        child: Image.file(
                          _statementImage,
                        ),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 80.0),
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
                  padding: const EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
                  child: new Text('Continue',
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.white)),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context,
                      "/navigationScreen", (Route<dynamic> route) => false);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
