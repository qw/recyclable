import 'dart:convert';
import 'dart:io';

import 'package:dart/config_loader.dart';
import 'package:dart/models/prediction.dart';
import 'package:http/http.dart';

class Api {
  static Future<List<Prediction>> predictWithFile(File image) async {
    String endpoint = ConfigLoader().config.apiEndpoint;
    String key = ConfigLoader().config.apiKey;

    var request = MultipartRequest("POST", Uri.parse(endpoint));
    request.headers['Prediction-Key'] = key;
    var file = MultipartFile.fromBytes("", await image.readAsBytes());
    request.files.add(file);
    StreamedResponse response = await request.send();
    if (response.statusCode != HttpStatus.ok) {
      throw(response.statusCode);
    }
    var predictionJson = json.decode(await response.stream.bytesToString());
    List<Prediction> predictions = List<Prediction>();
    for (var i in predictionJson['predictions']) {
      Prediction p = Prediction.fromJson(i);
      p.created = predictionJson['created'];
      predictions.add(p);
    }
    return predictions;
  }
}