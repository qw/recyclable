class Prediction {
  final double probability;
  final String tagId;
  final String tagName;
  String created;

  Prediction({this.probability, this.tagId, this.tagName});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      probability: json['probability'],
      tagId: json['tagId'],
      tagName: json['tagName'],
    );
  }
}