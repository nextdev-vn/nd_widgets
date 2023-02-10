import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../constants/colors/nd_color.dart';
import '../../constants/position/nd_position.dart';
import '../../constants/shape/nd_button_shape.dart';
import '../../constants/size/nd_size.dart';
import '../../constants/types/nd_button_type.dart';

class NDButton extends StatefulWidget {
  const NDButton({
    Key? key,
    required this.onPressed,
    this.onHighlightChanged,
    this.textStyle,
    this.boxShadow,
    this.buttonBoxShadow,
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
    this.child,
    this.type = NDButtonType.solid,
    this.shape = NDButtonShape.standard,
    this.color = NDColors.PRIMARY,
    this.textColor,
    this.position = NDPosition.start,
    this.size = NDSize.MEDIUM,
    this.borderSide,
    this.text,
    this.icon,
    this.blockButton,
    this.fullWidthButton,
    this.colorScheme,
    this.enableFeedback,
    this.onLongPress,
    this.disabledColor,
    this.disabledTextColor,
  })  : materialTapTargetSize =
            materialTapTargetSize ?? MaterialTapTargetSize.padded,
        assert(focusElevation >= 0.0),
        assert(hoverElevation >= 0.0),
        assert(highlightElevation >= 0.0),
        assert(disabledElevation >= 0.0),
        super(key: key);

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

  final Widget? child;

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

  final Widget? icon;

  final NDPosition position;

  final bool? blockButton;

  final bool? fullWidthButton;

  final bool? buttonBoxShadow;

  final ColorScheme? colorScheme;

  final bool? enableFeedback;

  final VoidCallback? onLongPress;

  @override
  _NDButtonState createState() => _NDButtonState();
}

class _NDButtonState extends State<NDButton> {
  late Color color;
  Color? textColor;
  Color? disabledColor;
  Color? disabledTextColor;
  Widget? child;
  Widget? icon;
  Function? onPressed;
  late NDButtonType type;
  late NDButtonShape shape;
  late double size;
  late NDPosition position;
  late BoxShadow boxShadow;

  final Set<MaterialState> _states = <MaterialState>{};

  @override
  void initState() {
    color = widget.color;
    textColor = widget.textColor;
    child = widget.text != null ? Text(widget.text!) : widget.child;
    icon = widget.icon;
    onPressed = widget.onPressed;
    type = widget.type;
    shape = widget.shape;
    size = widget.size;
    position = widget.position;
    disabledColor = widget.disabledColor;
    disabledTextColor = widget.disabledTextColor;
    _updateState(
      MaterialState.disabled,
      !widget.enabled,
    );
    super.initState();
  }

  bool get _hovered => _states.contains(MaterialState.hovered);
  bool get _focused => _states.contains(MaterialState.focused);
  bool get _pressed => _states.contains(MaterialState.pressed);
  bool get _disabled => _states.contains(MaterialState.disabled);

  double? buttonWidth() {
    double? buttonWidth = 0;
    if (widget.blockButton == true) {
      buttonWidth = MediaQuery.of(context).size.width * 0.88;
    } else if (widget.fullWidthButton == true) {
      buttonWidth = MediaQuery.of(context).size.width;
    } else {
      buttonWidth = null;
    }
    return buttonWidth;
  }

  void _updateState(MaterialState state, bool value) {
    value ? _states.add(state) : _states.remove(state);
  }

  void _handleHighlightChanged(bool value) {
    if (_pressed != value) {
      setState(() {
        _updateState(MaterialState.pressed, value);
        if (widget.onHighlightChanged != null) {
          widget.onHighlightChanged!(value);
        }
      });
    }
  }

  void _handleHoveredChanged(bool value) {
    if (_hovered != value) {
      setState(() {
        _updateState(MaterialState.hovered, value);
      });
    }
  }

  void _handleFocusedChanged(bool value) {
    if (_focused != value) {
      setState(() {
        _updateState(MaterialState.focused, value);
      });
    }
  }

  @override
  void didUpdateWidget(NDButton oldWidget) {
    _updateState(MaterialState.disabled, !widget.enabled);

    if (_disabled && _pressed) {
      _handleHighlightChanged(false);
    }
    color = widget.color;
    textColor = widget.textColor;
    child = widget.text != null ? Text(widget.text!) : widget.child;
    icon = widget.icon;
    onPressed = widget.onPressed;
    type = widget.type;
    shape = widget.shape;
    size = widget.size;
    position = widget.position;
    disabledColor = widget.disabledColor;
    disabledTextColor = widget.disabledTextColor;
    _updateState(
      MaterialState.disabled,
      !widget.enabled,
    );
    super.didUpdateWidget(oldWidget);
  }

  double get _effectiveElevation {
    if (_disabled) {
      return widget.disabledElevation;
    }
    if (_pressed) {
      return widget.highlightElevation;
    }
    if (_hovered) {
      return widget.hoverElevation;
    }
    if (_focused) {
      return widget.focusElevation;
    }
    return widget.elevation;
  }

