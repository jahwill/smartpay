import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class AnimateToPage {
  static navigateRoute(
    BuildContext context, {
    required Widget gotoPage,
    SharedAxisTransitionType transitionType =
        SharedAxisTransitionType.horizontal,
    Duration reverseDuration = const Duration(milliseconds: 700),
    bool replacePg = false,
  }) {
    if (replacePg == false) {
      Navigator.push(
          context,
          _AnimateSinglePageRouter(
              gotoPage: gotoPage,
              transitionType: transitionType,
              reverseDuration: reverseDuration));
    } else {
      Navigator.pushReplacement(
          context,
          _AnimateSinglePageRouter(
              gotoPage: gotoPage,
              transitionType: transitionType,
              reverseDuration: reverseDuration));
    }
  }
}

/// page router builders mechanisms below

class _AnimateSinglePageRouter extends PageRouteBuilder {
  final Widget gotoPage;
  final SharedAxisTransitionType transitionType;
  final Duration reverseDuration;

  _AnimateSinglePageRouter(
      {required this.reverseDuration,
      required this.transitionType,
      required this.gotoPage})
      : super(
          opaque: false,
          barrierDismissible: true,
          barrierColor: Colors.black38,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              gotoPage,
          reverseTransitionDuration: reverseDuration,
          transitionDuration: const Duration(milliseconds: 900),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
                transitionType: transitionType);
          },
        );
}

///
class AnimateDoublePage extends PageRouteBuilder {
  final Widget gotoPage;
  final SharedAxisTransitionType transitionType;
  final Duration reverseDuration;

  AnimateDoublePage(
      {this.reverseDuration = const Duration(milliseconds: 700),
      required this.transitionType,
      required this.gotoPage})
      : super(
          opaque: false,
          barrierColor: Colors.black.withOpacity(0.4),
          barrierDismissible: true,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              gotoPage,
          reverseTransitionDuration: reverseDuration,
          transitionDuration: const Duration(milliseconds: 900),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: const Offset(0.5, 0.0),
              ).animate(animation),
              child: child,
            );
          },
        );
}
