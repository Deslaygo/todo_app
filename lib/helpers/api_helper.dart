// ignore_for_file: lines_longer_than_80_chars

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/app_controller.dart';
import '../config_reader.dart';

final apiUrl = ConfigReader.getApiUrl();
final basePath = ConfigReader.getBasePath();
final apiKey = ConfigReader.getApiKey();
final appController = Get.find<AppController>();

final options = BaseOptions(
    baseUrl: '$apiUrl/$basePath',
    contentType: Headers.jsonContentType,
    headers: {'Authorization': 'Bearer ${appController.tokenId}'});
Dio dio = Dio(options);

class ApiHelper {
  static Future get(
    String documents,
    Map<String, dynamic> parameters,
  ) async {
    try {
      parameters.addAll({'key': apiKey});

      final response = await dio.get(
        '/$documents',
        queryParameters: parameters,
      );

      final extractedData = response.data;

      if (extractedData == null) return;

      if (response.statusCode == 200) {
        return extractedData['documents'];
      } else {
        throw Exception('Fails request get /$documents');
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future post(String documents, Map<String, dynamic> parameters) async {
    try {
      final response =
          await dio.post('/$documents?key=$apiKey', data: parameters);

      final extractedData = response.data;

      if (extractedData == null) return;

      if (response.statusCode == 200) {
        return extractedData;
      } else {
        throw Exception('Fails request post /$documents');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future patch(String documents, String documentId,
      Map<String, dynamic> parameters) async {
    try {
      final response = await dio.patch('/$documents/$documentId?key=$apiKey',
          data: parameters);

      final extractedData = response.data;

      if (extractedData == null) return;

      if (response.statusCode == 200) {
        return extractedData;
      } else {
        throw Exception('Fails request patch /$documents');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future signinToken() async {
    try {
      final options = BaseOptions(
        baseUrl: 'https://identitytoolkit.googleapis.com/v1',
        contentType: Headers.jsonContentType,
      );
      Dio dio = Dio(options);

      final parameters = <String, dynamic>{
        'email': 'test@test.com',
        'password': 'password',
        'returnSecureToken': true
      };

      final response = await dio
          .post('/accounts:signInWithPassword?key=$apiKey', data: parameters);

      final extractedData = response.data;

      if (extractedData == null) return;

      if (response.statusCode == 200) {
        return extractedData;
      } else {
        throw Exception('Fails request signinWithPassword');
      }
    } catch (e) {
      rethrow;
    }
  }
}
