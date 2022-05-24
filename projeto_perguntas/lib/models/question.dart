class Question {
  final String question;
  final List<Answer> answers;

  Question({required this.question, required this.answers});
}

class Answer {
  final String text;
  final int grade;

  Answer({required this.text, required this.grade});
}
