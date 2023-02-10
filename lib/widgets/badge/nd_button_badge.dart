import 'package:flutter/material.dart';

import '../../constants/colors/nd_color.dart';
import '../../constants/position/nd_position.dart';
import '../../constants/shape/nd_button_shape.dart';
import '../../constants/size/nd_size.dart';
import '../../constants/types/nd_button_type.dart';
import '../button/nd_button.dart';

class NDButtonBadge extends StatefulWidget {
  const NDButtonBadge({
    Key? key,
    required this.onPressed,
    this.onHighlightChanged,
    this.textStyle,
    this.boxShadow,
    this.badgeBoxShadow,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.elevation = 0.0,
    this.focusElevation = 4.0,
    this.hoverElevation = 4.0,
    this.highlightElevation = 1.0,
    this.disabledElevation = 0.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    this.constraints,
    this.borderShape,
    this.animationDuration = kThemeChangeDuration,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    MaterialTapTargetSize? materialTapTargetSize,
    this.type = NDButtonType.solid,
    this.shape = NDButtonShape.standard,
    this.color = NDColors.PRIMARY,
    this.textColor,
    this.position = NDPosition.end,
    this.size = NDSize.MEDIUM,
    this.borderSide,
    this.text,
    this.blockButton,
    this.fullWidthButton,
    this.colorScheme,
    this.enableFeedback,
    this.onLongPress,
    this.disabledColor,
    this.disabledTextColor,
    this.icon,
  })  : materialTapTargetSize =
            materialTapTargetSize ?? MaterialTapTargetSize.padded,
        assert(focusElevation >= 0.0),
        assert(hoverElevation >= 0.0),
        assert(highlightElevation >= 0.0),
        assert(disabledElevation >= 0.0),
        super(
          key: key,
        );

  final VoidCallback? onPressed;

  final ValueChanged<bool>? onHighlightChanged;

  final TextStyle? textStyle;

  final BorderSide? borderSide;

  final BoxShadow? boxShadow;

  final Color? focusColor;

  final Color? hoverColor;

  final Color? highlightColor;

  final Color? splashColor;

  final double elevation;

  final double hoverElevation;

  final double focusElevation;

  final double highlightElevation;

  final double disabledElevation;

  final EdgeInsetsGeometry padding;

  final BoxConstraints? constraints;

  final ShapeBorder? borderShape;

  final Duration animationDuration;

  bool get enabled => onPressed != null;

  final MaterialTapTargetSize materialTapTargetSize;

  final FocusNode? focusNode;

  final bool autofocus;

  final Clip clipBehavior;

  final NDButtonType type;

  final NDButtonShape shape;

  final Color color;

  final Color? disabledColor;

  final Color? textColor;

  final Color? disabledTextColor;

  final double size;

  final String? text;

  final NDPosition position;

  final bool? blockButton;

  final bool? fullWidthButton;

  final bool? badgeBoxShadow;

  final ColorScheme? colorScheme;

  final bool? enableFeedback;

  final VoidCallback? onLongPress;

  final Widget? icon;

  @override
  _NDButtonBadgeState createState() => _NDButtonBadgeState();
}

class _NDButtonBadgeState extends State<NDButtonBadge> {
  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 26,
          minWidth: 98,
        ),
        child: Container(
          height: widget.size,
          child: NDButton(
            onPressed: widget.onPressed,
            onHighlightChanged: widget.onHighlightChanged,
            textStyle: widget.textStyle,
            boxShadow: widget.boxShadow,
            buttonBoxShadow: widget.badgeBoxShadow,
            focusColor: widget.focusColor,
            hoverColor: widget.hoverColor,
            highlightColor: widget.highlightColor,
            splashColor: widget.splashColor,
            elevation: widget.elevation,
            focusElevation: widget.focusElevation,
            hoverElevation: widget.hoverElevation,
            highlightElevation: widget.highlightElevation,
            disabledElevation: widget.disabledElevation,
            constraints: widget.constraints,
            borderShape: widget.borderShape,
            animationDuration: widget.animationDuration,
            clipBehavior: widget.clipBehavior,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            type: widget.type,
            shape: widget.shape,
            color: widget.color,
            textColor: widget.textColor,
            position: widget.position,
            size: widget.size,
            borderSide: widget.borderSide,
            text: widget.text,
            icon: widget.icon,
            blockButton: widget.blockButton,
            fullWidthButton: widget.fullWidthButton,
            disabledColor: widget.disabledTextColor,
            disabledTextColor: widget.disabledColor,
          ),
        ),
      );
}
