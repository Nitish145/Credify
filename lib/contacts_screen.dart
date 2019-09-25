import 'package:credify/contacts_model.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {
  final List<ContactsModel> allContacts;

  const ContactsScreen({Key key, this.allContacts}) : super(key: key);
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<ContactsModel> selectedContacts = [];

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            customAppBar(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  getSelectedContacts(),
                  getAllContacts(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
