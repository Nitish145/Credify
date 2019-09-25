import 'package:credify/contacts_model.dart';
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
        padding: const EdgeInsets.fromLTRB(80, 10, 30, 10),
        child: Container(
          child: Text(
            contactGroup.contactName,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Text(
                widget.groupName,
                style: Theme.of(context)
                    .accentTextTheme
                    .display2
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: groupMemberNamesWidget,
            ),
            Divider(
              color: Colors.blueGrey,
            )
          ],
        ),
      ),
    );
  }
}
