import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'group_UI.dart';

class ChooseGroupScreen extends StatefulWidget {
  final List<Group> groupList;

  const ChooseGroupScreen({Key key, this.groupList}) : super(key: key);
  @override
  _ChooseGroupScreenState createState() => _ChooseGroupScreenState();
}

class _ChooseGroupScreenState extends State<ChooseGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Your Groups",
            style: Theme.of(context).primaryTextTheme.display3,
          ),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () {
                  Toast.show("Your Group has been selected!", context,
                      duration: Toast.LENGTH_LONG);
                },
                child: Column(
                  children: widget.groupList,
                ),
              ),
            ),
          ),
        ));
  }
}
