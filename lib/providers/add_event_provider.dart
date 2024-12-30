import 'package:flutter/material.dart';

class AddEventProvider extends ChangeNotifier {
  List<String> eventsCategories = [
    "birthday",
    "book_club",
    "eating",
    "exhibtion",
    "gaming",
    "holiday",
    "sport",
    "workshop",
    "meeting",
  ];

  int selectedIndex = 0;

  String get imageName => eventsCategories[selectedIndex];
  String get selectedEventName => eventsCategories[selectedIndex];
  int get eventsCategoriesLength => eventsCategories.length;

  changeEventCategory(int index) {
    selectedIndex = index;

    notifyListeners();
  }
}
