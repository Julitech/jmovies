import 'package:flutter/material.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  final Widget previous;

  CustomRoute({this.previous, WidgetBuilder builder})
      : super(
          builder: builder,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    Animation<Offset> enterAnimation =
        Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-1.0, 0.0))
            .animate(animation);
    Animation<Offset> exitAnimation =
        Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(animation);
    return SlideTransition(position: exitAnimation, child: child);
  }
}
