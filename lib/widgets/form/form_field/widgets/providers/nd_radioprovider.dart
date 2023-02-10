import 'package:flutter/material.dart';

class NDGenderButtonData extends ChangeNotifier {
  NDGenderButtonData({required this.selectedValue});

  String selectedValue;

  String getValue() => selectedValue;
  void setValue(String valuenew) {
    selectedValue = valuenew;
    notifyListeners();
  }
}
