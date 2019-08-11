class Config {
  bool showExamples;
  String apiKey;
  String apiEndpoint;
  bool firstTime;
  bool higherPerformance;

  Config({this.showExamples, this.apiEndpoint, this.apiKey, this.firstTime, this.higherPerformance});

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      showExamples: json['showExamples'],
      apiKey: json['apiKey'],
      apiEndpoint: json['apiEndpoint'],
      firstTime: json['firstTime'],
      higherPerformance: json['higherPerformance'],
    );
  }

  factory Config.from(Config config) {
    return Config(
      showExamples: config.showExamples,
      apiKey: config.apiKey,
      apiEndpoint: config.apiEndpoint,
      firstTime: config.firstTime,
      higherPerformance: config.higherPerformance
    );
  }

  Map<String, dynamic> toJson() => {
        'showExamples': showExamples,
        'apiKey': apiKey,
        'apiEndpoint': apiEndpoint,
        'firstTime': firstTime,
        'higherPerformance': higherPerformance,
      };
}
