import 'package:flutter/material.dart';

import '../../../../constants/shape/nd_textfield_shape.dart';
import '../../nd_form_provider.dart';
import '../decorations/nd_formfield_decoration.dart';
import '../nd_formhandler_widget.dart';
import 'providers/nd_formdropdownprovider.dart';

class NDFormDropDown extends StatefulWidget {
  const NDFormDropDown(
      {Key? key,
      required this.values,
      this.initialValue,
      this.padding,
      this.margin,
      this.borderradius,
      this.editingbordercolor,
      this.idlebordercolor,
      this.iconPrefix,
      this.backgroundcolor,
      this.hintText})
      : super(key: key);
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final List<String> values;
  final String? initialValue;
  final double? borderradius;
  final Color? editingbordercolor;
  final Color? idlebordercolor;
  final Icon? iconPrefix;
  final Color? backgroundcolor;
  final String? hintText;

  @override
  State<NDFormDropDown> createState() => _NDFormDropDownState();
}

class _NDFormDropDownState extends State<NDFormDropDown> {
  String selectedValue = '';
  late final NDFormHandler ndFormHandler;
  late final NDFormDropdownData dataModel;

  @override
  void initState() {
    selectedValue = widget.initialValue ?? widget.values[0];
    dataModel = NDFormDropdownData(selectedValue: selectedValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      final NDFormHandler ndFormHandler =
          NDFormHandlerWidget.of(context).ndFormHandler;
      ndFormHandler.setModel(dataModel);
    } on Exception catch (e) {
      print('Exception at attaching to handler : $e');
    }
    return AnimatedBuilder(
        animation: dataModel,
        builder: (context, child) {
          selectedValue = dataModel.selectedValue;
          return Container(
            margin: widget.margin ??
                const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            padding: widget.padding ??
                const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            child: DropdownButtonFormField<String>(
                value: selectedValue,
                decoration: NDFormFieldDecoration(
                  context: context,
                  shape: NDTextFieldShape.roundedsquare,
                  borderRadius: widget.borderradius ?? 6.0,
                  editingBorderColor: widget.editingbordercolor,
                  idleBorderColor: widget.idlebordercolor,
                  ndPrefixIcon: widget.iconPrefix,
                  bgfilled: true,
                  bgcolor: widget.backgroundcolor,
                  hinttext: widget.hintText != null ? widget.hintText : 'Name',
                ),
                validator: (value) => null,
                items: widget.values
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                    .toList(),
                onChanged: (String? textx) {
                  selectedValue = textx.toString();
                  dataModel.setValue(selectedValue);
                }),
          );
        });
  }
}
