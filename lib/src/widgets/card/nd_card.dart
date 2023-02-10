import 'package:flutter/material.dart';

import '../../constants/position/nd_position.dart';
import '../button/nd_button_bar.dart';
import '../image/nd_image_overlay.dart';
import '../list_tile/nd_list_tile.dart';

class NDCard extends StatelessWidget {
  const NDCard(
      {Key? key,
      this.color,
      this.elevation,
      this.shape,
      this.borderOnForeground = true,
      this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      this.margin,
      this.clipBehavior,
      this.semanticContainer,
      this.title,
      this.content,
      this.image,
      this.showImage = false,
      this.showOverlayImage = false,
      this.buttonBar,
      this.imageOverlay,
      this.titlePosition,
      this.borderRadius,
      this.border,
      this.boxFit,
      this.colorFilter,
      this.height,
      this.gradient})
      : assert(elevation == null || elevation >= 0.0),
        assert(
            color == null || gradient == null,
            'Cannot provide both a color and a decoration\n'
            'The color argument is just a shorthand for "decoration: new BoxDecoration(color: color)".'),
        super(key: key);

  final double? height;

  final NDPosition? titlePosition;

  final Color? color;

  final double? elevation;

  final ShapeBorder? shape;

  final bool borderOnForeground;

  final Clip? clipBehavior;

  final EdgeInsetsGeometry? margin;

  final EdgeInsetsGeometry padding;

  final bool? semanticContainer;

  final NDListTile? title;

  final Widget? content;

  final bool showImage;

  final bool showOverlayImage;

  final Image? image;

  final ImageProvider? imageOverlay;

  final NDButtonBar? buttonBar;

  final BoxFit? boxFit;

  final ColorFilter? colorFilter;

  final BorderRadiusGeometry? borderRadius;

  final Border? border;

  final LinearGradient? gradient;

  static const double _defaultElevation = 1;
  static const Clip _defaultClipBehavior = Clip.none;

  @override
  Widget build(BuildContext context) {
    final CardTheme cardTheme = CardTheme.of(context);

    final Widget cardChild = Padding(
      padding: padding,
      child: Column(
        children: <Widget>[
          titlePosition == NDPosition.start
              ? title ?? Container()
              : showImage != false
                  ? ClipRRect(
                      borderRadius: borderRadius as BorderRadius? ??
                          const BorderRadius.vertical(top: Radius.circular(4)),
                      child: image,
                    )
                  : Container(),
          titlePosition == NDPosition.start
              ? showImage != false
                  ? Container(child: image)
                  : Container()
              : title ?? Container(),
          Padding(
            padding: padding,
            child: content ?? Container(),
          ),
          buttonBar ?? Container(),
        ],
      ),
    );

    final Widget overlayImage = NDImageOverlay(
      width: MediaQuery.of(context).size.width,
      child: cardChild,
      color: color ?? cardTheme.color ?? Theme.of(context).cardColor,
      image: imageOverlay,
      boxFit: boxFit,
      colorFilter: colorFilter,
      border: border,
      borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(4)),
    );

    return Container(
      height: height,
      margin: margin ?? cardTheme.margin ?? const EdgeInsets.all(16),
      decoration: gradient != null
          ? BoxDecoration(
              gradient: gradient,
              borderRadius:
                  borderRadius ?? const BorderRadius.all(Radius.circular(4)),
            )
          : null,
      child: gradient == null
          ? Material(
              type: MaterialType.card,
              color: color ?? cardTheme.color ?? Theme.of(context).cardColor,
              elevation: elevation ?? cardTheme.elevation ?? _defaultElevation,
              shape: shape ??
                  cardTheme.shape ??
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
              borderOnForeground: borderOnForeground,
              clipBehavior: clipBehavior ??
                  cardTheme.clipBehavior ??
                  _defaultClipBehavior,
              child: showOverlayImage == false ? cardChild : overlayImage,
            )
          : showOverlayImage == false
              ? cardChild
              : overlayImage,
    );
  }
}
