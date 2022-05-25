import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeButton extends StatelessWidget {
  const AdaptativeButton(
      {Key? key, required this.label, required this.onPressed})
      : super(key: key);

  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label),
            onPressed: onPressed,
            color: Theme.of(context).primaryColor,
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                surfaceTintColor: Colors.white),
            onPressed: onPressed,
            child: Text(label),
          );
  }
}