  @override
  Widget build(BuildContext context) {
    ShapeBorder shapeBorderType;

    Color getBorderColor() {
      if (widget.enabled) {
        final Color fillColor = color;
        return fillColor;
      } else {
        if (disabledColor != null) {
          return disabledColor!;
        } else {
          return color.withOpacity(0.48);
        }
      }
    }

    Color getDisabledFillColor() {
      if (widget.type == NDButtonType.transparent ||
          widget.type == NDButtonType.outline ||
          widget.type == NDButtonType.outline2x) {
        return Colors.transparent;
      }
      if (disabledColor != null) {
        return disabledColor!;
      } else {
        return color.withOpacity(0.48);
      }
    }

    Color getColor() {
      if (widget.type == NDButtonType.transparent ||
          widget.type == NDButtonType.outline ||
          widget.type == NDButtonType.outline2x) {
        return Colors.transparent;
      }
      final Color fillColor = color;
      return fillColor;
    }

    Color getDisabledTextColor() {
      if (disabledTextColor != null) {
        return disabledTextColor!;
      } else if (widget.type == NDButtonType.outline ||
          widget.type == NDButtonType.outline2x ||
          widget.type == NDButtonType.transparent) {
        return color;
      } else {
        return NDColors.DARK;
      }
    }

    Color getTextColor() {
      if (widget.type == NDButtonType.outline ||
          widget.type == NDButtonType.outline2x ||
          widget.type == NDButtonType.transparent) {
        return widget.enabled
            ? textColor == null
                ? color == NDColors.TRANSPARENT
                    ? NDColors.DARK
                    : color
                : textColor!
            : getDisabledTextColor();
      }
      if (textColor == null) {
        if (color == NDColors.TRANSPARENT) {
          return NDColors.DARK;
        } else {
          return NDColors.WHITE;
        }
      } else {
        return textColor!;
      }
    }

    final Color? effectiveTextColor = MaterialStateProperty.resolveAs<Color?>(
        widget.textStyle?.color, _states);
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

    Size minSize;
    switch (widget.materialTapTargetSize) {
      case MaterialTapTargetSize.padded:
        minSize = const Size(48, 48);
        break;
      case MaterialTapTargetSize.shrinkWrap:
        minSize = Size.zero;
        break;
      default:
        minSize = Size.zero;
        break;
    }

    final BorderSide shapeBorder = widget.type == NDButtonType.outline ||
            widget.type == NDButtonType.outline2x
        ? outlineBorder
        : widget.borderSide ??
            BorderSide(
              color: getBorderColor(),
              width: 0,
            );

    if (shape == NDButtonShape.pills) {
      shapeBorderType = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          50,
        ),
        side: shapeBorder,
      );
    } else if (shape == NDButtonShape.square) {
      shapeBorderType = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: shapeBorder,
      );
    } else if (shape == NDButtonShape.standard) {
      shapeBorderType = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
        side: shapeBorder,
      );
    } else {
      shapeBorderType = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: shapeBorder,
      );
    }

    BoxDecoration? getBoxShadow() {
      if (widget.type != NDButtonType.transparent) {
        if (widget.boxShadow == null && widget.buttonBoxShadow != true) {
          return null;
        } else {
          return BoxDecoration(
            color: widget.type == NDButtonType.transparent ||
                    widget.type == NDButtonType.outline ||
                    widget.type == NDButtonType.outline2x
                ? Colors.transparent
                : color,
            borderRadius: widget.shape == NDButtonShape.pills
                ? BorderRadius.circular(50)
                : widget.shape == NDButtonShape.standard
                    ? BorderRadius.circular(5)
                    : BorderRadius.zero,
            boxShadow: [
              widget.boxShadow == null && widget.buttonBoxShadow == true
                  ? BoxShadow(
                      color: themeColor,
                      blurRadius: 1.5,
                      spreadRadius: 2,
                      offset: Offset.zero,
                    )
                  : widget.boxShadow != null
                      ? widget.boxShadow!
                      : BoxShadow(
                          color: Theme.of(context).canvasColor,
                          blurRadius: 0,
                          spreadRadius: 0,
                          offset: Offset.zero,
                        ),
            ],
          );
        }
      }
      return null;
    }

    TextStyle getTextStyle() {
      if (widget.size == NDSize.SMALL) {
        return TextStyle(
          color: widget.enabled ? getTextColor() : getDisabledTextColor(),
          fontSize: 12,
        );
      } else if (widget.size == NDSize.MEDIUM) {
        return TextStyle(
          color: widget.enabled ? getTextColor() : getDisabledTextColor(),
          fontSize: 13,
          fontWeight: FontWeight.w400,
        );
      } else if (widget.size == NDSize.LARGE) {
        return TextStyle(
          color: widget.enabled ? getTextColor() : getDisabledTextColor(),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        );
      }
      return TextStyle(
        color: widget.enabled ? getTextColor() : getDisabledTextColor(),
        fontSize: 13,
        fontWeight: FontWeight.w400,
      );
    }

    final Widget result = Container(
      constraints: icon == null
          ? const BoxConstraints(minWidth: 80)
          : const BoxConstraints(minWidth: 90),
      decoration: widget.type == NDButtonType.solid ? getBoxShadow() : null,
      child: Material(
        elevation: _effectiveElevation,
        textStyle: widget.textStyle == null ? getTextStyle() : widget.textStyle,
        shape: widget.type == NDButtonType.transparent
            ? null
            : widget.borderShape ?? shapeBorderType,
        color: widget.enabled ? getColor() : getDisabledFillColor(),
        type: MaterialType.button,
        animationDuration: widget.animationDuration,
        clipBehavior: widget.clipBehavior,
        child: InkWell(
          focusNode: widget.focusNode,
          canRequestFocus: widget.enabled,
          onFocusChange: _handleFocusedChanged,
          autofocus: widget.autofocus,
          onHighlightChanged: _handleHighlightChanged,
          onHover: _handleHoveredChanged,
          onTap: widget.onPressed,
          onLongPress: widget.onLongPress,
          enableFeedback: widget.enableFeedback,
          splashColor: widget.splashColor,
          highlightColor: widget.highlightColor,
          focusColor: widget.focusColor,
          hoverColor: widget.hoverColor,
          customBorder: widget.type == NDButtonType.transparent
              ? null
              : widget.borderShape ?? shapeBorderType,
          child: IconTheme.merge(
            data: IconThemeData(color: effectiveTextColor),
            child: Container(
              height: size,
              width: buttonWidth(),
              padding: widget.padding,
              child: Center(
                widthFactor: 1,
                heightFactor: 1,
                child: icon != null &&
                        child != null &&
                        (position == NDPosition.start)
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          icon!,
                          const SizedBox(width: 8),
                          child!
                        ],
                      )
                    : icon != null &&
                            child != null &&
                            (position == NDPosition.end)
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              child!,
                              const SizedBox(width: 8),
                              icon!
                            ],
                          )
                        : child,
              ),
            ),
          ),
        ),
      ),
    );

    return Semantics(
      container: true,
      button: true,
      enabled: widget.enabled,
      child: _InputPadding(
        minSize: minSize,
        child: Focus(
          focusNode: widget.focusNode,
          onFocusChange: _handleFocusedChanged,
          autofocus: widget.autofocus,
          child: result,
        ),
      ),
    );
  }
}

