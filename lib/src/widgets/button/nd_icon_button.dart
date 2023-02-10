import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../constants/colors/nd_color.dart';
import '../../constants/shape/nd_icon_button_shape.dart';
import '../../constants/size/nd_size.dart';
import '../../constants/types/nd_button_type.dart';

class NDIconButton extends StatefulWidget {
  const NDIconButton({
    Key? key,
    this.iconSize = 0.0,
    this.padding = const EdgeInsets.all(8),
    this.alignment = Alignment.center,
    required this.icon,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    required this.onPressed,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.type = NDButtonType.solid,
    this.shape = NDIconButtonShape.standard,
    this.color = NDColors.PRIMARY,
    this.borderShape,
    this.boxShadow,
    this.size = NDSize.MEDIUM,
    this.buttonBoxShadow,
    this.borderSide,
  }) : super(key: key);

  final double iconSize;

  final EdgeInsetsGeometry padding;

  final AlignmentGeometry alignment;

  final Widget icon;

  final Color? focusColor;

  final Color? hoverColor;

  final NDButtonType type;

  final NDIconButtonShape shape;

  final Color color;

  final Color? splashColor;

  final Color? highlightColor;

  final Color? disabledColor;

  final VoidCallback? onPressed;

  final FocusNode? focusNode;

  final bool autofocus;

  final String? tooltip;

  final BoxShadow? boxShadow;

  final ShapeBorder? borderShape;

  final double size;

  final bool? buttonBoxShadow;

  final BorderSide? borderSide;

  @override
  _NDIconButtonState createState() => _NDIconButtonState();
}

class _NDIconButtonState extends State<NDIconButton> {
  late Color color;
  Function? onPressed;
  late NDButtonType type;
  late NDIconButtonShape shape;
  BoxShadow? boxShadow;
  double? height;
  double? width;
  double iconPixel = 18;

  @override
  void initState() {
    color = widget.color;
    onPressed = widget.onPressed;
    type = widget.type;
    shape = widget.shape;
    super.initState();
  }

  Color getBorderColor() {
    if (widget.onPressed != null) {
      return color;
    } else {
      if (widget.disabledColor != null) {
        return widget.disabledColor!;
      } else {
        return color.withOpacity(0.48);
      }
    }
  }

  Color? getDisabledFillColor() {
    if (widget.type == NDButtonType.transparent ||
        widget.type == NDButtonType.outline ||
        widget.type == NDButtonType.outline2x) {
      return Colors.transparent;
    }
    if (widget.disabledColor != null) {
      return widget.disabledColor;
    } else {
      return color.withOpacity(0.48);
    }
  }

  Color? getColor() {
    if (widget.type == NDButtonType.transparent ||
        widget.type == NDButtonType.outline ||
        widget.type == NDButtonType.outline2x) {
      return Colors.transparent;
    } else {
      return color;
    }
  }

