import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Result extends StatelessWidget {
  const Result(
      {Key? key,
      required this.finalGrade,
      required this.whenRestartQuestionary})
      : super(key: key);

  final int finalGrade;
  final void Function() whenRestartQuestionary;

  String get resultText {
    if (finalGrade < 8) {
      return 'Parabéns!';
    } else if (finalGrade < 12) {
      return 'Você é bom!';
    } else if (finalGrade < 16) {
      return 'Impressionante!';
    } else {
      return 'Nível Jedi!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(resultText, style: const TextStyle(fontSize: 28)),
            Text('Sua pontuação foi: $finalGrade'),
          ],
        ),
        TextButton(
            onPressed: whenRestartQuestionary,
            child: Text(
              "Reiniciar?",
              style: TextStyle(fontSize: 18),
            ))
      ],
    );
  }
}
