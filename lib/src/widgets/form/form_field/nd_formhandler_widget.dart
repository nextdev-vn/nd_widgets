import 'package:flutter/material.dart';

import '../nd_form_provider.dart';

class NDFormHandlerWidget extends InheritedWidget {
  const NDFormHandlerWidget(
      {required this.ndFormHandler, required Widget child})
      : super(child: child);

  final NDFormHandler ndFormHandler;

  static NDFormHandlerWidget of(BuildContext context) {
    final NDFormHandlerWidget? result =
        context.dependOnInheritedWidgetOfExactType<NDFormHandlerWidget>();
    assert(result != null, 'No NDFormHandlerWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
