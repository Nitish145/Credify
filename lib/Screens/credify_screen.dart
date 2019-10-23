import 'dart:convert';

import 'package:credify/Components/credify_card.dart';
import 'package:credify/Models/user_data_model.dart';
import 'package:credify/Services/user_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CredifyScreen extends StatefulWidget {
  @override
  _CredifyScreenState createState() => _CredifyScreenState();
}

class _CredifyScreenState extends State<CredifyScreen> {
  UserData currentUserData;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPrefs) {
      getUserData(sharedPrefs.getString("currentUserId")).then((userData) {
        sharedPrefs.setString("currentUserData", jsonEncode(currentUserData));
        setState(() {
          currentUserData = userData;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black,
                        ),
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70, bottom: 20),
                  child: CredifyCard(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
