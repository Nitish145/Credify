import 'package:credify/Models/add_group_response.dart';
import 'package:credify/Models/is_new_user_model.dart';
import 'package:credify/contacts_model.dart';
import 'package:credify/services/add_group.dart';
import 'package:credify/services/is_new_user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  var formKey = new GlobalKey<FormState>();

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
  Widget build(BuildContext context) {
    print(selectedContacts);
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
                if (selectedContacts.length >= 2) {
                  if (!_isDialogShown) {
                    _displayDialog(context);
                  }
                  if (_isGroupNameAdded) {
                    IsNewUser isNewUserResponse =
                        await isNewUser(currentUserMobileNumber);
                    print(isNewUserResponse.id);
                    currentUserId = isNewUserResponse.id;
                    AddGroup addGroupResponse = await addGroupService(
                        selectedContacts, currentUserId, groupName);
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
      if (selectedContacts.isNotEmpty) {
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
                    "Selected",
                    style: Theme.of(context)
                        .primaryTextTheme
                        .display3
                        .copyWith(color: Color.fromRGBO(47, 128, 237, 1)),
                  ),
                ),
              ),
              Column(children: selectedContacts)
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
            Column(children: widget.allContacts)
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
