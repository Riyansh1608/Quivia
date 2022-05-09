import 'package:flutter/material.dart';
import 'package:quivia/pages/home_screen.dart';

class Base extends StatefulWidget {
  const Base({Key? key}) : super(key: key);

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: base_Ui(),
    );
  }

  Widget base_Ui() {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Home();
                    },
                  ),
                );
              },
              child: const Text(
                "Start",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
