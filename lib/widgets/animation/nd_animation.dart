import 'package:flutter/material.dart';

import '../../constants/types/nd_animation_type.dart';

class NDAnimation extends StatefulWidget {
  const NDAnimation({
    Key? key,
    required this.child,
    this.duration,
    this.alignment,
    this.curve,
    this.type,
    this.width,
    this.height,
    this.activeColor,
    this.color,
    this.padding,
    this.activeAlignment,
    this.onTap,
    this.margin,
    this.turnsAnimation,
    this.scaleAnimation,
    this.controller,
    this.textDirection,
    this.slidePosition,
    this.style,
    this.textAlign,
    this.textOverflow,
    this.maxLines,
    this.textWidthBasis,
    this.fontSize,
    this.fontWeight,
    this.changedWidth,
    this.changedHeight,
    this.reverseDuration,
  }) : super(key: key);

  final Duration? duration;

  final Duration? reverseDuration;

  final Alignment? alignment;

  final Alignment? activeAlignment;

  final Widget child;

  final Curve? curve;

  final NDAnimationType? type;

  final double? width;

  final double? changedWidth;

  final double? height;

  final double? changedHeight;

  final Color? activeColor;

  final Color? color;

  final EdgeInsetsGeometry? padding;

  final EdgeInsetsGeometry? margin;

  final void Function()? onTap;

  final Animation<double>? turnsAnimation;

  final Animation<double>? scaleAnimation;

  final AnimationController? controller;

  final TextDirection? textDirection;

  final Animation<Offset>? slidePosition;

  final TextStyle? style;

  final TextAlign? textAlign;

  final TextOverflow? textOverflow;

  final int? maxLines;

  final TextWidthBasis? textWidthBasis;

  final double? fontSize;

  final FontWeight? fontWeight;

  @override
  _NDAnimationState createState() => _NDAnimationState();
}

