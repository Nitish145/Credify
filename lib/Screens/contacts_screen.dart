import 'package:credify/Models/add_group_response.dart';
import 'package:credify/Components/contacts_model.dart';
import 'package:credify/Services/add_group.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart';

class ContactsScreen extends StatefulWidget {
  final List<ContactsModel> allContacts;

  const ContactsScreen({Key key, this.allContacts}) : super(key: key);
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  bool _isGroupNameAdded = false;
  bool _isDialogShown = false;
  String groupName = "";
  List<bool> isCheckedList = [];

  var formKey = new GlobalKey<FormState>();

  Widget contactsModel(
      String contactName, String contactNumber, bool isChecked) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 8, 0),
              child: Text(
                contactName,
                style: Theme.of(context).accentTextTheme.display4,
              ),
            ),
            isChecked
                ? Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Image.asset(
                      "assets/images/selected.png",
                      height: 18,
                      width: 18,
                    ),
                  )
                : Container()
          ],
        ));
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: AlertDialog(
              title: Text(
                'Choose a Group Name',
                style: TextStyle(fontWeight: FontWeight.bold)
                    .copyWith(color: Color.fromRGBO(45, 156, 219, 1)),
              ),
              content: Theme(
                data: ThemeData(
                  primaryColor: Color.fromRGBO(45, 156, 219, 0.5),
                ),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    style: Theme.of(context).accentTextTheme.display3,
                    onSaved: (_groupName) {
                      groupName = _groupName;
                    },
                    validator: (_groupName) {
                      if (_groupName.isEmpty) {
                        return "Please enter a name";
                      }
                      return null;
                    },
                    cursorColor: Color.fromRGBO(45, 156, 219, 0.5),
                    cursorWidth: 1,
                    decoration: InputDecoration(
                        labelText: "Group Name",
                        labelStyle: Theme.of(context).accentTextTheme.display3,
                        border: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Color.fromRGBO(45, 156, 219, 0.5),
                                width: 0.5))),
                  ),
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text(
                    'Continue',
                    style: Theme.of(context).accentTextTheme.display3.copyWith(
                          color: Color.fromRGBO(45, 156, 219, 1),
                        ),
                  ),
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      _isGroupNameAdded = true;
                      _isDialogShown = true;
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    isCheckedList = widget.allContacts.map((contactModel) {
      return false;
    }).toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    Widget _createGroupButton() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: RaisedButton(
              elevation: 10.0,
              color: Color.fromRGBO(45, 156, 219, 1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Text('Create Group',
                    style: new TextStyle(fontSize: 22.0, color: Colors.white)),
              ),
              onPressed: () async {
                SharedPreferences sharedPrefs =
                    await SharedPreferences.getInstance();
                if (selectedContacts.length >= 2) {
                  if (!_isDialogShown) {
                    _displayDialog(context);
                  }
                  if (_isGroupNameAdded) {
                    AddGroup addGroupResponse = await addGroupService(
                        selectedContacts,
                        sharedPrefs.getString("currentUserId"),
                        groupName);
                    if (addGroupResponse.updated) {
                      Navigator.pop(context);
                      selectedContacts = [];
                    }
                  }
                } else {
                  Fluttertoast.showToast(
                      msg: "Please select at least two Contacts",
                      toastLength: Toast.LENGTH_LONG);
                }
              },
            ),
          ),
        ),
      );
    }

    double getSelectedContainerHeight() {
      switch (selectedContacts.length) {
        case 0:
          return 0;
          break;

        case 1:
          return 110;
          break;

        case 2:
          return 155;
          break;

        case 3:
          return 200;
          break;

        case 4:
          return 245;
          break;

        default:
          return 245;
      }
    }

    Widget getSelectedContacts() {
      selectedContacts = widget.allContacts.where((contact) {
        if (isCheckedList[widget.allContacts.indexOf(contact)]) {
          return true;
        }
        return false;
      }).toList();

      if (selectedContacts.isNotEmpty) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: getSelectedContainerHeight(),
          color: Color.fromRGBO(220, 220, 220, 1),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 55,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Selected",
                        style: Theme.of(context)
                            .primaryTextTheme
                            .display3
                            .copyWith(
                                color: Color.fromRGBO(47, 128, 237, 1),
                                fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                Column(
                    children: selectedContacts.map((contactModel) {
                  return contactsModel(contactModel.contactName,
                      contactModel.contactNumber, true);
                }).toList())
              ],
            ),
          ),
        );
      }
      return Container();
    }

    Widget getAllContacts() {
      return Container(
        width: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(242, 242, 242, 1),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 55,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Contacts",
                      style: Theme.of(context)
                          .primaryTextTheme
                          .display3
                          .copyWith(
                              color: Color.fromRGBO(47, 128, 237, 1),
                              fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Column(
                  children: widget.allContacts.map((contactModel) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (!isCheckedList[
                          widget.allContacts.indexOf(contactModel)]) {
                        isCheckedList[
                            widget.allContacts.indexOf(contactModel)] = true;
                      } else {
                        isCheckedList[
                            widget.allContacts.indexOf(contactModel)] = false;
                      }
                    });
                  },
                  child: contactsModel(
                      contactModel.contactName,
                      contactModel.contactNumber,
                      isCheckedList[widget.allContacts.indexOf(contactModel)]),
                );
              }).toList())
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Stack(
              children: <Widget>[
                getSelectedContacts(),
                Padding(
                  padding: EdgeInsets.only(top: getSelectedContainerHeight()),
                  child: getAllContacts(),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            selectedContacts = [];
                          },
                        ),
                      ),
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Create Group",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .display2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _createGroupButton()
        ],
      ),
    );
  }
}
