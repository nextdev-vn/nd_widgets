import 'dart:async';
import 'package:flutter/material.dart';

typedef NDItemsCarouselSlideStartCallback = void Function(
    DragStartDetails details);

typedef NDItemsCarouselSlideCallback = void Function(DragUpdateDetails details);

typedef NDItemsCarouselSlideEndCallback = void Function(DragEndDetails details);

class NDItemsCarousel extends StatefulWidget {
  const NDItemsCarousel({
    Key? key,
    required this.rowCount,
    required this.children,
    this.onSlideStart,
    this.onSlide,
    this.onSlideEnd,
    this.itemHeight = 200,
  }) : super(key: key);

  final int rowCount;

  final List<Widget> children;

  final NDItemsCarouselSlideStartCallback? onSlideStart;

  final NDItemsCarouselSlideCallback? onSlide;

  final NDItemsCarouselSlideEndCallback? onSlideEnd;

  final double itemHeight;

  @override
  _NDItemsCarouselState createState() => _NDItemsCarouselState();
}

class _NDItemsCarouselState extends State<NDItemsCarousel>
    with TickerProviderStateMixin {
  static const int dragAnimationDuration = 1000;

  static const int shiftAnimationDuration = 300;

  double size = 0;

  double width = 0;

  late AnimationController animationController;

  late double offset;

  @override
  void initState() {
    offset = 0;
    animationController = AnimationController(
        duration: const Duration(milliseconds: dragAnimationDuration),
        vsync: this);
    Future.delayed(Duration.zero, () {
      setState(() {
        final double localWidth = MediaQuery.of(context).size.width;
        width = localWidth;
        size = width / widget.rowCount;
      });
    });
    super.initState();
  }

  double calculateOffset(double shift) {
    double localOffset = offset + shift;
    final double rightLimit = size * (widget.children.length - widget.rowCount);

    if (localOffset > 0) {
      localOffset = 0;
    } else if (localOffset < -rightLimit) {
      localOffset = -rightLimit;
    }
    return localOffset;
  }

  void onSlideStart(DragStartDetails details) {
    animationController.stop();
    if (widget.onSlideStart != null) {
      widget.onSlideStart!(details);
    }
  }

  void onSlide(DragUpdateDetails details) {
    setState(() {
      offset = calculateOffset(3 * details.delta.dx);
    });
    if (widget.onSlide != null) {
      widget.onSlide!(details);
    }
  }

  void onSlideEnd(DragEndDetails details) {
    final double dx = details.velocity.pixelsPerSecond.dx;

    if (dx == 0) {
      return slideAnimation();
    }

    animationController = AnimationController(
        duration: const Duration(milliseconds: dragAnimationDuration),
        vsync: this);

    final Tween tween =
        Tween<double>(begin: offset, end: calculateOffset(0.5 * dx));
    Animation animation;
    animation = tween.animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));
    animation.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        slideAnimation();
      }
    });
    animation.addListener(() {
      setState(() {
        offset = animation.value;
      });
    });

    animationController.forward();
    if (widget.onSlideEnd != null) {
      widget.onSlideEnd!(details);
    }
  }

  void slideAnimation() {
    final double beginAnimation = offset;
    final double endAnimation = size * (offset / size).round().toDouble();
    animationController = AnimationController(
        duration: const Duration(milliseconds: shiftAnimationDuration),
        vsync: this);
    final Tween tween = Tween<double>(begin: beginAnimation, end: endAnimation);
    final Animation animation = tween.animate(animationController);
    animation.addListener(() {
      setState(() {
        offset = animation.value;
      });
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onHorizontalDragStart: onSlideStart,
        onHorizontalDragUpdate: onSlide,
        onHorizontalDragEnd: onSlideEnd,
        child: Container(
          width: double.infinity,
          height: widget.itemHeight,
          child: Stack(
            children: [
              Positioned(
                left: offset,
                child: Row(
                  children: widget.children
                      .map((child) => Container(
                            width: size,
                            height: widget.itemHeight,
                            child: child,
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
}
