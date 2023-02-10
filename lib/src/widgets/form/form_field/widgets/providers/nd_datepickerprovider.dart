import 'package:flutter/material.dart';

class NDDatePickerData extends ChangeNotifier {
  NDDatePickerData({required this.selectedDate});
  DateTime selectedDate;

  void setDate(DateTime x) {
    selectedDate = x;
    notifyListeners();
  }

  DateTime getDate() => selectedDate;
}
