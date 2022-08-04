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
          'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjFhZjYwYzE3ZTJkNmY4YWQ1MzRjNDAwYzVhMTZkNjc2ZmFkNzc3ZTYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vYXBwbGF1ZG8tdG9kby1hcHAiLCJhdWQiOiJhcHBsYXVkby10b2RvLWFwcCIsImF1dGhfdGltZSI6MTY1OTYxNDU1NywidXNlcl9pZCI6IllWM1BkRTRlenZkcUl3dlU5RGVFdFhXZDN4QzMiLCJzdWIiOiJZVjNQZEU0ZXp2ZHFJd3ZVOURlRXRYV2QzeEMzIiwiaWF0IjoxNjU5NjE0NTU3LCJleHAiOjE2NTk2MTgxNTcsImVtYWlsIjoidGVzdEB0ZXN0LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0ZXN0QHRlc3QuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.SIHOB6Uf76wcRjMYf_q3CM2ppTYogXzCNyJyzYDg7cQkqaEZGanYzecD2FbJ-zFhuciJUx-BDFRuLD21l2ff0VkAP8lj4OBMxd4LdvqxFDfypDWD227pzFo57YGXlgzvZ2HtK3SZ7dbZBTMQ7J9jKDUugcq5jQRbUHtE48_d_VXTP5KkTzjUfJ7r_HpMy-P0tQa8g46v95xG4BJqtV2uj6XqSJkPAaaf-Ll7OD0tYUTrTB3QYFX70k5_SshVHEnpP9N7EFRNFOdpplXETSnaCBP1aaOmOIPvADsiqyMGRvdo32KyyBZtoCT78WtqByG4bM9NNj_I-DcJXVlq0UxcEA'
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
