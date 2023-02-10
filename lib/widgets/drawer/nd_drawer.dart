import 'package:flutter/material.dart';

enum NDDrawerAlignment {
  start,

  end,
}

const double _kWidth = 304;

class NDDrawer extends StatelessWidget {
  const NDDrawer({
    Key? key,
    this.elevation = 16.0,
    this.child,
    this.semanticLabel,
    this.backgroundImage,
    this.colorFilter,
    this.gradient,
    this.color,
  })  : assert(elevation >= 0.0),
        super(key: key);

  final double elevation;

  final Widget? child;

  final String? semanticLabel;

  final ImageProvider? backgroundImage;

  final ColorFilter? colorFilter;

  final Gradient? gradient;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    String? label = semanticLabel;
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
        label = semanticLabel;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        label = semanticLabel ?? MaterialLocalizations.of(context).drawerLabel;
        break;
      default:
        break;
    }
    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(width: _kWidth),
        child: Material(
          elevation: elevation,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              gradient: gradient,
              image: backgroundImage != null
                  ? DecorationImage(
                      image: backgroundImage!,
                      fit: BoxFit.cover,
                      colorFilter: colorFilter,
                    )
                  : null,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
