import 'package:flutter/material.dart';

import '../../constants/types/nd_typography_type.dart';

class NDTypography extends StatelessWidget {
  const NDTypography({
    Key? key,
    this.type = NDTypographyType.typo4,
    this.child,
    this.text,
    this.icon,
    this.dividerBorderRadius,
    this.textColor,
    this.dividerAlignment,
    this.dividerColor,
    this.showDivider = true,
    this.dividerWidth,
    this.dividerHeight,
    this.backgroundImage,
    this.backgroundImagecolorFilter,
    this.fontWeight = FontWeight.w500,
  })  : assert(text != null || child != null),
        super(key: key);

  final Widget? child;

  final String? text;

  final Widget? icon;

  final Color? dividerColor;

  final Color? textColor;

  final BorderRadius? dividerBorderRadius;

  final Alignment? dividerAlignment;

  final bool showDivider;

  final double? dividerWidth;

  final double? dividerHeight;

  final ImageProvider? backgroundImage;

  final ColorFilter? backgroundImagecolorFilter;

  final NDTypographyType type;

  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    double? fontSize;

    if (type == NDTypographyType.typo1) {
      fontSize = 25.0;
    } else if (type == NDTypographyType.typo2) {
      fontSize = 22.0;
    } else if (type == NDTypographyType.typo3) {
      fontSize = 19.0;
    } else if (type == NDTypographyType.typo4) {
      fontSize = 17.0;
    } else if (type == NDTypographyType.typo5) {
      fontSize = 15.0;
    } else if (type == NDTypographyType.typo6) {
      fontSize = 13.0;
    }

    return Container(
      padding: EdgeInsets.all(backgroundImage != null ? 10 : 0),
      decoration: BoxDecoration(
        image: backgroundImage != null
            ? DecorationImage(
                image: backgroundImage!,
                fit: BoxFit.cover,
                colorFilter: backgroundImagecolorFilter ??
                    const ColorFilter.mode(Colors.black54, BlendMode.darken),
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              icon ?? Container(),
              icon != null
                  ? const Padding(padding: EdgeInsets.only(left: 10))
                  : Container(),
              text != null
                  ? Expanded(
                      child: Text(
                        text!,
                        style: TextStyle(
                          color: textColor ??
                              (backgroundImage != null
                                  ? Colors.white
                                  : Colors.black),
                          fontSize: fontSize,
                          letterSpacing: 0.3,
                          fontWeight: fontWeight,
                        ),
                      ),
                    )
                  : child!
            ],
          ),
          showDivider && fontSize != null
              ? Container(
                  margin: const EdgeInsets.only(top: 3, bottom: 3),
                  alignment: dividerAlignment,
                  child: Container(
                    width: dividerWidth ?? 70,
                    height: dividerHeight ?? (fontSize / 5),
                    decoration: BoxDecoration(
                      color: dividerColor ??
                          (backgroundImage != null
                              ? Colors.white
                              : Colors.black),
                      borderRadius: dividerBorderRadius ??
                          const BorderRadius.all(
                            Radius.circular(5),
                          ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
