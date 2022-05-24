import 'package:flutter/material.dart';

class AnswerWidget extends StatelessWidget {
  const AnswerWidget({Key? key, required this.answer, required this.onPressed})
      : super(key: key);

  final String answer;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(answer),
      ),
    );
  }
}
