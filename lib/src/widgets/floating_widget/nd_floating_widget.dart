import 'package:flutter/material.dart';

class NDFloatingWidget extends StatefulWidget {
  const NDFloatingWidget(
      {Key? key,
      this.child,
      this.horizontalPosition,
      this.verticalPosition,
      this.blurnessColor,
      this.showBlurness = false,
      this.body})
      : super(key: key);

  final Widget? child;

  final Widget? body;

  final double? horizontalPosition;

  final double? verticalPosition;

  final Color? blurnessColor;

  final bool showBlurness;

  @override
  _NDFloatingWidgetState createState() => _NDFloatingWidgetState();
}

class _NDFloatingWidgetState extends State<NDFloatingWidget> {
  Widget? child;

  @override
  void initState() {
    child = widget.child;
    super.initState();
  }

  @override
  void didUpdateWidget(NDFloatingWidget oldWidget) {
    child = widget.child;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: widget.body ?? Container(),
          ),
          Positioned(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: widget.showBlurness
                  ? widget.blurnessColor ?? Colors.black54
                  : null,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: widget.verticalPosition ?? 0.0,
                    left: widget.horizontalPosition ?? 0.0,
                    child: widget.child ?? Container(),
                  )
                ],
              ),
            ),
          )
        ],
      );
}
