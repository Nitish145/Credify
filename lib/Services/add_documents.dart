import 'package:archive/archive_io.dart';
import 'package:credify/globals.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

String url =
    "http://ec2-3-133-147-228.us-east-2.compute.amazonaws.com:5000/api/v1";
http.Client client = new http.Client();

Future<bool> addDocumentsService(
    String id, String documentName, int stage, ZipFileEncoder zipFile) async {
  String endPoint = "/user/$id/document/$documentName/$stage";
  Uri uri = Uri.parse(url + endPoint);

  Future<FormData> formData1() async {
    return FormData.fromMap({
      "name": "file",
      "age": 25,
      "file":
          MultipartFile.fromFileSync(zipFile.zip_path, filename: "document"),
    });
  }

  try {
    var dio = Dio();
    dio.options.baseUrl = url;
    dio.interceptors.add(LogInterceptor());
    var response = await dio.post(
      uri.toString(),
      data: await formData1(),
      onSendProgress: (received, total) {
        if (documentName == "aadhaar") {
          aadharLoadingProgress =
              (received / total * 100).toStringAsFixed(0) + "%";
        } else if (documentName == "pan") {
          panLoadingProgress =
              (received / total * 100).toStringAsFixed(0) + "%";
        }
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
