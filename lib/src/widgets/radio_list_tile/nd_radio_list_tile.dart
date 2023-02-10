import 'package:flutter/material.dart';

import '../../constants/colors/nd_color.dart';
import '../../constants/position/nd_position.dart';
import '../../constants/size/nd_size.dart';
import '../../constants/types/nd_radio_type.dart';
import '../list_tile/nd_list_tile.dart';
import '../radio/nd_radio.dart';

class NDRadioListTile<T> extends StatelessWidget {
  const NDRadioListTile({
    Key? key,
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
    this.position = NDPosition.end,
    this.activeIcon = const Icon(
      Icons.check,
      size: 20,
      color: NDColors.DARK,
    ),
    this.inactiveIcon,
    this.customBgColor = NDColors.SUCCESS,
    this.autofocus = false,
    this.focusNode,
    this.toggleable = false,
    this.titleText,
    this.subTitleText,
    this.color,
    this.avatar,
    this.title,
    this.subTitle,
    this.description,
    this.icon,
    this.padding = const EdgeInsets.all(8),
    this.margin = const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.focusColor,
    this.hoverColor,
  }) : super(key: key);

  final String? titleText;

  final String? subTitleText;

  final Color? color;

  final Widget? avatar;

  final Widget? title;

  final Widget? subTitle;

  final Widget? description;

  final Widget? icon;

  final EdgeInsets margin;

  final EdgeInsets padding;

  final bool enabled;

  final GestureTapCallback? onTap;

  final NDPosition position;

  final GestureLongPressCallback? onLongPress;

  final bool selected;

  final Color? focusColor;

  final Color? hoverColor;

  final bool autofocus;

  final FocusNode? focusNode;

  final NDRadioType type;

  final double size;

  final Color radioColor;

  final Color activeBgColor;

  final Color inactiveBgColor;

  final Color activeBorderColor;

  final Color inactiveBorderColor;

  final ValueChanged<dynamic>? onChanged;

  final Widget activeIcon;

  final Widget? inactiveIcon;

  final Color customBgColor;

  final T value;

  final T groupValue;

  final bool toggleable;

  bool get checked => value == groupValue;

  @override
  Widget build(BuildContext context) {
    final NDRadio radio = NDRadio(
      onChanged: onChanged,
      value: value,
      groupValue: groupValue,
      size: size,
      type: type,
      radioColor: radioColor,
      activeBgColor: activeBgColor,
      inactiveIcon: inactiveIcon,
      activeBorderColor: activeBorderColor,
      inactiveBgColor: inactiveBgColor,
      activeIcon: activeIcon,
      inactiveBorderColor: inactiveBorderColor,
      customBgColor: customBgColor,
      toggleable: toggleable,
    );
    return MergeSemantics(
      child: NDListTile(
        autofocus: autofocus,
        enabled: onChanged != null,
        focusNode: focusNode,
        onTap: onChanged != null
            ? () {
                if (toggleable && checked) {
                  onChanged!(null);
                  return;
                }
                if (!checked) {
                  onChanged!(value);
                }
              }
            : null,
        selected: selected,
        avatar: position == NDPosition.start ? radio : avatar,
        titleText: titleText,
        subTitle: subTitle,
        subTitleText: subTitleText,
        description: description,
        color: color,
        padding: padding,
        margin: margin,
        title: title,
        icon: position == NDPosition.end ? radio : icon,
      ),
    );
  }
}
