import 'package:flutter/material.dart';
import 'package:truck_mandi/configs/routing/slide_transition_page.dart';

class MyNavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // Default slide direction can be set here
  static final SlideDirection defaultSlideDirection = SlideDirection.left;

  // Push a new screen with a custom transition (default is SlideTransition)
  static Future<dynamic> push(Widget page) {
    return navigatorKey.currentState!.push(
      SlideTransitionPage(page: page, slideDirection: defaultSlideDirection),
    );
  }

  // Push a new screen and replace the current one (with default transition)
  static Future<void> pushReplacement(Widget page) async {
    return navigatorKey.currentState
        ?.pushReplacement(
          SlideTransitionPage(
            page: page,
            slideDirection: defaultSlideDirection,
          ),
        )
        .then((_) => null); // Ignore the result and return Future<void>
  }

  // Push a new screen with named route and replace the current one
  static Future<void> pushReplacementNamed(String routeName) async {
    return navigatorKey.currentState
        ?.pushReplacementNamed(routeName)
        .then((_) => null);
  }

  // Push a named route
  static Future<void> pushNamed(String routeName) async {
    return navigatorKey.currentState?.pushNamed(routeName).then((_) => null);
  }

  // Pop the current screen
  static void pop() {
    return navigatorKey.currentState?.pop();
  }

  // Pop until a specific route name
  static void popUntil(String routeName) {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }

  // Pop until the root route (clear stack)
  static void popUntilRoot() {
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  // Push and remove all previous screens (push new screen, clear stack)
  static Future<void> pushAndRemoveAll(Widget page) async {
    return navigatorKey.currentState
        ?.pushAndRemoveUntil(
          SlideTransitionPage(
            page: page,
            slideDirection: defaultSlideDirection,
          ),
          (Route<dynamic> route) => false, // Remove all previous routes
        )
        .then((_) => null); // Ignore the result and return Future<void>
  }

  // Push and remove until a specific route (pop to that route, push new screen)
  static Future<void> pushAndRemoveUntil(Widget page, String routeName) async {
    return navigatorKey.currentState
        ?.pushAndRemoveUntil(
          SlideTransitionPage(
            page: page,
            slideDirection: defaultSlideDirection,
          ),
          ModalRoute.withName(routeName),
        )
        .then((_) => null); // Ignore the result and return Future<void>
  }

  // Push a route with a custom transition (use provided direction)
  static Future<void> navigateToWithCustomTransition(
    Widget page,
    SlideDirection direction,
  ) async {
    return navigatorKey.currentState
        ?.push(SlideTransitionPage(page: page, slideDirection: direction))
        .then((_) => null); // Ignore the result and return Future<void>
  }

  // Push replacement with custom transition
  static Future<void> pushReplacementWithCustomTransition(
    Widget page,
    SlideDirection direction,
  ) async {
    return navigatorKey.currentState
        ?.pushReplacement(
          SlideTransitionPage(page: page, slideDirection: direction),
        )
        .then((_) => null); // Ignore the result and return Future<void>
  }

  // Navigate with custom transition using named routes
  static Future<void> navigateToNamedWithCustomTransition(
    String routeName,
    SlideDirection direction,
  ) async {
    return navigatorKey.currentState
        ?.pushReplacementNamed(routeName)
        .then((_) => null);
  }

  // Pop until specific route name
  static void popUntilNamed(String routeName) {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }
}
