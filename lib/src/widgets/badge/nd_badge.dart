import 'package:flutter/material.dart';

import '../../constants/colors/nd_color.dart';
import '../../constants/shape/nd_badge_shape.dart';
import '../../constants/size/nd_size.dart';

class NDBadge extends StatefulWidget {
  const NDBadge({
    Key? key,
    this.textStyle,
    this.borderShape,
    this.shape = NDBadgeShape.standard,
    this.color = NDColors.DANGER,
    this.textColor = NDColors.WHITE,
    this.size = NDSize.SMALL,
    this.border,
    this.text,
    this.child,
  }) : super(key: key);

  final BorderSide? border;

  final ShapeBorder? borderShape;

  final NDBadgeShape shape;

  final Color color;

  final double size;

  final Widget? child;

  final String? text;

  final TextStyle? textStyle;

  final Color textColor;

  @override
  _NDBadgeState createState() => _NDBadgeState();
}

class _NDBadgeState extends State<NDBadge> {
  late Color color;
  late Color textColor;
  Widget? child;
  NDBadgeShape? counterShape;
  late double size;
  double? height;
  double? width;
  double? fontSize;

  @override
  void initState() {
    color = widget.color;
    textColor = widget.textColor;
    child = widget.text != null ? Text(widget.text ?? '') : widget.child;
    counterShape = widget.shape;
    size = widget.size;
    super.initState();
  }

  @override
  void didUpdateWidget(NDBadge oldWidget) {
    color = widget.color;
    textColor = widget.textColor;
    child = widget.text != null ? Text(widget.text ?? '') : widget.child;
    counterShape = widget.shape;
    size = widget.size;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final BorderSide shapeBorder = widget.border != null
        ? widget.border!
        : BorderSide(
            color: color,
            width: 0,
          );

    ShapeBorder shape;

    if (counterShape == NDBadgeShape.pills) {
      shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: shapeBorder,
      );
    } else if (counterShape == NDBadgeShape.square) {
      shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: shapeBorder,
      );
    } else if (counterShape == NDBadgeShape.standard) {
      shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: shapeBorder,
      );
    } else if (counterShape == NDBadgeShape.circle) {
      shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: shapeBorder,
      );
    } else {
      shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: shapeBorder,
      );
    }

    if (widget.size == NDSize.SMALL) {
      height = size * 0.56;
      width = size * 0.73;
      fontSize = size * 0.31;
    } else if (widget.size == NDSize.MEDIUM) {
      height = size * 0.58;
      width = size * 0.76;
      fontSize = size * 0.34;
    } else if (widget.size == NDSize.LARGE) {
      height = size * 0.6;
      width = size * 0.79;
      fontSize = size * 0.37;
    } else {
      height = size * 0.58;
      width = size * 0.76;
      fontSize = size * 0.34;
    }

    return Container(
      height: height,
      width: counterShape == NDBadgeShape.circle ? height : width,
      child: Material(
        textStyle: TextStyle(
          color: textColor,
          fontSize: fontSize,
        ),
        shape: widget.borderShape ?? shape,
        color: color,
        type: MaterialType.button,
        child: Container(
          child: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: child,
          ),
        ),
      ),
    );
  }
}