class _NDAnimationState extends State<NDAnimation>
    with SingleTickerProviderStateMixin {
  bool selected = false;
  AnimationController? controller;
  Animation<double>? animation;
  late Animation<Offset> offsetAnimation;

  @override
  void initState() {
    if (widget.type == NDAnimationType.rotateTransition) {
      controller = widget.controller ??
          AnimationController(
              duration: widget.duration ?? const Duration(seconds: 2),
              vsync: this);
      animation = widget.turnsAnimation ??
          Tween<double>(begin: 0, end: 20).animate(controller!);
      if (widget.turnsAnimation == null) {
        controller?.forward();
      }
    } else if (widget.type == NDAnimationType.scaleTransition) {
      controller = widget.controller ??
          AnimationController(
              duration: widget.duration ?? const Duration(seconds: 2),
              vsync: this);
      animation = widget.scaleAnimation ??
          CurvedAnimation(
              parent: controller!, curve: widget.curve ?? Curves.ease);
      controller?.forward();
    } else if (widget.type == NDAnimationType.slideTransition) {
      controller = AnimationController(
          duration: widget.duration ?? const Duration(seconds: 2), vsync: this)
        ..repeat(reverse: true);
      offsetAnimation = Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(1.5, 0),
      ).animate(CurvedAnimation(
        parent: controller!,
        curve: Curves.linear,
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => getAnimatedTypeWidget();

  Widget buildAnimatedContainerWidget() => GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              selected = !selected;
            });
          }
        },
        child: AnimatedContainer(
          margin: widget.margin ?? const EdgeInsets.all(0),
          padding: widget.padding ?? const EdgeInsets.all(8),
          width:
              selected ? widget.changedWidth ?? 200.0 : widget.width ?? 100.0,
          height:
              selected ? widget.changedHeight ?? 200.0 : widget.height ?? 100.0,
          color: selected
              ? widget.activeColor ?? Colors.red
              : widget.color ?? Colors.blue,
          alignment: selected
              ? widget.activeAlignment ?? Alignment.center
              : widget.alignment ?? Alignment.center,
          duration: widget.duration ?? const Duration(milliseconds: 2000),
          curve: widget.curve ?? Curves.linear,
          child: widget.child,
        ),
      );

  Widget buildAnimatedAlignWidget() => GestureDetector(
        onTap: () {
          if (widget.onTap == null) {
            if (mounted) {
              setState(() {
                selected = !selected;
              });
            }
          } else {
            widget.onTap!();
          }
        },
        child: Container(
          margin: widget.margin ?? const EdgeInsets.all(0),
          padding: widget.padding ?? const EdgeInsets.all(0),
          child: AnimatedAlign(
            curve: widget.curve ?? Curves.linear,
            alignment: selected
                ? widget.activeAlignment ?? Alignment.center
                : widget.alignment ?? Alignment.topCenter,
            duration: widget.duration ?? const Duration(seconds: 2),
            child: widget.child,
          ),
        ),
      );

  Widget buildAnimatedSizeWidget() => GestureDetector(
        onTap: () {
          if (widget.onTap == null) {
            if (mounted) {
              setState(() {
                selected = !selected;
              });
            }
          } else {
            widget.onTap!();
          }
        },
        child: AnimatedSize(
          alignment: widget.alignment ?? Alignment.center,
          curve: widget.curve ?? Curves.linear,
          reverseDuration:
              widget.reverseDuration ?? const Duration(milliseconds: 2000),
          duration: widget.duration ?? const Duration(milliseconds: 2000),
          child: Container(
              margin: widget.margin ?? const EdgeInsets.all(0),
              padding: widget.padding ?? const EdgeInsets.all(0),
              color: widget.color ?? Colors.white,
              height: selected ? widget.height ?? 200 : widget.height ?? 100,
              width: selected ? widget.width ?? 200 : widget.width ?? 100,
              child: widget.child),
        ),
      );

  Widget buildRotationTransitionWidget() {
    if (animation != null && widget.alignment != null) {
      return RotationTransition(
        turns: animation!,
        child: widget.child,
        alignment: widget.alignment!,
      );
    }

    throw Exception('neither animation nor alignment cannot be null');
  }

  Widget buildScaleTransitionWidget() {
    if (animation != null) {
      return ScaleTransition(
        child: widget.child,
        scale: animation!,
        alignment: widget.alignment ?? Alignment.center,
      );
    }

    throw Exception('animation cannot be null');
  }

  Widget buildSlideTransitionWidget() => SlideTransition(
        child: widget.child,
        textDirection: widget.textDirection ?? TextDirection.ltr,
        position: widget.slidePosition ?? offsetAnimation,
      );

  Widget buildAnimatedDefaultTextStyleWidget() => GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          maxLines: widget.maxLines,
          style: widget.style ??
              TextStyle(
                  fontWeight: widget.fontWeight ?? FontWeight.normal,
                  fontSize: widget.fontSize ?? 16,
                  color: widget.color ?? Colors.blue),
          textWidthBasis: widget.textWidthBasis ?? TextWidthBasis.parent,
          textAlign: widget.textAlign ?? TextAlign.start,
          curve: widget.curve ?? Curves.linear,
          duration: widget.duration ?? const Duration(seconds: 2),
          child: widget.child,
        ),
      );

  Widget getAnimatedTypeWidget() {
    switch (widget.type) {
      case NDAnimationType.align:
        return buildAnimatedAlignWidget();

      case NDAnimationType.container:
        return buildAnimatedContainerWidget();

      case NDAnimationType.size:
        return buildAnimatedSizeWidget();

      case NDAnimationType.rotateTransition:
        return buildRotationTransitionWidget();

      case NDAnimationType.scaleTransition:
        return buildScaleTransitionWidget();

      case NDAnimationType.slideTransition:
        return buildSlideTransitionWidget();

      case NDAnimationType.textStyle:
        return buildAnimatedDefaultTextStyleWidget();

      default:
        return buildAnimatedContainerWidget();
    }
  }
}