class _InputPadding extends SingleChildRenderObjectWidget {
  const _InputPadding({
    Key? key,
    Widget? child,
    this.minSize,
  }) : super(
          key: key,
          child: child,
        );

  final Size? minSize;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderInputPadding(minSize);

  @override
  void updateRenderObject(
      BuildContext context, covariant _RenderInputPadding renderObject) {
    renderObject.minSize = minSize;
  }
}

class _RenderInputPadding extends RenderShiftedBox {
  _RenderInputPadding(this._minSize, [RenderBox? child]) : super(child);

  Size? get minSize => _minSize;
  Size? _minSize;

  set minSize(Size? value) {
    _minSize = value;
    markNeedsLayout();
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (child != null && minSize != null) {
      return math.max(child!.getMinIntrinsicWidth(height), minSize!.width);
    }
    return 0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (child != null && minSize != null) {
      return math.max(child!.getMinIntrinsicHeight(width), minSize!.height);
    }
    return 0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (child != null && minSize != null) {
      return math.max(child!.getMaxIntrinsicWidth(height), minSize!.width);
    }
    return 0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (child != null && minSize != null) {
      return math.max(child!.getMaxIntrinsicHeight(width), minSize!.height);
    }
    return 0;
  }

  @override
  void performLayout() {
    if (child != null && minSize != null) {
      child!.layout(constraints, parentUsesSize: true);

      final BoxParentData childParentData = child!.parentData as BoxParentData;
      final double height = math.max(child!.size.width, minSize!.width);
      final double width = math.max(child!.size.height, minSize!.height);
      size = constraints.constrain(Size(height, width));
      childParentData.offset =
          Alignment.center.alongOffset(size - child!.size as Offset);
    } else {
      size = Size.zero;
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (super.hitTest(result, position: position)) {
      return true;
    }

    if (child != null) {
      final Offset center = child!.size.center(Offset.zero);
      return result.addWithRawTransform(
        transform: MatrixUtils.forceToPoint(center),
        position: center,
        hitTest: (BoxHitTestResult result, Offset position) {
          assert(position == center);
          return child!.hitTest(
            result,
            position: center,
          );
        },
      );
    }

    throw Exception('child property cannot be null');
  }
}
