import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:quivia/pages/base_screen.dart';

class HomeScreenProvider extends ChangeNotifier {
  final String? difficulty;
  final String? typeofquestion;
  final int? maxQuestion;
  final Dio _dio = Dio();

  List? questions;
  int _currentQuestionCount = 0;
  int _score = 0;

  BuildContext context;
  HomeScreenProvider(
      {required this.context,
      this.difficulty,
      this.typeofquestion,
      this.maxQuestion}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionFromApi();
  }

  Future<void> _getQuestionFromApi() async {
    var _response = await _dio.get(
      '',
      queryParameters: {
        'amount': 10,
        'type': typeofquestion,
        'difficulty': difficulty,
      },
    );
    var _data = jsonDecode(_response.toString());
    questions = _data["results"];
    print(questions![_currentQuestionCount]);
    notifyListeners();
  }

  String getCurrentQuestText() {
    print(
        "type : $typeofquestion \n amount : $maxQuestion \n difficulty : $difficulty");
    return questions![_currentQuestionCount]["question"];
  }

  String getCorrectOptionText() {
    return questions![_currentQuestionCount]["correct_answer"];
  }

  List<dynamic> getOptionsText() {
    return questions![_currentQuestionCount]["incorrect_answers"];
  }

  void answerQuestion(String _ans) async {
    bool isCorrect =
        questions![_currentQuestionCount]["correct_answer"] == _ans;
    _currentQuestionCount++;
    if (isCorrect) {
      _score++;
    }
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          title: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel_sharp,
            color: Colors.white,
          ),
        );
      },
    );
    await Future.delayed(
      const Duration(seconds: 1),
    );
    Navigator.pop(context);
    if (_currentQuestionCount == maxQuestion) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.blue,
          title: const Text(
            "Game Over!",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          content: Text("Score : $_score/$maxQuestion "),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => const Base())));
  }
}
