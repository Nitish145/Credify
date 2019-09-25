import 'package:credify/contacts_model.dart';
import 'package:credify/group_UI.dart';
import 'package:flutter/material.dart';

class UserGroupsScreen extends StatefulWidget {
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
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Group(
                groupName: "Random",
                groupMembersNames: [
                  ContactsModel(
                    contactName: "Afhjdsvdzjv",
                    contactNumber: "jjbajc",
                  ),
                  ContactsModel(
                    contactName: "Afhjdsvdzjv",
                    contactNumber: "jjbajc",
                  )
                ],
              )
            ],
          ),
        ));
  }
}
