import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:credify/globals.dart';
import 'package:credify/Services/add_documents.dart';
import 'package:credify/Components/undismissable_progress_bar.dart';
import 'package:credify/Screens/video_selfie_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadPan extends StatefulWidget {
  @override
  _UploadPanState createState() => _UploadPanState();
}

class _UploadPanState extends State<UploadPan> {
  var formKey = new GlobalKey<FormState>();

  File _frontPanImage;
  File _backPanImage;

  Future getFrontImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 1500, maxWidth: 1500);

    setState(() {
      _frontPanImage = image;
    });
  }

  Future getBackImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 1500, maxWidth: 1500);

    setState(() {
      _backPanImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 4, 5, 1),
      body: Stack(
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
                      "  2/2",
                      style: Theme.of(context).primaryTextTheme.display3,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 30),
                    child: Text(
                      "  PAN Card",
                      style: Theme.of(context).primaryTextTheme.display4,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, bottom: 20),
                        child: Text(
                          " Upload PAN card Front photo",
                          style: Theme.of(context).primaryTextTheme.display3,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          child: GestureDetector(
                              onTap: () {
                                getFrontImage();
                              },
                              child: _frontPanImage == null
                                  ? Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset(
                                            "assets/images/camera.png",
                                            height: 50,
                                            width: 50,
                                          )))
                                  : Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Container(
                                        height: 120,
                                        width: 200,
                                        child: Image.file(
                                          _frontPanImage,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    )),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, bottom: 20),
                        child: Text(
                          " Upload PAN card Back photo",
                          style: Theme.of(context).primaryTextTheme.display3,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          child: GestureDetector(
                              onTap: () {
                                getBackImage();
                              },
                              child: _backPanImage == null
                                  ? Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset(
                                            "assets/images/camera.png",
                                            height: 50,
                                            width: 50,
                                          )))
                                  : Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Container(
                                        height: 120,
                                        width: 200,
                                        child: Image.file(
                                          _backPanImage,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    )),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 30.0),
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
                            padding: const EdgeInsets.fromLTRB(
                                60.0, 20.0, 60.0, 20.0),
                            child: new Text('Continue',
                                style: new TextStyle(
                                    fontSize: 18.0, color: Colors.white)),
                          ),
                          onPressed: () async {
                            SharedPreferences sharedPrefs =
                                await SharedPreferences.getInstance();
                            if (_frontPanImage != null &&
                                _backPanImage != null) {
                              setState(() {
                                isLoading = true;
                              });
                              Directory tempDir =
                                  await getApplicationDocumentsDirectory();
                              String tempPath = tempDir.path;
                              var encoder = ZipFileEncoder();
                              encoder.create(tempPath + "/pan.zip");
                              encoder.addFile(_frontPanImage);
                              encoder.addFile(_backPanImage);
                              encoder.close();
                              bool isUploaded = await addDocumentsService(
                                  sharedPrefs.getString("currentUserId"),
                                  "pan",
                                  1,
                                  encoder);
                              print(isUploaded);
                              if (isUploaded) {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VideoSelfieScreen()));
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Something Wrong Occured",
                                  toastLength: Toast.LENGTH_SHORT,
                                );
                              }
                            } else {
                              Fluttertoast.showToast(
                                msg: "You have not choosen one or more images",
                                toastLength: Toast.LENGTH_LONG,
                              );
                            }
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          UndismissableProgressBar(
            message: "Uploading PAN",
          )
        ],
      ),
    );
  }
}
