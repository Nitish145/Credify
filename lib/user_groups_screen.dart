import 'package:credify/group_UI.dart';
import 'package:flutter/material.dart';

class UserGroupsScreen extends StatefulWidget {
  final List<Group> groupList;

  const UserGroupsScreen({Key key, this.groupList}) : super(key: key);
  @override
  _UserGroupsScreenState createState() => _UserGroupsScreenState();
}

class _UserGroupsScreenState extends State<UserGroupsScreen> {
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
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: ListView(
          children: widget.groupList,
        ));
  }
}
