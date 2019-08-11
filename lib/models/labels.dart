import 'package:dart/models/label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Labels {
  Labels._();

  static const List<Label> all = [
    recyclable,
    non_recyclable,
    metal,
    paper,
    compost,
    plastic
  ];

  static const IconData _apple = const IconData(0xf179, fontFamily: 'Apple');

  static const Label recyclable = Label(
      'Recyclable',
      Icon(CupertinoIcons.refresh_circled_solid,
          color: Colors.green));

  static const Label non_recyclable = Label('Non-recyclable',
      Icon(CupertinoIcons.clear_circled_solid, color: Colors.red));

  static const Label metal = Label('Metal',
      Icon(CupertinoIcons.gear_solid, color: Colors.black));

  static const Label paper = Label('Paper',
      Icon(CupertinoIcons.news_solid, color: Colors.black));

  static const Label compost =
      Label('Compost', Icon(_apple, color: Colors.black));

  static const Label plastic =
      Label('Plastic', Icon(Icons.local_parking, color: Colors.black,));
}
