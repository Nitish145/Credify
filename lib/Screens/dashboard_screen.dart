import 'dart:async';

import 'package:contacts_service/contacts_service.dart';
import 'package:credify/Models/get_groups.dart';
import 'package:credify/Models/user_data_model.dart';
import 'package:credify/Components/contacts_model.dart';
import 'package:credify/Screens/contacts_screen.dart';
import 'package:credify/Components/credify_card.dart';
import 'package:credify/Components/dashboard_card.dart';
import 'package:credify/Services/card_data.dart';
import 'package:credify/globals.dart';
import 'package:credify/Components/group_design.dart';
import 'package:credify/Components/logout_model_sheet.dart';
import 'package:credify/Components/progress_bar.dart';
import 'package:credify/Services/get_groups_service.dart';
import 'package:credify/Services/user_data.dart';
import 'package:credify/Screens/travel_screen.dart';
import 'package:credify/Components/undismissable_progress_bar.dart';
import 'package:credify/Screens/user_groups_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isGroupLoading = false;
  bool areContactsLoading = false;
  UserData currentUserData;
  String currentUserName = "";
  String currentUserCardNumber = "";

  Future<List<Contact>> getContacts() async {
    List<Contact> _contacts;
    PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      setState(() {
        isLoading = true;
        areContactsLoading = true;
      });
      var contacts = await ContactsService.getContacts();
      _contacts = contacts.toList();
      setState(() {
        isLoading = false;
        areContactsLoading = false;
      });
      return _contacts;
    } else {
      throw PlatformException(
        code: 'PERMISSION_DENIED',
        message: 'Access to contacts denied',
        details: null,
      );
    }
  }

  Future<PermissionStatus> _getPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.disabled) {
      Map<PermissionGroup, PermissionStatus> permissionStatus =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.contacts]);
      return permissionStatus[PermissionGroup.contacts] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPrefs) {
      getUserData(sharedPrefs.getString("currentUserId")).then((userData) {
        getCardData(sharedPrefs.getString("currentUserId")).then((cardData) {
          setState(() {
            currentUserCardNumber = cardData.cardNumber;
            currentUserName = cardData.userName.toUpperCase();
            currentUserData = userData;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton.extended(
        label: Text("Logout"),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(45, 156, 219, 1),
        onPressed: () {
          showLogoutModalBottomSheet(context);
        },
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          color: Colors.black,
                          child: SafeArea(
                            child: Container(
                              height: MediaQuery.of(context).size.height / 5,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: Icon(Icons.people),
                                    color: Colors.white,
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = true;
                                        isGroupLoading = true;
                                      });
                                      SharedPreferences sharedPrefs =
                                          await SharedPreferences.getInstance();
                                      UserData currentUserData =
                                          await getUserData(sharedPrefs
                                              .getString("currentUserId"));
                                      List<String> groupIds =
                                          currentUserData.groupId;
                                      List<Group> groupList = [];
                                      groupIds.forEach((groupId) async {
                                        GroupData groupData =
                                            await getGroupData(groupId);
                                        String groupName = groupData.groupName;
                                        List<ContactsModel> contactsGroupData =
                                            [];
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
                                      Future.delayed(const Duration(seconds: 3),
                                          () {
                                        setState(() {
                                          isLoading = false;
                                          isGroupLoading = false;
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserGroupsScreen(
                                                      groupList: groupList,
                                                    )));
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 100, bottom: 20),
                          child: CredifyCard(
                            cardLevel: "Silver",
                            cardNumber: currentUserCardNumber,
                            name: currentUserName,
                            kycStage: currentUserData == null
                                ? 0
                                : currentUserData.kycProgress,
                            isUserDataNull:
                                (currentUserData == null) ? true : false,
                          ),
                        )
                      ],
                    ),
                  ),
                  currentUserData == null
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(36, 8, 36, 8),
                          child: Container(
                            height: 90,
                          ),
                        )
                      : (currentUserData.kycProgress == 3)
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(36, 8, 36, 8),
                              child: Container(
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("Used",
                                            style: Theme.of(context)
                                                .accentTextTheme
                                                .display4),
                                        Text("Credify limit",
                                            style: Theme.of(context)
                                                .accentTextTheme
                                                .display4)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("4,000/",
                                            style: Theme.of(context)
                                                .accentTextTheme
                                                .display2
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        Text("10,000/",
                                            style: Theme.of(context)
                                                .accentTextTheme
                                                .display2
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold))
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 10.0,
                                        child: ProgressBar(
                                          linearGradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Color.fromRGBO(229, 93, 135, 1),
                                                Color.fromRGBO(95, 195, 228, 1)
                                              ]),
                                          progress: 40.0,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          height: 15.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(36, 8, 36, 8),
                              child: Container(
                                height: 90,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text("Credify limit",
                                            style: Theme.of(context)
                                                .accentTextTheme
                                                .display4)
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 10.0,
                                        child: ProgressBar(
                                          linearGradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Color.fromRGBO(
                                                    221, 221, 221, 1),
                                                Color.fromRGBO(221, 221, 221, 1)
                                              ]),
                                          progress: 100.0,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          height: 15.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                  GestureDetector(
                    onTap: () async {
                      List<Contact> listOfContacts = await getContacts();
                      List<ContactsModel> allContacts = [];
                      listOfContacts.forEach((contact) {
                        allContacts.add(ContactsModel(
                          contactNumber: contact.phones.toList().isEmpty
                              ? ""
                              : contact.phones.toList()[0].value,
                          contactName: contact?.displayName,
                        ));
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactsScreen(
                                    allContacts: allContacts,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(36, 8, 36, 16),
                      child: Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromRGBO(47, 128, 237, .8)),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/addContactsBackground.png",
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        22, 15, 22, 10),
                                    child: Text(
                                      "Create and travel as a group",
                                      style: Theme.of(context)
                                          .accentTextTheme
                                          .display3
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25, 0, 22, 5),
                                      child: Text(
                                          "- Lower Interest rates and Prices",
                                          style: Theme.of(context)
                                              .accentTextTheme
                                              .display4),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25, 0, 22, 5),
                                      child: Text("- Better experience",
                                          style: Theme.of(context)
                                              .accentTextTheme
                                              .display4),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TravelScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: DashboardCard(
                        isAtBottom: false,
                        heading: "Travel with us",
                        subheading:
                            "Check amazing packages customised for you. Travel now. Pay later",
                        isDark: true,
                        imageLocation: "assets/images/travel.png",
                      ),
                    ),
                  ),
                ],
              ),
              areContactsLoading
                  ? UndismissableProgressBar(
                      message: "Loading Contacts",
                    )
                  : UndismissableProgressBar(
                      message: "Loading Groups",
                    )
            ],
          ),
        ),
      ),
    );
  }
}
