import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeTextField extends StatelessWidget {
  const AdaptativeTextField(
      {Key? key,
      required this.label,
      required this.controller,
      required this.keyboardType,
      required this.submit})
      : super(key: key);

  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final VoidCallback submit;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoTextField(
              placeholder: label,
              decoration: BoxDecoration(),
              controller: controller,
              keyboardType: keyboardType,
              onSubmitted: (_) => submit(),
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            ),
          )
        : TextField(
            decoration: InputDecoration(labelText: label),
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: (_) => submit(),
          );
  }
}
