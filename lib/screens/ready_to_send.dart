import 'dart:io';

import 'package:dart/api/api.dart';
import 'package:dart/models/prediction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';

class ReadyToSend extends StatelessWidget {
  ReadyToSend(this.image, {Key key}) : super(key: key);

  final File image;

  void send(BuildContext context) {
    FutureBuilder(
      future: Api.predictWithFile(image),
      builder: (BuildContext context, AsyncSnapshot<List<Prediction>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<Prediction> predictions = snapshot.data;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(predictions[0].tagName)
                  );
              }
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: PhotoView(
                imageProvider: FileImage(image)
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  color: Colors.red,
                  child: Icon(Icons.clear),
                  shape: CircleBorder(),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                RaisedButton(
                  color: Colors.green,
                  child: Icon(Icons.check),
                  shape: CircleBorder(),
                  onPressed: () {
                    send(context);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          )
        ],
      )
    );
  }

}
