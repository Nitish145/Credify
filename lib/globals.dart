import 'package:credify/Components/contacts_model.dart';
import 'package:flutter/material.dart';

bool isLoading = false;

List<ContactsModel> selectedContacts = [];
List<String> listOfTravellers = [];

String aadharLoadingProgress = "";
String panLoadingProgress = "";

bool isJobProfileUpdated = true;
bool isPersonalLoanAvailed;

Map<String, double> relationMap = {};

Map<String, Color> colorMap = {
  "0": Colors.teal,
  "1": Colors.red,
  "2": Colors.amber,
  "3": Colors.green,
  "4": Colors.deepOrange,
  "5": Colors.blue,
  "6": Colors.cyan,
  "7": Colors.deepPurple,
  "8": Colors.pink
};
