import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:credify/globals.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

http.Client client = new http.Client();

Future<bool> addScreenshotService(String id, int index, Asset asset) async {
  String endPoint = "/user/$id/document/screenshot/$index";
  Uri uri = Uri.parse(url + endPoint);

  ByteData byteData = await asset.getByteData();
  List<int> imageData = byteData.buffer.asUint8List();

  Directory tempDir = await getApplicationDocumentsDirectory();
  String tempPath = tempDir.path;
  File(tempPath + index.toString()).writeAsBytesSync(imageData);

  var encoder = ZipFileEncoder();
  encoder.create(tempPath + "/$index.zip");
  encoder.addFile(File(tempPath + index.toString()));
  encoder.close();

  Future<FormData> formData() async {
    return FormData.fromMap({
      "file": MultipartFile.fromFileSync(encoder.zip_path,
          filename: "screenshot$index.jpg"),
    });
  }

  try {
    var dio = Dio();
    dio.options.baseUrl = url;
    dio.interceptors.add(LogInterceptor());
    var response = await dio.post(
      uri.toString(),
      data: await formData(),
      onSendProgress: (received, total) {
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + "%");
        }
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
