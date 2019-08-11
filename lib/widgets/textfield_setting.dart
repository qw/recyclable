import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextFieldSetting extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final Widget action;

  TextFieldSetting(this.controller, {this.title = '', this.action}) {
    assert(controller != null);
  }

  @override
  State<StatefulWidget> createState() =>
      _TextfieldState(controller, title: title, action: action);
}

class _TextfieldState extends State<TextFieldSetting> {
  String title;
  TextEditingController controller;
  Widget action;

  _TextfieldState(this.controller, {this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: Color(0xffbcbbc1), width: 0.3),
            bottom: BorderSide(color: Color(0xffbcbbc1), width: 0.3)),
        color: Colors.white,
      ),
      padding:
          EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 20.0),
      child: (Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title.toUpperCase(),
                style: Theme.of(context).textTheme.caption),
            action,
          ],
        ),
        Container(
          height: 44,
          child: CupertinoTextField(
            placeholder: controller.text,
            controller: controller,
          ),
        )
      ])),
    );
  }
}
