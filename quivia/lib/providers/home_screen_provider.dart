import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomeScreenProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestion = 10;
  List? questions;
  int _currentQuestionCount = 0;
  int _score = 0;

  BuildContext context;
  HomeScreenProvider({required this.context}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionFromApi();
  }

  Future<void> _getQuestionFromApi() async {
    var _response = await _dio.get(
      '',
      queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'difficulty': 'easy',
      },
    );
    var _data = jsonDecode(_response.toString());
    questions = _data["results"];
    //print(questions![_currentQuestionCount]["correct_answer"]);
    notifyListeners();
  }

  String getCurrentQuestText() {
    return questions![_currentQuestionCount]["question"];
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
    if (_currentQuestionCount == _maxQuestion) {
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
          content: Text("Score : $_score/10 "),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
