import 'package:flutter/material.dart';

class NDFormFieldData extends ChangeNotifier {
  NDFormFieldData({required this.ndFormFieldController});
  TextEditingController ndFormFieldController;

  void setText(String x) {
    ndFormFieldController.text = x;
    notifyListeners();
  }

  String getData() => ndFormFieldController.value.text;
}
