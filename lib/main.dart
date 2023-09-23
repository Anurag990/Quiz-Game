import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() {
  runApp(const Quzzler());
}

class Quzzler extends StatelessWidget {
  const Quzzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: const SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Quizpage(),
        )),
      ),
    );
  }
}

class Quizpage extends StatefulWidget {
  const Quizpage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _QuizpageState createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  List<Icon> scoreKeeper = [];
  void checkAnswer(bool userPickAnswer) {
    //IF User press true
    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: "RFLUTTER ALERT",
          desc: "Flutter is more awesome with RFlutter Alert.",
        ).show();

        quizBrain.reset();

        scoreKeeper = [];
      } else {
        bool correctAnswer = quizBrain.getAnswer();
        if (userPickAnswer == correctAnswer) {
          scoreKeeper.add(
            const Icon(Icons.check, color: Colors.green),
          );
        } else {
          scoreKeeper.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                style: const TextStyle(color: Colors.white, fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextButton(
              onPressed: () {
                checkAnswer(true);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.black,
              ),
              child: const Text(
                'True',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              )),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextButton(
            onPressed: () {
              checkAnswer(false);
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.black,
            ),
            child: const Text(
              'False',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
        )),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
