import 'package:flutter/material.dart';

import '../../constants/colors/nd_color.dart';
import '../../constants/size/nd_size.dart';
import '../../constants/types/nd_checkbox_type.dart';

class NDCheckbox extends StatefulWidget {
  const NDCheckbox(
      {Key? key,
      this.size = NDSize.MEDIUM,
      this.type = NDCheckboxType.basic,
      this.activeBgColor = NDColors.PRIMARY,
      this.inactiveBgColor = NDColors.WHITE,
      this.activeBorderColor = NDColors.WHITE,
      this.inactiveBorderColor = NDColors.DARK,
      required this.onChanged,
      required this.value,
      this.activeIcon = const Icon(
        Icons.check,
        size: 20,
        color: NDColors.WHITE,
      ),
      this.inactiveIcon,
      this.customBgColor = NDColors.SUCCESS,
      this.autofocus = false,
      this.focusNode})
      : super(key: key);

  final NDCheckboxType type;

  final double size;

  final Color activeBgColor;

  final Color inactiveBgColor;

  final Color activeBorderColor;

  final Color inactiveBorderColor;

  final ValueChanged<bool>? onChanged;

  final bool value;

  final Widget activeIcon;

  final Widget? inactiveIcon;

  final Color customBgColor;

  final bool autofocus;

  final FocusNode? focusNode;

  @override
  _NDCheckboxState createState() => _NDCheckboxState();
}

class _NDCheckboxState extends State<NDCheckbox> {
  bool get enabled => widget.onChanged != null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FocusableActionDetector(
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        enabled: enabled,
        child: InkResponse(
          highlightShape: widget.type == NDCheckboxType.circle
              ? BoxShape.circle
              : BoxShape.rectangle,
          containedInkWell: widget.type != NDCheckboxType.circle,
          canRequestFocus: enabled,
          onTap: widget.onChanged != null
              ? () {
                  widget.onChanged!(!widget.value);
                }
              : null,
          child: Container(
            height: widget.size,
            width: widget.size,
            margin: widget.type != NDCheckboxType.circle
                ? const EdgeInsets.all(10)
                : EdgeInsets.zero,
            decoration: BoxDecoration(
                color: enabled
                    ? widget.value
                        ? widget.type == NDCheckboxType.custom
                            ? Colors.white
                            : widget.activeBgColor
                        : widget.inactiveBgColor
                    : Colors.grey,
                borderRadius: widget.type == NDCheckboxType.basic
                    ? BorderRadius.circular(3)
                    : widget.type == NDCheckboxType.circle
                        ? BorderRadius.circular(50)
                        : BorderRadius.zero,
                border: Border.all(
                    color: widget.value
                        ? widget.type == NDCheckboxType.custom
                            ? Colors.black87
                            : widget.activeBorderColor
                        : widget.inactiveBorderColor)),
            child: widget.value
                ? widget.type == NDCheckboxType.custom
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
                                shape: BoxShape.rectangle,
                                color: widget.customBgColor),
                          )
                        ],
                      )
                    : widget.activeIcon
                : widget.inactiveIcon,
          ),
        ),
      );
}
