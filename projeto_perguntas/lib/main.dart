import 'package:flutter/material.dart';
import 'package:projeto_perguntas/answer.dart';
import 'package:projeto_perguntas/question.dart';
import 'package:projeto_perguntas/questionary.dart';
import 'package:projeto_perguntas/result.dart';

main() => runApp(PerguntaApp());

class PerguntaAppState extends State<PerguntaApp> {
  var _perguntaSelecionada = 0;
  var _totalGrade = 0;

  final List<Map<String, Object>> _questions = [
    {
      'text': 'Qual é a sua cor favorita?',
      'answers': [
        {'text': 'Preto', 'grade': 10},
        {'text': 'Vermelho', 'grade': 8},
        {'text': 'Verde', 'grade': 5},
        {'text': 'Branco', 'grade': 3},
      ]
    },
    {
      'text': 'Qual é o seu animal favorito?',
      'answers': [
        {'text': 'Coelho', 'grade': 1},
        {'text': 'Cobra', 'grade': 5},
        {'text': 'Elefante', 'grade': 9},
        {'text': 'Leão', 'grade': 6},
      ],
    },
    {
      'text': 'Qual é o seu instrutor favorito?',
      'answers': [
        {'text': 'Maria', 'grade': 5},
        {'text': 'João', 'grade': 10},
        {'text': 'Leo', 'grade': 2},
        {'text': 'Pedro', 'grade': 8},
      ],
    }
  ];

  void responder(int grade) {
    setState(() {
      _perguntaSelecionada++;
      _totalGrade += grade;
      print(_totalGrade);
    });
  }

  void restartQuestionary() {
    setState(() {
      _perguntaSelecionada = 0;
      _totalGrade = 0;
    });
  }

  bool get hasSelectedAnswer {
    return _perguntaSelecionada < _questions.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Perguntas"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
          child: Center(
            child: hasSelectedAnswer
                ? Questionary(
                    questions: _questions,
                    selectedQuestion: _perguntaSelecionada,
                    responder: responder)
                : Result(
                    finalGrade: _totalGrade,
                    whenRestartQuestionary: restartQuestionary),
          ),
        ),
      ),
    );
  }
}

class PerguntaApp extends StatefulWidget {
  const PerguntaApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PerguntaAppState();
  }
}
