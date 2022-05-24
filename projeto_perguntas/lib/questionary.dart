import 'package:flutter/material.dart';
import 'package:projeto_perguntas/answer.dart';
import 'package:projeto_perguntas/question.dart';

class Questionary extends StatelessWidget {
  const Questionary(
      {Key? key,
      required this.responder,
      required this.questions,
      required this.selectedQuestion})
      : super(key: key);

  final List<Map<String, Object>> questions;
  final int selectedQuestion;
  final void Function(int grade) responder;

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> answers =
        questions[selectedQuestion].cast()['answers'];
    String questionTitle = questions[selectedQuestion].cast()['text'];

    return Column(
      children: [
        QuestionWidget(text: questionTitle),
        Spacer(),
        ...answers
            .map((answer) => AnswerWidget(
                  answer: answer['text'].toString(),
                  onPressed: () {
                    responder(int.parse(answer['grade'].toString()));
                  },
                ))
            .toList(),
      ],
    );
  }
}