  Color? getIconColor() {
    if (widget.type == NDButtonType.transparent ||
        widget.type == NDButtonType.outline ||
        widget.type == NDButtonType.outline2x) {
      return widget.onPressed != null
          ? color == NDColors.TRANSPARENT
              ? NDColors.DARK
              : color
          : color.withOpacity(0.48);
    } else if (color == NDColors.TRANSPARENT) {
      return widget.onPressed != null ? NDColors.DARK : NDColors.WHITE;
    } else {
      return NDColors.WHITE;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    final Color themeColor =
        Theme.of(context).colorScheme.onSurface.withOpacity(0.12);
    final BorderSide outlineBorder = BorderSide(
      color: widget.borderSide == null
          ? getBorderColor()
          : widget.borderSide!.color,
      width: (widget.borderSide?.width == null
          ? widget.type == NDButtonType.outline2x
              ? 2.0
              : 1.0
          : widget.borderSide?.width)!,
    );

    final BorderSide shapeBorder = widget.type == NDButtonType.outline ||
            widget.type == NDButtonType.outline2x
        ? outlineBorder
        : widget.borderSide ??
            BorderSide(
              color: color,
              width: 0,
            );

    ShapeBorder? shapeBorderType;

    if (shape == NDIconButtonShape.pills) {
      shapeBorderType = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: shapeBorder,
      );
    } else if (shape == NDIconButtonShape.square) {
      shapeBorderType = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: shapeBorder,
      );
    } else if (shape == NDIconButtonShape.standard) {
      shapeBorderType = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
        side: shapeBorder,
      );
    } else if (shape == NDIconButtonShape.circle) {
      shapeBorderType = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: shapeBorder,
      );
    }

    if (widget.size == NDSize.SMALL) {
      height = 30.0;
      width = 30.0;
      iconPixel = 18.0;
    } else if (widget.size == NDSize.MEDIUM) {
      height = 35.0;
      width = 35.0;
      iconPixel = 28.0;
    } else if (widget.size == NDSize.LARGE) {
      height = 40.0;
      width = 40.0;
      iconPixel = 38.0;
    }

    Widget result = Container(
      padding: widget.padding,
      child: SizedBox(
        height: widget.iconSize != 0 ? widget.iconSize : iconPixel,
        width: widget.iconSize != 0 ? widget.iconSize : iconPixel,
        child: Align(
          alignment: Alignment.center,
          child: IconTheme.merge(
            data: IconThemeData(
              size: widget.iconSize > 0.0 ? widget.iconSize : iconPixel,
              color: getIconColor(),
            ),
            child: widget.icon,
          ),
        ),
      ),
    );

    if (widget.tooltip != null) {
      result = Tooltip(
        message: widget.tooltip!,
        child: result,
      );
    }

    BoxDecoration? getBoxShadow() {
      if (widget.type != NDButtonType.transparent) {
        if (widget.boxShadow == null && widget.buttonBoxShadow != true) {
          return null;
        } else {
          return BoxDecoration(
              color: widget.onPressed != null
                  ? getColor()
                  : getDisabledFillColor(),
              borderRadius: widget.shape == NDIconButtonShape.circle
                  ? BorderRadius.circular(50)
                  : widget.shape == NDIconButtonShape.standard
                      ? BorderRadius.circular(3)
                      : widget.shape == NDIconButtonShape.pills
                          ? BorderRadius.circular(20)
                          : BorderRadius.zero,
              boxShadow: [
                widget.boxShadow == null && widget.buttonBoxShadow == true
                    ? BoxShadow(
                        color: themeColor,
                        blurRadius: 1.5,
                        spreadRadius: 2,
                        offset: Offset.zero,
                      )
                    : widget.boxShadow ??
                        BoxShadow(
                          color: Theme.of(context).canvasColor,
                          blurRadius: 0,
                          spreadRadius: 0,
                          offset: Offset.zero,
                        )
              ]);
        }
      }
      return null;
    }

    return Semantics(
      button: true,
      enabled: widget.onPressed != null,
      child: Focus(
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        child: Container(
          decoration: widget.type == NDButtonType.solid ? getBoxShadow() : null,
          child: Material(
            shape: widget.type == NDButtonType.transparent
                ? null
                : widget.borderShape ?? shapeBorderType,
            color:
                widget.onPressed != null ? getColor() : getDisabledFillColor(),
            type: widget.type == NDButtonType.transparent
                ? MaterialType.transparency
                : MaterialType.button,
            child: InkResponse(
              onTap: widget.onPressed,
              child: result,
              focusColor: widget.focusColor ?? Theme.of(context).focusColor,
              hoverColor: widget.hoverColor ?? Theme.of(context).hoverColor,
              highlightColor:
                  widget.highlightColor ?? Theme.of(context).highlightColor,
              splashColor: widget.splashColor ?? Theme.of(context).splashColor,
              radius: math.max(
                  Material.defaultSplashRadius,
                  (widget.iconSize > 0.0
                          ? widget.iconSize
                          : iconPixel +
                              math.min(
                                widget.padding.horizontal,
                                widget.padding.vertical,
                              )) *
                      0.7),
            ),
          ),
        ),
      ),
    );
  }
}
