import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OutlinedText extends StatelessWidget {
  final String text;

  const OutlinedText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            // use shadows to emulate text outline
            Shadow(
              // bottomLeft
              offset: Offset(-0.5, -0.5),
              color: Colors.black,
              blurRadius: 0.2,
            ),
            Shadow(
              // bottomRight
              offset: Offset(0.5, -0.5),
              color: Colors.black,
              blurRadius: 0.2,
            ),
            Shadow(
              // topRight
              offset: Offset(0.5, 0.5),
              color: Colors.black,
              blurRadius: 0.2,
            ),
            Shadow(
              // topLeft
              offset: Offset(-0.5, 0.5),
              color: Colors.black,
              blurRadius: 0.2,
            ),
          ]),
    );
  }
}
