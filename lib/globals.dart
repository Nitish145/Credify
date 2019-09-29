import 'package:credify/Models/user_data_model.dart';
import 'package:credify/contacts_model.dart';

String currentUserId = "";
String currentUserMobileNumber = "";
bool isLoading = false;

List<ContactsModel> selectedContacts = [];
List<String> listOfTravellers = [];
UserData currentUserData;

String currentUserName = "";
String currentUserCardNumber = "";

String aadharLoadingProgress = "";
String panLoadingProgress = "";
