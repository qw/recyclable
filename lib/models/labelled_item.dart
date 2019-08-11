import 'package:dart/models/label.dart';

class LabelledItem {
  final String englishName;
  final List<Label> labels;

  const LabelledItem({this.englishName='', this.labels=const []});
}
