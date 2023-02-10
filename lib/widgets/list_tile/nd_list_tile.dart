import 'package:flutter/material.dart';

import '../../constants/colors/nd_color.dart';

class NDListTile extends StatelessWidget {
  const NDListTile({
    Key? key,
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
    this.listItemTextColor = NDColors.DARK,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.focusColor,
    this.hoverColor,
    this.focusNode,
    this.autofocus = false,
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

  final GestureLongPressCallback? onLongPress;

  final bool selected;

  final Color? focusColor;

  final Color? listItemTextColor;

  final Color? hoverColor;

  final FocusNode? focusNode;

  final bool autofocus;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: enabled ? onTap : null,
        onLongPress: enabled ? onLongPress : null,
        canRequestFocus: enabled,
        focusNode: focusNode,
        focusColor: focusColor,
        hoverColor: hoverColor,
        autofocus: autofocus,
        child: Semantics(
          selected: selected,
          enabled: enabled,
          child: Container(
            padding: padding,
            margin: margin,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                avatar ?? Container(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        titleText != null
                            ? Text(
                                titleText!,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: listItemTextColor),
                              )
                            : title ?? Container(),
                        subTitleText != null
                            ? Text(
                                subTitleText!,
                                style: const TextStyle(
                                  fontSize: 14.5,
                                  color: Colors.black54,
                                ),
                              )
                            : subTitle ?? Container(),
                        description ?? Container()
                      ],
                    ),
                  ),
                ),
                icon ?? Container(),
              ],
            ),
          ),
        ),
      );
}
