import 'package:flutter/material.dart';

class CenterText extends StatelessWidget {
  const CenterText(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
