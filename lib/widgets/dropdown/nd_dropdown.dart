import 'package:flutter/material.dart';

import '../../constants/colors/nd_color.dart';

class NDDropdown<T> extends StatefulWidget {
  const NDDropdown(
      {Key? key,
      required this.items,
      this.icon,
      this.selectedItemBuilder,
      this.value,
      this.hint,
      this.disabledHint,
      required this.onChanged,
      this.onTap,
      this.elevation = 8,
      this.style,
      this.underline,
      this.iconDisabledColor,
      this.iconEnabledColor,
      this.iconSize = 24.0,
      this.isDense = true,
      this.isExpanded = false,
      this.itemHeight = 40,
      this.focusColor,
      this.focusNode,
      this.autofocus = false,
      this.dropdownColor,
      this.padding = const EdgeInsets.all(5),
      this.borderRadius = const BorderRadius.all(Radius.circular(4)),
      this.border = const BorderSide(
          color: Colors.transparent, width: 1, style: BorderStyle.solid),
      this.dropdownButtonColor = NDColors.WHITE})
      : super(key: key);

  final DropdownButtonBuilder? selectedItemBuilder;
  final List<DropdownMenuItem<T>>? items;

  final Widget? icon;

  final int elevation;

  final T? value;

  final BorderSide border;

  final EdgeInsets padding;

  final Widget? hint;

  final Widget? disabledHint;

  final ValueChanged<T?>? onChanged;

  final VoidCallback? onTap;

  final TextStyle? style;

  final Widget? underline;

  final Color? iconDisabledColor;

  final Color? iconEnabledColor;

  final double iconSize;

  final bool isDense;

  final bool isExpanded;

  final double? itemHeight;

  final Color? focusColor;

  final FocusNode? focusNode;

  final bool autofocus;

  final Color? dropdownColor;

  final BorderRadius borderRadius;

  final dynamic dropdownButtonColor;

  @override
  State<NDDropdown<T>> createState() => _NDDropdownState<T>();
}

class _NDDropdownState<T> extends State<NDDropdown<T>> {
  @override
  Widget build(BuildContext context) => Material(
        color: widget.dropdownButtonColor,
        shape: RoundedRectangleBorder(
          side: widget.border,
          borderRadius: widget.borderRadius,
        ),
        child: Container(
          height: widget.itemHeight,
          padding: widget.padding,
          child: DropdownButton(
            items: widget.items,
            selectedItemBuilder: widget.selectedItemBuilder,
            value: widget.value,
            hint: widget.hint,
            disabledHint: widget.disabledHint,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            elevation: widget.elevation,
            style: widget.style,
            icon: widget.icon,
            iconDisabledColor: widget.iconDisabledColor,
            iconEnabledColor: widget.iconEnabledColor,
            iconSize: widget.iconSize,
            isDense: widget.isDense,
            isExpanded: widget.isExpanded,
            focusColor: widget.focusColor,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            dropdownColor: widget.dropdownColor,
          ),
        ),
      );
}
