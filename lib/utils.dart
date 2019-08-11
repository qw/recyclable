import 'dart:io';
import 'dart:math';

import 'package:dart/models/labelled_item.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'models/labels.dart';

class Utils {

  static const List<String> PREDICTION_CAPTIONS = const [
    'I think it\'s...',
    'It might be...',
    'Is it...',
    'It must be...'
  ];

  static final random = Random();

  static String appStoreStyleDate() {
    return Intl()
        .date('EEE, d MMMM')
        .format(DateTime.now())
        .toUpperCase();
  }

  static String capitalize(String string) {
    return string != null ? string[0].toUpperCase() + string.substring(1) : string;
  }

  static Future<File> getImageFileFromAssets(String name) async {
    final byteData = await rootBundle.load('assets/graphics/examples/$name');

    final file = File('${(await getTemporaryDirectory()).path}/$name');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  static String randPredictionPhrase() {
    int i = random.nextInt(PREDICTION_CAPTIONS.length);
    return PREDICTION_CAPTIONS[i];
  }

  static bool recyclable(LabelledItem item) {
    return item != null && item.labels != null && item.labels.contains(Labels.recyclable);
  }
}
