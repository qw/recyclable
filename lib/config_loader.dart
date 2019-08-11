import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import 'models/config.dart';

class ConfigLoader {
  static const String DEFAULT_PATH = 'assets/config';
  static const String FILENAME = 'config.json';

  Config config;

  Config defaultConfig;

  static final ConfigLoader _configLoader = ConfigLoader._internal();

  ConfigLoader._internal();

  factory ConfigLoader() {
    return _configLoader;
  }

  bool validCredentials() {
    return config.apiKey != null && config.apiKey != '' && config.apiEndpoint != null && config.apiEndpoint != '';
  }

  Future load() async {
    String d = await dir();
    final file = File(d);
    String loaded = await rootBundle.loadString(DEFAULT_PATH + '/' + FILENAME);
    defaultConfig = await _loadAndFixEmptyFields(Config.fromJson(json.decode(loaded)));
    if (!await file.exists()) {
      // copy default config from assets
      config = Config.from(defaultConfig);
      await save();
      return;
    }

    String s = await file.readAsString();
    config = await _loadAndFixEmptyFields(Config.fromJson(json.decode(s)));
  }

  /// Saves to persistent app document dir.
  Future save() async {
    final file = File(await dir());
    await file.create(recursive: true);
    file.writeAsString(json.encode(config));
  }

  Future<Config> _loadAndFixEmptyFields(Config config) async {
    config.showExamples ??= false;
    config.apiEndpoint ??= '';
    config.apiKey ??= '';
    config.firstTime ??= true;
    config.higherPerformance ??= false;

    return config;
  }

  Future<String> dir() async {
    final docs = await getApplicationDocumentsDirectory();
    return docs.path + '/' + DEFAULT_PATH + '/' + FILENAME;
  }
}