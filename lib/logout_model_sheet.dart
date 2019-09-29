import 'package:credify/globals.dart';
import 'package:flutter/material.dart';

Future<void> showLogoutModalBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Are you sure you want to",
                    style: Theme.of(context).accentTextTheme.display3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Log-Out?",
                    style: Theme.of(context)
                        .accentTextTheme
                        .display2
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "To log back in you will need to re-verify your mobile number",
                    style: Theme.of(context).accentTextTheme.display4,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20.0),
                Center(
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
                        child: new Text('Log Out',
                            style: new TextStyle(
                                fontSize: 18.0, color: Colors.white)),
                      ),
                      onPressed: () {
                        currentUserId = "";
                        currentUserName = "";
                        currentUserCardNumber = "";
                        currentUserData = null;
                        currentUserMobileNumber = "";
                        Navigator.pushNamedAndRemoveUntil(context,
                            "/mobileNumber", (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          Color.fromRGBO(98, 105, 123, 1.0).withOpacity(0.05),
                    ),
                    child: Center(
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
