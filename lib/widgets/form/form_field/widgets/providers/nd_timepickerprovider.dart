import 'package:flutter/material.dart';

class NDTimePickerData extends ChangeNotifier {
  NDTimePickerData({required this.selectedTime});
  TimeOfDay selectedTime;

  void setTime(TimeOfDay x) {
    selectedTime = x;
    notifyListeners();
  }

  TimeOfDay getTime() => selectedTime;
}
