import 'package:flutter/material.dart';
import 'package:quivia/pages/home_screen.dart';

class Base extends StatefulWidget {
  const Base({Key? key}) : super(key: key);

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  double? _deviceHeight, _deviceWidth;
  double _currentDifficultyLevel = 0;
  List<String> difficulty = ["Easy", "Medium", "Hard"];
  String type = "none";
  double _totalQuestions = 1;
  Color k = Colors.blueGrey;
  Color j = Colors.blueGrey;

  @override
  void initState() {
    super.initState();
    k = Colors.blueGrey;
    j = Colors.blueGrey;
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: base_Ui(),
    );
  }

  Widget base_Ui() {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            quiviaLogo(),
            typeOfQuestion(),
            totalQuestionSlider(),
            difficulySlider(),
            startButton(),
          ],
        ),
      ),
    );
  }

  Widget totalQuestionSlider() {
    return Column(
      children: [
        Text(
          'Number of Questions : ${_totalQuestions.toInt()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        Slider(
          min: 1,
          max: 10,
          value: _totalQuestions,
          onChanged: (_value) {
            setState(() {
              _totalQuestions = _value;
            });
          },
          divisions: 9,
          label: _totalQuestions.toInt().toString(),
        ),
      ],
    );
  }

  Widget difficulySlider() {
    return Column(
      children: [
        Text(
          'Difficulty : ${difficulty[_currentDifficultyLevel.toInt()]}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        Slider(
          min: 0,
          max: 2,
          value: _currentDifficultyLevel,
          onChanged: (_value) {
            setState(() {
              _currentDifficultyLevel = _value;
            });
          },
          divisions: 2,
          label: difficulty[_currentDifficultyLevel.toInt()].toString(),
        ),
      ],
    );
  }

  Widget quiviaLogo() {
    return Container(
      child: const Text(
        "Quivia",
        style: TextStyle(
            color: Colors.white, fontSize: 50, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget typeOfQuestion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          minWidth: _deviceWidth! * 0.35,
          height: _deviceHeight! * 0.06,
          onPressed: () {
            setState(() {
              type = "boolean";
              k = Colors.blue;
              j = Colors.blueGrey;
            });
          },
          child: const Text(
            "True/False",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          color: k,
        ),
        MaterialButton(
          minWidth: _deviceWidth! * 0.35,
          height: _deviceHeight! * 0.06,
          onPressed: () {
            setState(() {
              type = "multiple";
              j = Colors.blue;
              k = Colors.blueGrey;
            });
          },
          child: const Text(
            "MCQ",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          color: j,
        ),
      ],
    );
  }

  Widget startButton() {
    return MaterialButton(
      onPressed: () {
        if (type != "none") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Home(
                  difficulty:
                      difficulty[_currentDifficultyLevel.toInt()].toLowerCase(),
                  type: type,
                  maxQuestion: _totalQuestions.toInt(),
                );
              },
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: const Text(
                  "Choose Question Type",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                ),
                //content: SingleChildScrollView(child: Text("hello")),
                actions: [
                  TextButton(
                    child: const Text(
                      'OK',
                      style: TextStyle(fontSize: 22),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      child: const Text(
        "Start",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      color: Colors.blue,
    );
  }
}
