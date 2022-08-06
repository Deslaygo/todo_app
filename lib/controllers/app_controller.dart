import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/helpers/api_helper.dart';

const tokenKey = 'token';

class AppController extends GetxController {
  final _isLoading = RxBool(false);
  final _tokenId = RxString('');

  bool get isLoading => _isLoading.value;
  String get tokenId => _tokenId.value;

  void loading(bool value) => _isLoading.value = value;

  Future<String> validateToken() async {
    DateTime expireDate;

    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(tokenKey);

    if (data != null) {
      final dataToken = jsonDecode(data);
      expireDate = DateTime.parse(dataToken['expireDate'].toString());

      if (DateTime.now().isAfter(expireDate)) {
        _tokenId.value = await generateToken();
      }
      _tokenId.value = dataToken['token'];
    } else {
      _tokenId.value = await generateToken();
    }

    return _tokenId.value;
  }

  Future<String> generateToken() async {
    try {
      final data = await ApiHelper.signinToken();

      if (data != null) {
        final prefs = await SharedPreferences.getInstance();

        _tokenId.value = data['idToken'];
        final dataToken = <String, dynamic>{
          'token': _tokenId.value,
          'expireDate': DateTime.now()
              .add(Duration(seconds: int.parse(data['expiresIn'].toString())))
              .toIso8601String(),
        };
        prefs.setString(tokenKey, jsonEncode(dataToken));
      }
    } catch (e) {
      rethrow;
    }
    return tokenId;
  }
}
