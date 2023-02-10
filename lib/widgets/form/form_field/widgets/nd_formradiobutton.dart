import 'package:flutter/material.dart';

import '../../nd_form_provider.dart';
import '../nd_formhandler_widget.dart';
import 'providers/nd_radioprovider.dart';

class NDFormGenderbutton extends StatefulWidget {
  const NDFormGenderbutton(
      {Key? key, required this.onChanged, required this.initialSelectedValue})
      : super(key: key);
  final Function(String?) onChanged;
  final String initialSelectedValue;
  @override
  State<NDFormGenderbutton> createState() => _NDFormGenderbuttonState();
}

class _NDFormGenderbuttonState extends State<NDFormGenderbutton>
    with AutomaticKeepAliveClientMixin {
  String selectedValue = '';
  late final NDFormHandler ndFormHandler;
  late final NDGenderButtonData dataModel;

  @override
  void initState() {
    selectedValue = widget.initialSelectedValue;
    dataModel = NDGenderButtonData(selectedValue: selectedValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    try {
      final NDFormHandler ndFormHandler =
          NDFormHandlerWidget.of(context).ndFormHandler;
      ndFormHandler.setModel(dataModel);
    } on Exception catch (e) {
      print('Exception at attaching to handler : $e');
    }
    return Container(
      child: AnimatedBuilder(
          animation: dataModel,
          builder: (context, child) {
            selectedValue = dataModel.selectedValue;
            return Card(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    selectedValue = 'Male';
                    widget.onChanged(selectedValue);
                    dataModel.setValue(selectedValue.toString());
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: 'Male',
                          groupValue: selectedValue,
                          onChanged: (String? val) {
                            if (val != null && val.isNotEmpty) {
                              selectedValue = val.toString();
                              widget.onChanged(selectedValue);
                              dataModel.setValue(val.toString());
                            }
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text('Male')
                      ]),
                ),
                InkWell(
                    onTap: () {
                      selectedValue = 'Female';
                      widget.onChanged(selectedValue);
                      dataModel.setValue(selectedValue.toString());
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: 'Female',
                            groupValue: selectedValue,
                            onChanged: (String? val) {
                              if (val != null && val.isNotEmpty) {
                                selectedValue = val.toString();
                                widget.onChanged(selectedValue);
                                dataModel.setValue(val.toString());
                              }
                            },
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text('Female')
                        ])),
              ],
            ));
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
