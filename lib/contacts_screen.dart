import 'package:credify/Models/add_group_response.dart';
import 'package:credify/Models/is_new_user_model.dart';
import 'package:credify/contacts_model.dart';
import 'package:credify/services/add_group.dart';
import 'package:credify/services/is_new_user.dart';
import 'package:flutter/material.dart';
import 'globals.dart';

class ContactsScreen extends StatefulWidget {
  final List<ContactsModel> allContacts;

  const ContactsScreen({Key key, this.allContacts}) : super(key: key);
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  void initState() {
    super.initState();
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
                IsNewUser isNewUserResponse =
                    await isNewUser(currentUserMobileNumber);
                print(isNewUserResponse.id);
                currentUserId = isNewUserResponse.id;
                AddGroup addGroupResponse =
                    await addGroupService(selectedContacts, currentUserId);
                if (addGroupResponse.updated) {
                  Navigator.pop(context);
                  selectedContacts = [];
                }
              },
            ),
          ),
        ),
      );
    }

    Widget customAppBar() {
      return Container(
        color: Colors.black,
        child: SafeArea(
          child: Container(
            height: 70,
            color: Colors.black,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                    selectedContacts = [];
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Create Group",
                    style: Theme.of(context).primaryTextTheme.display2,
                  ),
                )
              ],
            ),
          ),
        ),
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
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                customAppBar(),
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
