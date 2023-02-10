import 'package:flutter/material.dart';

import '../../constants/types/nd_button_type.dart';
import '../button/nd_icon_button.dart';

class NDDrawerHeaderPictures extends StatelessWidget {
  const NDDrawerHeaderPictures({
    Key? key,
    this.currentAccountPicture,
    this.otherAccountsPictures,
    this.closeButton,
    this.centerAlign = false,
  }) : super(key: key);

  final Widget? currentAccountPicture;

  final List<Widget>? otherAccountsPictures;

  final Widget? closeButton;

  final bool centerAlign;

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          closeButton == null
              ? NDIconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  type: NDButtonType.transparent,
                )
              : closeButton!,
          PositionedDirectional(
            top: 0,
            end: 0,
            child: Row(
              children: (otherAccountsPictures ?? <Widget>[])
                  .take(3)
                  .map<Widget>(
                    (Widget picture) => Padding(
                      padding: const EdgeInsetsDirectional.only(start: 8),
                      child: Semantics(
                        container: true,
                        child: Container(
                          padding: const EdgeInsets.only(left: 8, bottom: 8),
                          width: 48,
                          height: 48,
                          child: picture,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Align(
            alignment:
                centerAlign ? Alignment.bottomCenter : Alignment.bottomLeft,
            child: Semantics(
              explicitChildNodes: true,
              child: SizedBox(
                width: 72,
                height: 72,
                child: currentAccountPicture,
              ),
            ),
          ),
        ],
      );
}

class NDDrawerHeader extends StatefulWidget {
  const NDDrawerHeader({
    Key? key,
    this.decoration,
    this.margin = const EdgeInsets.only(bottom: 8),
    this.currentAccountPicture,
    this.otherAccountsPictures,
    this.centerAlign = false,
    this.child,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.fastOutSlowIn,
    this.closeButton,
  }) : super(key: key);

  final Decoration? decoration;

  final EdgeInsetsGeometry margin;

  final Widget? currentAccountPicture;

  final List<Widget>? otherAccountsPictures;

  final bool centerAlign;

  final Widget? child;

  final Duration duration;

  final Curve curve;

  final Widget? closeButton;

  @override
  _NDDrawerHeaderState createState() => _NDDrawerHeaderState();
}

class _NDDrawerHeaderState extends State<NDDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Semantics(
      container: true,
      label: MaterialLocalizations.of(context).signedInLabel,
      child: Container(
        height: statusBarHeight + 185.0,
        decoration: widget.decoration ??
            BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
        margin: widget.margin,
        padding: const EdgeInsetsDirectional.only(top: 16, start: 16),
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 16),
                  child: NDDrawerHeaderPictures(
                    currentAccountPicture: widget.currentAccountPicture,
                    otherAccountsPictures: widget.otherAccountsPictures,
                    closeButton: widget.closeButton,
                    centerAlign: widget.centerAlign,
                  ),
                ),
              ),
              AnimatedContainer(
                padding: const EdgeInsets.only(bottom: 16),
                duration: widget.duration,
                curve: widget.curve,
                child: widget.child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
