import 'dart:convert';
import 'package:flutter/services.dart';

abstract class ConfigReader {
  static Map<String, dynamic> _config = {};

  static Future<void> initialize() async {
    final configString = await rootBundle.loadString('config/app_config.json');
    _config = json.decode(configString) as Map<String, dynamic>;
  }

  static String getApiKey() {
    return _config['API_KEY'] as String;
  }

  static String getApiUrl() {
    return _config['API_URL'] as String;
  }

  static String getBasePath() {
    return _config['BASE_PATH'] as String;
  }
}
