import 'package:flutter/material.dart';

import '../../constants/colors/nd_color.dart';
import '../../constants/position/nd_position.dart';
import '../../constants/size/nd_size.dart';
import '../../constants/types/nd_checkbox_type.dart';
import '../checkbox/nd_checkbox.dart';
import '../list_tile/nd_list_tile.dart';

class NDCheckboxListTile extends StatelessWidget {
  const NDCheckboxListTile({
    Key? key,
    required this.value,
    required this.onChanged,
    this.titleText,
    this.subTitleText,
    this.color,
    this.avatar,
    this.title,
    this.subTitle,
    this.icon,
    this.description,
    this.listItemTextColor = NDColors.DARK,
    this.padding = const EdgeInsets.all(8),
    this.margin = const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    this.size = NDSize.MEDIUM,
    this.type = NDCheckboxType.basic,
    this.activeBgColor = NDColors.PRIMARY,
    this.inactiveBgColor = NDColors.WHITE,
    this.activeBorderColor = NDColors.WHITE,
    this.inactiveBorderColor = NDColors.DARK,
    this.activeIcon = const Icon(
      Icons.check,
      size: 20,
      color: NDColors.WHITE,
    ),
    this.inactiveIcon,
    this.customBgColor = NDColors.SUCCESS,
    this.position = NDPosition.end,
    this.selected = false,
    this.autofocus = false,
  }) : super(key: key);

  final String? titleText;

  final String? subTitleText;

  final Color? color;

  final Widget? avatar;

  final Widget? title;

  final Widget? subTitle;

  final Widget? description;

  final EdgeInsets margin;

  final EdgeInsets padding;

  final NDCheckboxType type;

  final double size;

  final Color activeBgColor;

  final Color inactiveBgColor;

  final Color activeBorderColor;

  final Color inactiveBorderColor;

  final Color? listItemTextColor;

  final ValueChanged<bool>? onChanged;

  final bool value;

  final NDPosition position;

  final Widget activeIcon;

  final Widget? inactiveIcon;

  final Color customBgColor;

  final bool selected;

  final bool autofocus;

  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final NDCheckbox checkbox = NDCheckbox(
        autofocus: autofocus,
        onChanged: onChanged,
        value: value,
        size: size,
        activeBgColor: activeBgColor,
        inactiveIcon: inactiveIcon,
        activeBorderColor: activeBorderColor,
        inactiveBgColor: inactiveBgColor,
        activeIcon: activeIcon,
        inactiveBorderColor: inactiveBorderColor,
        customBgColor: customBgColor,
        type: type);
    return MergeSemantics(
      child: NDListTile(
        autofocus: autofocus,
        enabled: onChanged != null,
        onTap: onChanged != null
            ? () {
                onChanged!(!value);
              }
            : null,
        selected: selected,
        avatar: position == NDPosition.start ? checkbox : avatar,
        titleText: titleText,
        subTitle: subTitle,
        subTitleText: subTitleText,
        description: description,
        color: color,
        padding: padding,
        margin: margin,
        title: title,
        listItemTextColor: listItemTextColor,
        icon: position == NDPosition.end ? checkbox : icon,
      ),
    );
  }
}
