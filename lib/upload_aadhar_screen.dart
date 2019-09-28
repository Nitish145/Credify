import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:credify/globals.dart';
import 'package:credify/services/add_documents.dart';
import 'package:credify/upload_pan_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';

class UploadAadhar extends StatefulWidget {
  @override
  _UploadAadharState createState() => _UploadAadharState();
}

class _UploadAadharState extends State<UploadAadhar> {
  var formKey = new GlobalKey<FormState>();

  File _frontAadharImage;
  File _backAadharImage;

  Future getFrontImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _frontAadharImage = image;
    });
  }

  Future getBackImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _backAadharImage = image;
    });
  }

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
                  "  AADHAR Card",
                  style: Theme.of(context).primaryTextTheme.display4,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, bottom: 20),
                    child: Text(
                      " Upload AADHAR card Front photo",
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
                          child: _frontAadharImage == null
                              ? Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white)),
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
                                      _frontAadharImage,
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, bottom: 20),
                    child: Text(
                      " Upload AADHAR card Back photo",
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
                          child: _backAadharImage == null
                              ? Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white)),
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
                                      _backAadharImage,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                )),
                    ),
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
                      onPressed: () async {
                        if (_frontAadharImage != null &&
                            _backAadharImage != null) {
                          setState(() {
                            isLoading = true;
                          });
                          Directory tempDir =
                              await getApplicationDocumentsDirectory();
                          String tempPath = tempDir.path;
                          var encoder = ZipFileEncoder();
                          encoder.create(tempPath + "/aadhar.zip");
                          encoder.addFile(_frontAadharImage);
                          encoder.addFile(_backAadharImage);
                          encoder.close();
                          bool isUploaded = await addDocumentsService(
                              currentUserId, "aadhaar", 1, encoder);
                          print(isUploaded);
                          if (isUploaded) {
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UploadPan()));
                          } else {
                            Toast.show(
                              "Something Wrong Occured",
                              context,
                              duration: Toast.LENGTH_LONG,
                            );
                          }
                        } else {
                          Toast.show(
                            "You have not choosen one or more images",
                            context,
                            duration: Toast.LENGTH_LONG,
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
    );
  }
}
