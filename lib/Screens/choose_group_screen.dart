import 'package:credify/globals.dart';
import 'package:credify/Components/group_design.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: widget.groupList.map((group) {
                return InkWell(
                  child: group,
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: "You have selected ${group.groupName}",
                        toastLength: Toast.LENGTH_LONG);
                    group.groupMembersNames.forEach((groupMemberName) {
                      listOfTravellers.add(groupMemberName.contactName);
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        ));
  }
}
