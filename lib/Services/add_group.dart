import 'dart:convert';

import 'package:credify/Models/add_group_response.dart';
import 'package:credify/Components/contacts_model.dart';
import 'package:credify/globals.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<AddGroup> addGroupService(List<ContactsModel> selectedContacts,
    String userId, String groupName) async {
  String endPoint = "/group/$userId";
  String uri = url + endPoint;

  var listInJson = [];
  selectedContacts.forEach((selectedContact) {
    listInJson.add({
      "name": selectedContact.contactName,
      "mobile_number": selectedContact.contactNumber
    });
  });

  print(listInJson);

  var json = {"friends": listInJson, "group_name": groupName};

  try {
    http.Response response =
        await client.post(uri, body: jsonEncode(json), headers: header);
    final jsonResponse = jsonDecode(response.body);
    AddGroup addGroupResponse = new AddGroup.fromJson(jsonResponse);
    print(jsonResponse);
    return addGroupResponse;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
