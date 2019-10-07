import 'package:credify/Components/contacts_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Group extends StatefulWidget {
  final String groupName;
  final List<ContactsModel> groupMembersNames;

  const Group({Key key, this.groupName, this.groupMembersNames})
      : super(key: key);
  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
  List<Widget> groupMemberNamesWidget = [];

  @override
  void initState() {
    super.initState();
    generateGroupMembersWidget();
  }

  generateGroupMembersWidget() {
    widget.groupMembersNames.forEach((contactGroup) {
      groupMemberNamesWidget.add(Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              contactGroup.contactName,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 0, 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.groupName,
                    style: Theme.of(context)
                        .accentTextTheme
                        .display3
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromRGBO(235, 235, 235, 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: groupMemberNamesWidget,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
