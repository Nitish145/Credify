import 'package:credify/Models/add_group_response.dart';
import 'package:credify/contacts_model.dart';
import 'package:credify/services/add_group.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart';

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
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                      height: 20,
                      width: 20,
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

    Widget customAppBar() {
      return AppBar(
        title: Text(
          "Create Group",
          style: Theme.of(context).primaryTextTheme.display3,
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
            selectedContacts = [];
          },
        ),
        iconTheme: IconThemeData(color: Colors.white),
      );
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
          color: Color.fromRGBO(220, 220, 220, 1),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Selected",
                    style: Theme.of(context)
                        .primaryTextTheme
                        .display3
                        .copyWith(color: Color.fromRGBO(47, 128, 237, 1)),
                  ),
                ),
              ),
              Column(
                  children: selectedContacts.map((contactModel) {
                return contactsModel(
                    contactModel.contactName, contactModel.contactNumber, true);
              }).toList())
            ],
          ),
        );
      }
      return Container();
    }

    Widget getAllContacts() {
      return Container(
        width: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(242, 242, 242, 1),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Contacts",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .display3
                      .copyWith(color: Color.fromRGBO(47, 128, 237, 1)),
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
                      isCheckedList[widget.allContacts.indexOf(contactModel)] =
                          true;
                    } else {
                      isCheckedList[widget.allContacts.indexOf(contactModel)] =
                          false;
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
      );
    }

    return Scaffold(
      appBar: customAppBar(),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                getSelectedContacts(),
                getAllContacts(),
              ],
            ),
          ),
          _createGroupButton()
        ],
      ),
    );
  }
}
