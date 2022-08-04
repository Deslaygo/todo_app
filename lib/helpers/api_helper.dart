// ignore_for_file: lines_longer_than_80_chars

import 'package:dio/dio.dart';
import '../config_reader.dart';

final apiUrl = ConfigReader.getApiUrl();
final basePath = ConfigReader.getBasePath();
final apiKey = ConfigReader.getApiKey();

final options = BaseOptions(
    baseUrl: '$apiUrl/$basePath',
    contentType: Headers.jsonContentType,
    headers: {
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjFhZjYwYzE3ZTJkNmY4YWQ1MzRjNDAwYzVhMTZkNjc2ZmFkNzc3ZTYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vYXBwbGF1ZG8tdG9kby1hcHAiLCJhdWQiOiJhcHBsYXVkby10b2RvLWFwcCIsImF1dGhfdGltZSI6MTY1OTU4MDM2OCwidXNlcl9pZCI6IllWM1BkRTRlenZkcUl3dlU5RGVFdFhXZDN4QzMiLCJzdWIiOiJZVjNQZEU0ZXp2ZHFJd3ZVOURlRXRYV2QzeEMzIiwiaWF0IjoxNjU5NTgwMzY4LCJleHAiOjE2NTk1ODM5NjgsImVtYWlsIjoidGVzdEB0ZXN0LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0ZXN0QHRlc3QuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.UB0JiRaRuJ5MtJj5oZJrVDEUoPyacm9rHUsz7iH_W4SrO3RGOHWl80HMjYHDHOH7o2IjXVG0dhsTJGsdjdAi6LHISaSA86RUp-C7NwMjuwcCq2jbXROiuuXM095XFkSqJr-5rbhvST_omnZF2uSMtqRlwpgU6lwcTivXoYsKG0JABVgQ44J4I6SpzDhLFqoGpUVsgWhmS7WkdkKv-hE8Mm4utCnpaOyOzoLIMZCgswVkkRfZSuEP0rdfgT9PVwWU517p_msEu03Gs24z-G2nDpyZ25VsdjEffnPvSlB3JZI8VMtX2eGSSDa_lmeDjw0a-oMtIYAlyWyB9_os16W6FA'
    });
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
      parameters.addAll({'apiKey': apiKey});

      final response = await dio.post('/$documents', data: parameters);

      final extractedData = response.data;

      if (extractedData == null) return;

      final codigo = int.parse(extractedData['codigo'].toString());

      if (codigo > 200) throw Exception(extractedData['mensaje']);

      if (response.statusCode == 200) {
        return extractedData['datos'];
      } else {
        throw Exception('Fails request post /$documents');
      }
    } catch (e) {
      rethrow;
    }
  }
}
