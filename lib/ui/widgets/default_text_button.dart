import 'package:flutter/material.dart';

class DefaultTextButton extends StatelessWidget {
  const DefaultTextButton(
      {super.key, required this.onPressed, required this.text});

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(text.toUpperCase()));
  }
}

Widget defaultTextButton({
  required Function() function,
  required String text,
}) =>
    TextButton(onPressed: function, child: Text(text.toUpperCase()));
