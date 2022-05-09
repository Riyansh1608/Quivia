import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quivia/providers/home_screen_provider.dart';

class Home extends StatelessWidget {
  double? _deviceHeight, _deviceWidth;

  HomeScreenProvider? _pageProvider;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_context) => HomeScreenProvider(context: context),
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (_context) {
      _pageProvider = _context.watch<HomeScreenProvider>();
      if (_pageProvider!.questions != null) {
        return Scaffold(
          body: SafeArea(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
            child: _ui(),
          )),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      }
    });
  }

  Widget _ui() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        _questionBox(),
        Column(
          children: [
            _trueButton(),
            SizedBox(
              height: _deviceHeight! * 0.02,
            ),
            _falseButton(),
          ],
        ),
      ],
    );
  }

  Widget _questionBox() {
    return Text(
      _pageProvider!.getCurrentQuestText(),
      style: const TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      minWidth: _deviceWidth! * 0.8,
      height: _deviceHeight! * 0.1,
      onPressed: () {
        _pageProvider?.answerQuestion("True");
      },
      color: Colors.green,
      child: const Text(
        "True",
        style: TextStyle(
            fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      minWidth: _deviceWidth! * 0.8,
      height: _deviceHeight! * 0.1,
      onPressed: () {
        _pageProvider?.answerQuestion("False");
      },
      color: Colors.red,
      child: const Text(
        "False",
        style: TextStyle(
            fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
