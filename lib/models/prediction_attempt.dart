import 'dart:io';

import 'package:dart/models/prediction.dart';

import '../utils.dart';

class PredictionAttempt {
  final List<Prediction> predictions;
  final File image;

  PredictionAttempt({this.predictions, this.image});

  static Future<List<PredictionAttempt>> samplePredictions() async {
    List<String> names = const ['apple.jpg', 'can.jpg', 'bottle.png'];
    List<PredictionAttempt> attempts = <PredictionAttempt>[];

    for (String s in names) {
      attempts.add(PredictionAttempt(
        predictions: <Prediction>[
          Prediction(probability: 1.0, tagName: s.substring(0, s.indexOf('.'))),
        ],
        image: await Utils.getImageFileFromAssets(s),
      ));
    }

    return attempts;
  }
}