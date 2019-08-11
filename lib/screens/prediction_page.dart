import 'dart:io';

import 'package:dart/api/api.dart';
import 'package:dart/models/prediction.dart';
import 'package:dart/models/prediction_attempt.dart';
import 'package:dart/models/labelled_item.dart';
import 'package:dart/models/labelled_items.dart';
import 'package:dart/widgets/prediction_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../config_loader.dart';
import '../utils.dart';

class PredictionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  static const String TITLE = 'Recyclable';
  static const int DISPLAY_LIMIT = 10;
  static const double LEFT_INSET = 20.0;

  bool detectingImage;
  List<PredictionAttempt> _attempts;

  @override
  void initState() {
    super.initState();
    detectingImage = false;
    _attempts = List<PredictionAttempt>();
    if (ConfigLoader().config.showExamples) {
      PredictionAttempt.samplePredictions().then((value) {
        setState(() {
          _attempts = value;
        });
      });
    }

    if (ConfigLoader().config.firstTime) {
      // Using Future.delayed make sure this is called after build not during
      Future.delayed(Duration.zero, () =>  showCupertinoDialog(context: context, builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Configure API Settings'),
          content: Text('Configure your API URL and Key in Settings > API'),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      }));

      ConfigLoader().config.firstTime = false;
      ConfigLoader().save();
    }

  }

  void _setPredictions(List<Prediction> predictions, File image) {
    predictions.sort((a, b) {
      if (a.probability == b.probability) {
        return 0;
      } else if (a.probability > b.probability) {
        return -1;
      }
      return 1;
    });

    setState(() {
      _attempts.insert(
          0, PredictionAttempt(predictions: predictions, image: image));
      if (_attempts.length > DISPLAY_LIMIT) {
        _attempts.removeLast();
      }
    });
  }

  void pickImage(BuildContext context, ImageSource source) {
    setState(() {
      this.detectingImage = true;
    });
    ImagePicker.pickImage(source: source, maxHeight: 500).then((data) {
      if (data == null) {
        imageCancelled(context);
        return;
      }

      Api.predictWithFile(data).then((List<Prediction> predictions) {
        _setPredictions(predictions, data);
        setState(() {
          this.detectingImage = false;
        });
      }).catchError((err) {
        print(err);
        if (err == HttpStatus.unauthorized || err == HttpStatus.notFound) {
          showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text('Invalid API Settings'),
                  content: Text(
                      'Please go to settings and set API Endpoint and API Key'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('Ok'),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                );
              });
        }
        imageCancelled(context);
      });
    }).catchError((err) {
      imageCancelled(context);
    });
  }

  void imageCancelled(BuildContext context) {
    setState(() {
      this.detectingImage = false;
    });
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text('Image select cancelled.'),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Widget buildPredictionCard(BuildContext context, int pos) {
    if (pos >= _attempts.length) {
      return null;
    }
    List<Prediction> predictions = _attempts[pos].predictions;

    Prediction mostLikely = predictions[0];
    String title = Utils.capitalize(mostLikely.tagName);
    String percentage = '${(mostLikely.probability * 100).toStringAsFixed(2)}%';
    title += ': ' + percentage;
    LabelledItem item = LabelledItems.lookFor(mostLikely.tagName);

    return PredictionCard(_attempts[pos].image, item, title: title, subtitle: Utils.randPredictionPhrase());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        return CustomScrollView(slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(TITLE),
            leading: Row(
              children: <Widget>[
                Text(Utils.appStoreStyleDate(),
                    style: Theme.of(context).textTheme.caption),
              ],
            ),
            trailing: Builder(
              builder: (context) {
                if (detectingImage) {
                  return CupertinoActivityIndicator();
                }
                return Material(
                  type: MaterialType.transparency,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.photo),
                        onPressed: ConfigLoader().validCredentials() ? () =>
                            pickImage(context, ImageSource.gallery) : null,
                        color: CupertinoTheme.of(context).primaryColor,

                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.photo_camera),
                        onPressed: ConfigLoader().validCredentials() ? () =>
                            pickImage(context, ImageSource.camera) : null,
                        color: CupertinoTheme.of(context).primaryColor,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SliverSafeArea(
            sliver: SliverList(delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int pos) {
                if (_attempts == null || _attempts.length == 0) {
                  if (pos == 0) {
                    return Column(
                      children: <Widget>[
                        Container(
                          alignment: AlignmentDirectional.center,
                        ),
                        Center(
                          child: Text('Upload a photo to get started!'),
                        ),
                      ],
                    );
                  }
                  return null;
                }
                return buildPredictionCard(context, pos);
              },
            )),
          ),
        ]);
      }
    );
  }
}
