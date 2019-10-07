import 'package:credify/Components/contacts_model.dart';
import 'package:credify/Components/group_design.dart';
import 'package:credify/Components/undismissable_progress_bar.dart';
import 'package:credify/Models/get_groups.dart';
import 'package:credify/Services/get_groups_service.dart';
import 'package:credify/Services/user_data.dart';
import 'package:credify/globals.dart';
import 'package:flutter/material.dart';
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
          .then((currentUserData) {
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
            groupName: groupName.toUpperCase(),
            groupMembersNames: contactsGroupData,
          ));
        });
      });
      await Future.delayed(Duration(seconds: 3));
      setState(() {
        stateGroupList = groupList;
        isLoading = false;
      });
    });
  }

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
        body: Stack(
          children: <Widget>[
            ListView(
              children: stateGroupList,
            ),
            UndismissableProgressBar(
              message: "Loading Groups",
            )
          ],
        ));
  }
}
