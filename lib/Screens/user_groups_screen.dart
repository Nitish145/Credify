import 'dart:convert';

import 'package:credify/Components/contacts_model.dart';
import 'package:credify/Components/group_design.dart';
import 'package:credify/Components/undismissable_progress_bar.dart';
import 'package:credify/Models/get_groups.dart';
import 'package:credify/Screens/create_group_screen.dart';
import 'package:credify/Services/get_groups_service.dart';
import 'package:credify/Services/user_data.dart';
import 'package:credify/globals.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserGroupsScreen extends StatefulWidget {
  @override
  _UserGroupsScreenState createState() => _UserGroupsScreenState();
}

class _UserGroupsScreenState extends State<UserGroupsScreen> {
  List<Group> stateGroupList = [];

  @override
  void initState() {
    List<Group> groupList = [];
    super.initState();
    setState(() {
      isLoading = true;
    });
    SharedPreferences.getInstance().then((sharedPrefs) async {
      getUserData(sharedPrefs.getString("currentUserId"))
          .then((currentUserData) async {
        sharedPrefs.setString("currentUserData", jsonEncode(currentUserData));
        List<String> groupIds = currentUserData.groupId;
        groupIds.forEach((groupId) async {
          GroupData groupData = await getGroupData(groupId);
          String groupName = groupData.groupName;
          List<ContactsModel> contactsGroupData = [];
          groupData.friends.forEach((friend) {
            contactsGroupData.add(ContactsModel(
              contactName: friend.name,
              contactNumber: friend.mobileNumber,
            ));
          });
          groupList.add(Group(
            groupName: groupName,
            groupMembersNames: contactsGroupData,
          ));
        });
        await Future.delayed(Duration(seconds: 3));
        setState(() {
          stateGroupList = groupList;
          isLoading = false;
        });
      }).catchError((e) {
        Fluttertoast.showToast(msg: "Something Wrong Occured!");
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(47, 128, 237, 1),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateGroupScreen()));
        },
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 90.0),
            child: ListView(
              children: stateGroupList,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            "Groups",
                            style: Theme.of(context).primaryTextTheme.display2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          UndismissableProgressBar(
            message: "Loading Groups",
          ),
        ],
      ),
    );
  }
}
