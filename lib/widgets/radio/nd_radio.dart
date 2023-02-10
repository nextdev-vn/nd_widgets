import 'package:flutter/material.dart';

import '../../constants/colors/nd_color.dart';
import '../../constants/size/nd_size.dart';
import '../../constants/types/nd_radio_type.dart';

class NDRadio<T> extends StatefulWidget {
  const NDRadio(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      this.size = NDSize.SMALL,
      this.type = NDRadioType.basic,
      this.radioColor = NDColors.SUCCESS,
      this.activeBgColor = NDColors.WHITE,
      this.inactiveBgColor = NDColors.WHITE,
      this.activeBorderColor = NDColors.DARK,
      this.inactiveBorderColor = NDColors.DARK,
      this.activeIcon = const Icon(
        Icons.check,
        size: 20,
        color: NDColors.DARK,
      ),
      this.inactiveIcon,
      this.customBgColor = NDColors.SUCCESS,
      this.autofocus = false,
      this.focusNode,
      this.toggleable = false})
      : super(key: key);

  final NDRadioType type;

  final double size;

  final Color radioColor;

  final Color activeBgColor;

  final Color inactiveBgColor;

  final Color activeBorderColor;

  final Color inactiveBorderColor;

  final ValueChanged<T>? onChanged;

  final Widget activeIcon;

  final Widget? inactiveIcon;

  final Color customBgColor;

  final bool autofocus;

  final FocusNode? focusNode;

  final T value;

  final T groupValue;

  final bool toggleable;

  @override
  _NDRadioState<T> createState() => _NDRadioState<T>();
}

class _NDRadioState<T> extends State<NDRadio<T>> with TickerProviderStateMixin {
  bool get enabled => widget.onChanged != null;
  bool selected = false;
  T? groupValue;

  void onStatusChange() {
    groupValue = widget.value;
    _handleChanged(widget.value == groupValue);
  }

  void _handleChanged(bool selected) {
    if (selected) {
      widget.onChanged!(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    selected = widget.value == widget.groupValue;
    return InkWell(
        borderRadius:
            widget.type == NDRadioType.basic && widget.type == NDRadioType.blunt
                ? BorderRadius.circular(50)
                : widget.type == NDRadioType.square
                    ? BorderRadius.circular(0)
                    : BorderRadius.circular(10),
        enableFeedback: enabled,
        onTap: onStatusChange,
        child: Container(
            height: widget.size,
            width: widget.size,
            decoration: BoxDecoration(
                color: selected ? widget.activeBgColor : widget.inactiveBgColor,
                borderRadius: widget.type == NDRadioType.basic
                    ? BorderRadius.circular(50)
                    : widget.type == NDRadioType.square
                        ? BorderRadius.circular(0)
                        : BorderRadius.circular(10),
                border: Border.all(
                    color: selected
                        ? widget.activeBorderColor
                        : widget.inactiveBorderColor)),
            child: selected
                ? widget.type == NDRadioType.basic ||
                        widget.type == NDRadioType.square
                    ? Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            width: widget.size * 0.7,
                            height: widget.size * 0.7,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget.radioColor),
                          )
                        ],
                      )
                    : widget.type == NDRadioType.blunt
                        ? Stack(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                              ),
                              Container(
                                margin: const EdgeInsets.all(5),
                                alignment: Alignment.center,
                                width: widget.size * 0.8,
                                height: widget.size * 0.8,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    color: widget.customBgColor),
                              )
                            ],
                          )
                        : widget.type == NDRadioType.custom
                            ? widget.activeIcon
                            : widget.inactiveIcon
                : widget.inactiveIcon));
  }
}
