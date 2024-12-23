import 'package:flutter/material.dart';
import 'package:todo_c13_monday/screens/home/tabs/home_tab.dart';
import 'package:todo_c13_monday/screens/home/tabs/love_tab.dart';
import 'package:todo_c13_monday/screens/home/tabs/map_tab.dart';
import 'package:todo_c13_monday/screens/home/tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "homeScreen";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BottomNavigationBar(currentIndex: currentIndex,
              onTap: (value) {
                currentIndex =value;
                setState(() {

                });
              },
              items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Love"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ]),

      body: tabs[currentIndex],
    );
  }

  List<Widget> tabs = [
    HomeTab(),
    MapTab(),
    LoveTab(),
    ProfileTab(),
  ];
}
