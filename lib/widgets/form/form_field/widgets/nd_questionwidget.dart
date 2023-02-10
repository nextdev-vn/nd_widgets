import 'package:flutter/material.dart';

import '../../../../constants/types/nd_typography_type.dart';
import '../../../typography/nd_typography.dart';
import '../../nd_form_provider.dart';
import '../nd_formhandler_widget.dart';
import 'providers/nd_questionbuttonprovider.dart';

class NDFormQuestionWidget extends StatefulWidget {
  const NDFormQuestionWidget(
      {Key? key,
      required this.onChanged,
      this.initialSelectedValue,
      required this.question,
      this.accepttext,
      this.declinetext})
      : super(key: key);
  final Function(String?) onChanged;
  final String? initialSelectedValue;
  final String question;
  final String? accepttext;
  final String? declinetext;

  @override
  State<NDFormQuestionWidget> createState() => _NDFormQuestionWidgetState();
}

class _NDFormQuestionWidgetState extends State<NDFormQuestionWidget>
    with AutomaticKeepAliveClientMixin {
  String selectedValue = '';
  late final NDFormHandler ndFormHandler;
  late final NDQuestionButtonData dataModel;
  @override
  void initState() {
    selectedValue = widget.initialSelectedValue ?? 'Yes';
    dataModel = NDQuestionButtonData(selectedValue: selectedValue);
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
                  child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Column(children: [
                  const SizedBox(
                    height: 8,
                  ),
                  NDTypography(
                    text: widget.question,
                    type: NDTypographyType.typo6,
                    showDivider: false,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          selectedValue = widget.accepttext ?? 'Yes';
                          widget.onChanged(selectedValue);
                          dataModel.setValue(selectedValue.toString());
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: widget.accepttext ?? 'Yes',
                                groupValue: selectedValue,
                                onChanged: (String? val) {
                                  setState(() {
                                    selectedValue = widget.accepttext ?? 'Yes';
                                    widget.onChanged(selectedValue);
                                    dataModel
                                        .setValue(selectedValue.toString());
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(widget.accepttext ?? 'Yes')
                            ]),
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              selectedValue = widget.declinetext ?? 'No';
                              widget.onChanged(selectedValue);
                              dataModel.setValue(selectedValue.toString());
                            });
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                  value: widget.declinetext ?? 'No',
                                  groupValue: selectedValue,
                                  onChanged: (String? val) {
                                    setState(() {
                                      selectedValue =
                                          widget.declinetext ?? 'No';
                                      widget.onChanged(selectedValue);
                                      dataModel
                                          .setValue(selectedValue.toString());
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(widget.declinetext ?? 'No')
                              ])),
                    ],
                  )
                ]),
              ));
            }));
  }

  @override
  bool get wantKeepAlive => true;
}
