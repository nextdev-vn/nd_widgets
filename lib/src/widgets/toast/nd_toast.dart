import 'dart:async';

import 'package:flutter/material.dart';

import '../../constants/position/nd_toast_position.dart';

class NDToast {
  String? text;

  int? toastDuration;

  NDToastPosition? toastPosition;

  Color? backgroundColor;

  TextStyle? textStyle;

  double? toastBorderRadius;

  Border? border;

  late Widget trailing;

  static showToast(
    text,
    BuildContext context, {
    toastDuration,
    toastPosition,
    backgroundColor = const Color(0xAA000000),
    textStyle = const TextStyle(fontSize: 15, color: Colors.white),
    toastBorderRadius = 20.0,
    border,
    trailing,
  }) {
    assert(text != null);
    ToastView.dismiss();
    ToastView.createView(text, context, toastDuration, toastPosition,
        backgroundColor, textStyle, toastBorderRadius, border, trailing);
  }
}

class ToastView {
  static final ToastView _instance = ToastView._internal();

  factory ToastView() => _instance;

  ToastView._internal();

  static OverlayState? overlayState;
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void createView(
      String text,
      BuildContext context,
      int? toastDuration,
      NDToastPosition? toastPosition,
      Color backgroundColor,
      TextStyle textStyle,
      double toastBorderRadius,
      Border? border,
      trailing) async {
    overlayState = Overlay.of(context, rootOverlay: false);

    final Widget toastChild = ToastCard(
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(toastBorderRadius),
            border: border,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: trailing == null
              ? Text(text, softWrap: true, style: textStyle)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(text, style: textStyle),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    trailing
                  ],
                ),
        ),
        Duration(seconds: toastDuration ?? 2),
        fadeDuration: 500);

    _overlayEntry = OverlayEntry(
        builder: (BuildContext context) =>
            _showWidgetBasedOnPosition(toastChild, toastPosition));

    _isVisible = true;
    overlayState!.insert(_overlayEntry!);
    await Future.delayed(Duration(seconds: toastDuration ?? 2));
    await dismiss();
  }

  static Positioned _showWidgetBasedOnPosition(
      Widget child, NDToastPosition? toastPosition) {
    switch (toastPosition) {
      case NDToastPosition.BOTTOM:
        return Positioned(bottom: 60, left: 18, right: 18, child: child);
      case NDToastPosition.BOTTOM_LEFT:
        return Positioned(bottom: 60, left: 18, child: child);
      case NDToastPosition.BOTTOM_RIGHT:
        return Positioned(bottom: 60, right: 18, child: child);
      case NDToastPosition.CENTER:
        return Positioned(
            top: 60, bottom: 60, left: 18, right: 18, child: child);
      case NDToastPosition.CENTER_LEFT:
        return Positioned(top: 60, bottom: 60, left: 18, child: child);
      case NDToastPosition.CENTER_RIGHT:
        return Positioned(top: 60, bottom: 60, right: 18, child: child);
      case NDToastPosition.TOP_LEFT:
        return Positioned(top: 110, left: 18, child: child);
      case NDToastPosition.TOP_RIGHT:
        return Positioned(top: 110, right: 18, child: child);
      default:
        return Positioned(top: 110, left: 18, right: 18, child: child);
    }
  }

  static Future<void> dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

class ToastCard extends StatefulWidget {
  const ToastCard(this.child, this.duration,
      {Key? key, this.fadeDuration = 500})
      : super(key: key);

  final Widget child;
  final Duration duration;
  final int fadeDuration;

  @override
  ToastStateFulState createState() => ToastStateFulState();
}

class ToastStateFulState extends State<ToastCard>
    with SingleTickerProviderStateMixin {
  void showAnimation() {
    _animationController!.forward();
  }

  void hideAnimation() {
    _animationController!.reverse();
    _timer?.cancel();
  }

  AnimationController? _animationController;
  late Animation _fadeAnimation;

  Timer? _timer;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.fadeDuration),
    );
    _fadeAnimation =
        CurvedAnimation(parent: _animationController!, curve: Curves.easeIn);
    super.initState();

    showAnimation();
    _timer = Timer(widget.duration, hideAnimation);
  }

  @override
  void deactivate() {
    _timer?.cancel();
    _animationController!.stop();
    super.deactivate();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _fadeAnimation as Animation<double>,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: widget.child,
          ),
        ),
      );
}
