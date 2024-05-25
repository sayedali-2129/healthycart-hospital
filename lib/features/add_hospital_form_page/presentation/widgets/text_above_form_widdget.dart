import 'package:flutter/material.dart';


class TextAboveFormFieldWidget extends StatelessWidget {
  const TextAboveFormFieldWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}