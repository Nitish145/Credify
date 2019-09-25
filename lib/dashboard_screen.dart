import 'package:contacts_service/contacts_service.dart';
import 'package:credify/contacts_model.dart';
import 'package:credify/contacts_screen.dart';
import 'package:credify/credify_card.dart';
import 'package:credify/dashboard_card.dart';
import 'package:credify/globals.dart';
import 'package:credify/progress_bar.dart';
import 'package:credify/travel_screen.dart';
import 'package:credify/undismissable_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<List<Contact>> getContacts() async {
    List<Contact> _contacts;
    PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      setState(() {
        isLoading = true;
      });
      var contacts = await ContactsService.getContacts();
      _contacts = contacts.toList();
      setState(() {
        isLoading = false;
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
  Widget build(BuildContext context) {
    return Scaffold(
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
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 100, bottom: 40),
                          child: CredifyCard(
                            cardLevel: "Silver",
                            cardNumber: "1234 5678 9123 4567",
                            name: "Tanmay Joshi",
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(36, 8, 36, 8),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("4,000/",
                                  style: Theme.of(context)
                                      .accentTextTheme
                                      .display2
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text("10,000/",
                                  style: Theme.of(context)
                                      .accentTextTheme
                                      .display2
                                      .copyWith(fontWeight: FontWeight.bold))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
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
                                borderRadius: BorderRadius.circular(10.0),
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
                                          "- Lower Interest rates nd Prices",
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(36, 8, 36, 16),
                    child: Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromRGBO(47, 128, 237, .8)),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                              child: Text(
                                  "Add friends and increase your score"
                                      .toUpperCase(),
                                  softWrap: true,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .display3
                                      .copyWith(
                                          fontSize: 19, letterSpacing: 3)),
                            ),
                            width: MediaQuery.of(context).size.width / 2,
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 30,
                                    child: Image.asset(
                                      "assets/images/addFriend.png",
                                      height: 40,
                                      width: 40,
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 30),
                    child: DashboardCard(
                      isAtBottom: true,
                      heading: "Your Ride. Your Bike",
                      subheading:
                          "Get your bike of dreams. Easy installments. Ride away.",
                      isDark: false,
                      imageLocation: "assets/images/bikeRide.png",
                    ),
                  )
                ],
              ),
              UndismissableProgressBar()
            ],
          ),
        ),
      ),
    );
  }
}
