import 'package:flutter/material.dart';

class NDFormDropdownData extends ChangeNotifier {
  NDFormDropdownData({required this.selectedValue});

  String selectedValue;

  String getValue() => selectedValue;

  void setValue(String valuenew) {
    selectedValue = valuenew;
    notifyListeners();
  }
}
