import 'package:flutter/material.dart';

class NDQuestionButtonData extends ChangeNotifier {
  NDQuestionButtonData({required this.selectedValue});

  String selectedValue;

  String getValue() => selectedValue;

  void setValue(String valuenew) {
    selectedValue = valuenew;
    notifyListeners();
  }
}
