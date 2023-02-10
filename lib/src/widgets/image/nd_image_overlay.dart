import 'package:flutter/material.dart';

class NDImageOverlay extends StatelessWidget {
  const NDImageOverlay({
    Key? key,
    this.height,
    this.width,
    this.color,
    this.padding,
    this.margin,
    this.image,
    this.child = const Text(''),
    this.alignment,
    this.borderRadius,
    this.colorFilter =
        const ColorFilter.mode(Colors.black26, BlendMode.colorBurn),
    this.boxFit = BoxFit.fill,
    this.border,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);

  final double? height;

  final double? width;

  final Color? color;

  final EdgeInsetsGeometry? margin;

  final EdgeInsetsGeometry? padding;

  final ImageProvider? image;

  final Widget child;

  final AlignmentGeometry? alignment;

  final BoxFit? boxFit;

  final ColorFilter? colorFilter;

  final BorderRadiusGeometry? borderRadius;

  final Border? border;

  final BoxShape shape;

  @override
  Widget build(BuildContext context) => Container(
        alignment: alignment,
        height: height,
        width: width ?? MediaQuery.of(context).size.width,
        margin: margin,
        padding: padding,
        child: child,
        decoration: BoxDecoration(
          shape: shape,
          borderRadius: borderRadius,
          border: border,
          color: color,
          image: DecorationImage(
            fit: boxFit,
            colorFilter: colorFilter,
            image: image!,
          ),
        ),
      );
}
