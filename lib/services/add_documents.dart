import 'dart:io';

import 'package:http/http.dart' as http;

String url =
    "http://ec2-18-216-85-124.us-east-2.compute.amazonaws.com:5000/api/v1";
http.Client client = new http.Client();

Future<bool> addDocumentsService(
    String id, String documentName, int stage, File zipFile) async {
  String endPoint = "/user/$id/document/$documentName/$stage";
  Uri uri = Uri.parse(url + endPoint);
  var request = new http.MultipartRequest("POST", uri);
  request.files.add(
      new http.MultipartFile('file', zipFile.openRead(), zipFile.lengthSync()));

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
