import 'package:flutter/material.dart';

import '../../nd_form_provider.dart';
import '../nd_formhandler_widget.dart';
import 'providers/nd_multichipselectionprovider.dart';

class NDMultiChoiceChip extends StatelessWidget {
  NDMultiChoiceChip({
    Key? key,
    this.onSelected,
    required this.onSelectedindex,
    this.margin,
    this.padding,
    this.borderColor,
    this.headingText,
    this.borderWidth,
    required this.values,
    this.preSelected,
  }) : super(key: key) {
    dataModel = NDMultiChipSelectData(values: values, preselected: preSelected);
  }
  final Function(List<String>)? onSelected;
  final Function(List<int>) onSelectedindex;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? borderColor;
  final String? headingText;
  final double? borderWidth;
  final List<String> values;
  final List<int>? preSelected;
  late final NDMultiChipSelectData dataModel;

  @override
  Widget build(BuildContext context) {
    try {
      final NDFormHandler ndFormHandler =
          NDFormHandlerWidget.of(context).ndFormHandler;
      ndFormHandler.setModel(dataModel);
    } on Exception catch (e) {
      print('Exception at attaching to handler : $e');
    }

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      child: AnimatedBuilder(
          animation: dataModel,
          builder: (context, child) {
            final List<ChipData> chips = dataModel.getlist();
            return InputDecorator(
                decoration: InputDecoration(
                  label:
                      headingText != null ? Text(headingText.toString()) : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                          color: borderColor ?? Colors.black,
                          width: borderWidth ?? 1.5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                          color: borderColor ?? Colors.black,
                          width: borderWidth ?? 1.5)),
                ),
                child: Wrap(
                  children: [
                    for (int j = 0; j < chips.length; j++) ...[
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: ChoiceChip(
                              label: Text(chips[j].text),
                              labelStyle: const TextStyle(color: Colors.black),
                              backgroundColor: Colors.green,
                              selectedColor: Colors.orange,
                              disabledColor: Colors.white,
                              selected: chips[j].selected,
                              onSelected: (bool value) {
                                dataModel.onSelected(index: j, value: value);
                                if (onSelected != null) {
                                  onSelected!(dataModel.getlistselected());
                                }
                                onSelectedindex(
                                    dataModel.getlistselectedindx());
                              }))
                    ]
                  ],
                ));
          }),
    );
  }
}
