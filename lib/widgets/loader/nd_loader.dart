import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/size/nd_size.dart';
import '../../constants/types/nd_loader_type.dart';

class NDLoader extends StatefulWidget {
  const NDLoader(
      {Key? key,
      this.loaderColorOne = Colors.redAccent,
      this.loaderColorTwo = Colors.green,
      this.loaderColorThree = Colors.blueAccent,
      this.duration = const Duration(milliseconds: 1000),
      this.type = NDLoaderType.android,
      this.loaderIconOne,
      this.loaderIconTwo,
      this.loaderIconThree,
      this.androidLoaderColor,
      this.loaderstrokeWidth = 4.0,
      this.size = NDSize.MEDIUM,
      this.child})
      : super(key: key);

  final Widget? child;

  final Color loaderColorOne;

  final Color loaderColorTwo;

  final Color loaderColorThree;

  final Duration duration;

  final NDLoaderType type;

  final Widget? loaderIconOne;

  final Widget? loaderIconTwo;

  final Widget? loaderIconThree;

  final Animation<Color>? androidLoaderColor;

  final double loaderstrokeWidth;

  final double size;

  @override
  _NDLoaderState createState() => _NDLoaderState();
}

class _NDLoaderState extends State<NDLoader>
    with SingleTickerProviderStateMixin {
  late Animation<double> loaderAnimation1;
  late Animation<double> loaderAnimation2;
  late Animation<double> loaderAnimation3;
  late AnimationController controller;
  Interval interval = const Interval(0.1, 0.81, curve: Curves.linear);

  @override
  void initState() {
    controller = AnimationController(duration: widget.duration, vsync: this);
    loaderAnimation1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: interval),
    );
    loaderAnimation2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: interval),
    );
    loaderAnimation3 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: interval),
    );
    controller.addListener(() {
      setState(() {});
    });
    controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        child: widget.child != null
            ? Loader(
                radius: widget.size * 0.3,
                type: widget.type,
                child: widget.child,
              )
            : widget.type == NDLoaderType.android
                ? Center(
                    child: Container(
                    height: widget.size * 0.7,
                    width: widget.size * 0.7,
                    child: CircularProgressIndicator(
                      valueColor: widget.androidLoaderColor,
                      strokeWidth: widget.loaderstrokeWidth,
                    ),
                  ))
                : widget.type == NDLoaderType.ios
                    ? Center(
                        child: CupertinoActivityIndicator(
                            radius: widget.size * 0.4),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Opacity(
                            opacity: loaderAnimation1.value <= 0.3
                                ? 2.5 * loaderAnimation1.value
                                : (loaderAnimation1.value > 0.30 &&
                                        loaderAnimation1.value <= 0.70)
                                    ? 1.0
                                    : 2.5 - (2.5 * loaderAnimation1.value),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Loader(
                                radius: widget.size * 0.3,
                                color: widget.loaderColorOne,
                                type: widget.type,
                                icon: widget.loaderIconOne,
                                child: widget.child,
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: loaderAnimation2.value <= 0.3
                                ? 2.5 * loaderAnimation2.value
                                : (loaderAnimation2.value > 0.30 &&
                                        loaderAnimation2.value <= 0.70)
                                    ? 1.0
                                    : 2.5 - (2.5 * loaderAnimation2.value),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Loader(
                                radius: widget.size * 0.44,
                                color: widget.loaderColorTwo,
                                type: widget.type,
                                icon: widget.loaderIconTwo,
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: loaderAnimation3.value <= 0.3
                                ? 2.5 * loaderAnimation3.value
                                : (loaderAnimation3.value > 0.30 &&
                                        loaderAnimation3.value <= 0.70)
                                    ? 1.0
                                    : 2.5 - (2.5 * loaderAnimation3.value),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Loader(
                                radius: widget.size * 0.3,
                                color: widget.loaderColorThree,
                                type: widget.type,
                                icon: widget.loaderIconThree,
                              ),
                            ),
                          ),
                        ],
                      ),
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Loader extends StatelessWidget {
  const Loader(
      {Key? key,
      this.radius,
      this.color,
      this.type,
      this.icon,
      this.size,
      this.child})
      : super(key: key);
  final double? radius;
  final Color? color;
  final NDLoaderType? type;
  final Widget? icon;
  final double? size;
  final Widget? child;

  @override
  Widget build(BuildContext context) => Center(
        child: type == NDLoaderType.custom
            ? Container(child: child != null ? child : icon ?? Container())
            : Container(
                width: radius,
                height: radius,
                decoration: BoxDecoration(
                    color: color,
                    shape: type == NDLoaderType.circle
                        ? BoxShape.circle
                        : BoxShape.rectangle),
              ),
      );
}
