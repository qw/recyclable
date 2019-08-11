import 'dart:io';
import 'dart:ui';

import 'package:dart/config_loader.dart';
import 'package:dart/models/labelled_item.dart';
import 'package:dart/models/labels.dart';
import 'package:dart/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PressableCard extends StatefulWidget {
  const PressableCard({
    @required this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.upElevation = 2,
    this.downElevation = 0,
    this.shadowColor = CupertinoColors.black,
    this.duration = const Duration(milliseconds: 100),
    this.onPressed,
    Key key,
  })  : assert(child != null),
        assert(borderRadius != null),
        assert(upElevation != null),
        assert(downElevation != null),
        assert(shadowColor != null),
        assert(duration != null),
        super(key: key);

  final VoidCallback onPressed;

  final Widget child;

  final BorderRadius borderRadius;

  final double upElevation;

  final double downElevation;

  final Color shadowColor;

  final Duration duration;

  @override
  _PressableCardState createState() => _PressableCardState();
}

class _PressableCardState extends State<PressableCard> {
  bool cardIsDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => cardIsDown = false);
        if (widget.onPressed != null) {
          widget.onPressed();
        }
      },
      onTapDown: (details) => setState(() => cardIsDown = true),
      onTapCancel: () => setState(() => cardIsDown = false),
      child: AnimatedPhysicalModel(
        elevation: cardIsDown ? widget.downElevation : widget.upElevation,
        borderRadius: widget.borderRadius,
        shape: BoxShape.rectangle,
        shadowColor: widget.shadowColor,
        duration: widget.duration,
        color: CupertinoColors.lightBackgroundGray,
        child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: widget.child,
        ),
      ),
    );
  }
}

class PredictionCard extends StatelessWidget {
  static const double LEFT_INSET = 20.0;

  final LabelledItem item;

  final String title;

  final String subtitle;

  final File image;

  PredictionCard(this.image, this.item, {this.title, this.subtitle = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(LEFT_INSET, 0, LEFT_INSET, 40.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          new BoxShadow(
              color: Colors.black12,
              offset: new Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 1.0)
        ],
      ),
      child: PressableCard(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: Stack(children: <Widget>[
            Image.file(image, fit: BoxFit.contain),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                child: ClipRect(
                  child: Builder(builder: (BuildContext context) {
                    if (ConfigLoader().config.higherPerformance) {
                      return Container(
                        color: Color.fromARGB(240, 255, 255, 255),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(subtitle.toUpperCase(),
                                      style: Theme.of(context).textTheme.caption),
                                  Text(title,
                                      style: TextStyle(
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              Builder(
                                builder: (context) {
                                  if (Utils.recyclable(item)) {
                                    return Row(
                                        children: item.labels
                                            .map((tag) => Icon(tag.icon.icon,
                                            color: tag.icon.color, size: 32))
                                            .toList());
                                  }

                                  return Icon(Labels.non_recyclable.icon.icon,
                                      color: Labels.non_recyclable.icon.color,
                                      size: 32);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(subtitle.toUpperCase(),
                                      style: Theme.of(context).textTheme.caption),
                                  Text(title,
                                      style: TextStyle(
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              Builder(
                                builder: (context) {
                                  if (Utils.recyclable(item)) {
                                    return Row(
                                        children: item.labels
                                            .map((tag) => Icon(tag.icon.icon,
                                            color: tag.icon.color, size: 32))
                                            .toList());
                                  }

                                  return Icon(Labels.non_recyclable.icon.icon,
                                      color: Labels.non_recyclable.icon.color,
                                      size: 32);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
