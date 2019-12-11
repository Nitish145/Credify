import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Raleway',
          primaryColor: Colors.white,
          cursorColor: Colors.white,
          accentColor: Colors.grey,
          primaryTextTheme: TextTheme(
            display1: TextStyle(color: Colors.white, fontSize: 32),
            display2: TextStyle(color: Colors.white, fontSize: 26),
            display3: TextStyle(color: Colors.white, fontSize: 20),
            display4: TextStyle(color: Colors.white, fontSize: 16),
            body1: TextStyle(color: Colors.white),
            body2: TextStyle(color: Colors.white),
          ),
          accentTextTheme: TextTheme(
            display1: TextStyle(color: Colors.black, fontSize: 32),
            display2: TextStyle(color: Colors.black, fontSize: 26),
            display3: TextStyle(color: Colors.black, fontSize: 20),
            display4: TextStyle(color: Colors.black, fontSize: 16),
            body1: TextStyle(color: Colors.white),
            body2: TextStyle(color: Colors.white),
          ),
          hintColor: Colors.white),
      home: ProfileScreenshotScreen(),
    );
  }
}

class ProfileScreenshotScreen extends StatefulWidget {
  @override
  _ProfileScreenshotScreenState createState() =>
      _ProfileScreenshotScreenState();
}

class _ProfileScreenshotScreenState extends State<ProfileScreenshotScreen> {
  List<Asset> images = List<Asset>();

  Widget buildGridView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AssetThumb(
              asset: asset,
              width: 500,
              height: 500,
            ),
          );
        }),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: false,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarColor: "#2d9cdb",
          actionBarTitle: "Profile Screenshots",
          allViewTitle: "All Photos",
          useDetailsView: true,
          selectCircleStrokeColor: "#ffffff",
        ),
      );

      for (var r in resultList) {
        var t = await r.filePath;
        print(t);
      }
    } on Exception catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 4, 5, 1),
      body: Stack(
        children: <Widget>[
          Column(
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
                          "Upload",
                          style: Theme.of(context).primaryTextTheme.display1,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, left: 30),
                        child: Text(
                          "\nProfile Screenshot",
                          style: Theme.of(context).primaryTextTheme.display3,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: Text(
                          "We want you to upload your profile which shows your star ratings, deliveries done and transactions occured. Provide as much information as possible",
                          style: Theme.of(context).primaryTextTheme.display4,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: Text(
                          "Go to your work’s App Screen > Profile > Take a ScreenShot",
                          style: Theme.of(context).primaryTextTheme.display4,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          "\nUpload Screenshot of your Profile",
                          style: Theme.of(context).primaryTextTheme.display3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: images.length == 0
                      ? Center(
                          child: GestureDetector(
                            onTap: loadAssets,
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
                      : buildGridView(),
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
                      borderRadius: new BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
                      child: new Text(
                        'Continue',
                        style:
                            new TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                    onPressed: () async {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
