import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../constants/colors/nd_color.dart';
import '../../constants/direction/nd_shimmer_direction.dart';

class NDShimmer extends StatefulWidget {
  const NDShimmer({
    Key? key,
    required this.child,
    this.gradient,
    this.direction = NDShimmerDirection.leftToRight,
    this.duration = const Duration(milliseconds: 1500),
    this.shimmerEffectCount = 0,
    this.showShimmerEffect = true,
    this.showGradient = false,
    this.mainColor = Colors.grey,
    this.secondaryColor = NDColors.LIGHT,
  }) : super(key: key);

  final Widget child;

  final Duration duration;

  final NDShimmerDirection direction;

  final Gradient? gradient;

  final int shimmerEffectCount;

  final bool showShimmerEffect;

  final bool showGradient;

  final Color mainColor;

  final Color secondaryColor;

  @override
  _NDShimmerState createState() => _NDShimmerState();
}

class _NDShimmerState extends State<NDShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = 0;
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..addStatusListener((AnimationStatus status) {
        if (status != AnimationStatus.completed) {
          return;
        }
        _count++;
        if (widget.shimmerEffectCount <= 0) {
          _controller.repeat();
        } else if (_count < widget.shimmerEffectCount) {
          _controller.forward(from: 0);
        }
      });
    if (widget.showShimmerEffect) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(NDShimmer oldWidget) {
    if (widget.showShimmerEffect) {
      _controller.forward();
    } else {
      _controller.stop();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (BuildContext context, Widget? child) => _NDShimmer(
          child: child,
          direction: widget.direction,
          gradient: widget.showGradient
              ? widget.gradient
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                      widget.mainColor,
                      widget.mainColor,
                      widget.secondaryColor,
                      widget.mainColor,
                      widget.mainColor
                    ],
                  stops: const <double>[
                      0,
                      0.3,
                      0.5,
                      0.7,
                      1
                    ]),
          controllerValue: _controller.value,
          showShimmerEffect: widget.showShimmerEffect,
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

@immutable
class _NDShimmer extends SingleChildRenderObjectWidget {
  const _NDShimmer({
    Widget? child,
    this.controllerValue,
    this.direction,
    this.gradient,
    this.showShimmerEffect,
  }) : super(child: child);

  final double? controllerValue;

  final NDShimmerDirection? direction;

  final Gradient? gradient;

  final bool? showShimmerEffect;

  @override
  NDShimmerFilter createRenderObject(BuildContext context) => NDShimmerFilter(
      value: controllerValue,
      direction: direction,
      gradient: gradient,
      showShimmerEffect: showShimmerEffect);

  @override
  void updateRenderObject(BuildContext context, NDShimmerFilter shimmer) {
    shimmer.controllerValue = controllerValue;
    shimmer.showShimmerEffect = showShimmerEffect;
  }
}

class NDShimmerFilter extends RenderProxyBox {
  NDShimmerFilter(
      {this.value, this.direction, this.gradient, this.showShimmerEffect})
      : gradientPaint = Paint()..blendMode = BlendMode.srcIn;

  final Paint initialPaint = Paint();

  final Paint gradientPaint;

  final Gradient? gradient;

  final NDShimmerDirection? direction;

  bool? showShimmerEffect;

  double? value;

  Rect? _rect;

  @override
  bool get alwaysNeedsCompositing => child != null;

  double? get controllerValue => value;

  set controllerValue(double? newValue) {
    if (newValue == value) {
      return;
    }
    value = newValue;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) {
      return;
    }
    assert(needsCompositing);

    context.canvas.saveLayer(offset & child!.size, initialPaint);
    context.paintChild(child!, offset);
    Rect rect;
    double dx, dy;
    final double width = child!.size.width;
    final double height = child!.size.height;

    if (direction == NDShimmerDirection.leftToRight) {
      dx = _offset(-width, width, value!);
      dy = 0.0;
      rect = Rect.fromLTWH(offset.dx - width, offset.dy, 3 * width, height);
    } else if (direction == NDShimmerDirection.bottomToTop) {
      dx = 0.0;
      dy = _offset(height, -height, value!);
      rect = Rect.fromLTWH(offset.dx, offset.dy - height, width, 3 * height);
    } else if (direction == NDShimmerDirection.topToBottom) {
      dx = 0.0;
      dy = _offset(-height, height, value!);
      rect = Rect.fromLTWH(offset.dx, offset.dy - height, width, 3 * height);
    } else {
      dx = _offset(width, -width, value!);
      dy = 0.0;
      rect = Rect.fromLTWH(offset.dx - width, offset.dy, 3 * width, height);
    }
    if (_rect != rect) {
      gradientPaint.shader = gradient?.createShader(rect);
      _rect = rect;
    }
    context.canvas.translate(dx, dy);
    context.canvas.drawRect(rect, gradientPaint);
    context.canvas.restore();
  }

  double _offset(double start, double end, double controllerValue) =>
      start + (end - start) * controllerValue;
}
