import 'package:flutter/material.dart';
import 'package:todo_c13_monday/screens/intro_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: IntroductionScreen.routeName,
      routes: {
        IntroductionScreen.routeName: (context) => IntroductionScreen(),
      },
    );
  }
}
