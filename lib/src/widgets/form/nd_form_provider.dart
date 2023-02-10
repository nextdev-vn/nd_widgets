import 'package:flutter/material.dart';

import 'form_field/widgets/providers/nd_datepickerprovider.dart';
import 'form_field/widgets/providers/nd_formdropdownprovider.dart';
import 'form_field/widgets/providers/nd_formfieldprovider.dart';
import 'form_field/widgets/providers/nd_multicheckboxselectionprovider.dart';
import 'form_field/widgets/providers/nd_multichipselectionprovider.dart';
import 'form_field/widgets/providers/nd_questionbuttonprovider.dart';
import 'form_field/widgets/providers/nd_radioprovider.dart';
import 'form_field/widgets/providers/nd_timepickerprovider.dart';

class NDFormHandler extends ChangeNotifier {
  NDFormHandler({
    required this.formsKey,
  });
  final GlobalKey<FormState> formsKey;
  List<ChangeNotifier> models = [];
  void getModels() => models;

  void setModel(ChangeNotifier modelx) {
    print('Adding Model ::${modelx.runtimeType}');
    models.add(modelx);
    print('Model List ${models.length}');
  }

  Future<bool> validateForm() async {
    if (formsKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<dynamic>> getFormValues() async {
    final List<dynamic> values = [];
    if (formsKey.currentState!.validate()) {
      for (ChangeNotifier xt in models) {
        switch (xt.runtimeType) {
          case NDFormFieldData:
            final NDFormFieldData jx = xt as NDFormFieldData;
            values.add(jx.getData());
            break;
          case NDFormDropdownData:
            final NDFormDropdownData jx = xt as NDFormDropdownData;
            values.add(jx.getValue());
            break;
          case NDGenderButtonData:
            final NDGenderButtonData jx = xt as NDGenderButtonData;
            values.add(jx.getValue());
            break;
          case NDQuestionButtonData:
            final NDQuestionButtonData jx = xt as NDQuestionButtonData;
            values.add(jx.getValue());
            break;
          case NDMultiCheckboxData:
            final NDMultiCheckboxData jx = xt as NDMultiCheckboxData;
            values.add(jx.getlistselectedindx());
            break;
          case NDMultiChipSelectData:
            final NDMultiChipSelectData jx = xt as NDMultiChipSelectData;
            values.add(jx.getlistselectedindx());
            break;
          case NDDatePickerData:
            final NDDatePickerData jx = xt as NDDatePickerData;
            values.add(jx.getDate());
            break;
          case NDTimePickerData:
            final NDTimePickerData jx = xt as NDTimePickerData;
            values.add(jx.getTime());
            break;
        }
      }
    }
    return values;
  }
}
