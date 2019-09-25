import 'package:credify/globals.dart';
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
    return GestureDetector(
      onTap: () {
        setState(() {
          if (!isChecked) {
            isChecked = true;
          }
        });
        if (isChecked) {
          if (!isAlreadyPresent) {
            selectedContacts.add(ContactsModel(
              contactName: widget.contactName,
              contactNumber: widget.contactNumber,
            ));
            isAlreadyPresent = true;
          }
        }
        if (!isChecked && isAlreadyPresent) {
          print("hello");
          selectedContacts.remove(ContactsModel(
            contactName: widget.contactName,
            contactNumber: widget.contactNumber,
          ));
        }
      },
      child: Container(
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
        ),
      ),
    );
  }
}
