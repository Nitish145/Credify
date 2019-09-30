import 'package:flutter/material.dart';

class ContactsModel extends StatefulWidget {
  final String contactName;
  final String contactNumber;

  const ContactsModel({Key key, this.contactName, this.contactNumber})
      : super(key: key);
  @override
  _ContactsModelState createState() => _ContactsModelState();
}

class _ContactsModelState extends State<ContactsModel> {
  bool isChecked = false;
  bool isAlreadyPresent = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.contactName,
              style: Theme.of(context).accentTextTheme.display4,
            ),
          ),
        ],
      ),
    );
  }
}
