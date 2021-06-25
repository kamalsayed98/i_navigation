library i_navigation;

import 'package:flutter/material.dart';
import 'package:i_navigation/i_auth_guard.dart';
import 'package:i_navigation/i_authenticated_widget.dart';

import 'exceptions.dart';

typedef IRouteBuilder = PageRoute Function(Widget);

class INavigation extends InheritedWidget {
  /// Signature for the function that builds a route's primary contents
  final RoutePageBuilder pageBuilder;

  /// Transition that will be used to add the new page
  /// default behavior when pushing page will start appearing from right to left
  /// and left to right while poping
  final RouteTransitionsBuilder transitionsBuilder;

  /// Guard should be inhereted to create routeCanPass method
  /// which will be used to check if route should be restrected
  final IAuthGuard authGuard;

  /// if throwExceptionOnUnAuthorizedRoutes = true
  /// an instance of RouteNotAuthorizedException will be thrown
  /// when route not authorized tried to be pushed
  final bool throwExceptionOnUnAuthorizedRoutes;

  INavigation({
    Key key,
    Widget child,
    this.pageBuilder,
    this.authGuard,
    this.transitionsBuilder,
    this.throwExceptionOnUnAuthorizedRoutes = false,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  /// this method is used in extensions file to get istance of INavigation object from the top of the tree
  static INavigation of(context) {
    final result = (context.dependOnInheritedWidgetOfExactType<INavigation>());
    if (result == null) {
      throw Exception(
        "Widget tree doesn't has INavigation widget in it,"
        " make sure you add it.",
      );
    }
    return result;
  }

  /// can pop will return true if there are more then one page in the widget tree
  bool canPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }

  /// Pop the top-most route off the navigator
  void pop(BuildContext context, [dynamic returnedValue]) {
    return Navigator.of(context).pop(returnedValue);
  }

  /// Pop all routes from navigator except first route
  void popUntilFirst(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  /// Pop all routes until finding widget that will be passed as generic type T
  /// note: generic type T must not be null and widget should stay in the tree
  void popUntilWidget<T>(BuildContext context) {
    if (T == null)
      throw Exception(
        'popUntilWidget must be provided with widget'
        ' in order to pop until it, but it is not',
      );
    Navigator.of(context).popUntil(
      (route) => route.settings.name == T.toString() || route.isFirst,
    );
  }

  /// Pop all routes until finding widget that will be passed as generic type T
  /// note: generic type T must not be null and widget will be popped from tree in possible(if it is not the first route)
  void popUntilWidgetIncluded<T>(BuildContext context) {
    if (T == null)
      throw Exception(
        'popUntilWidgetIncluded must be provided with widget'
        ' in order to pop until removing it, but it is not',
      );
    final navigator = Navigator.of(context);
    navigator.popUntil(
      (route) => route.settings.name == T.toString() || route.isFirst,
    );
    if (navigator.canPop()) navigator.pop();
  }

  /// Pop all routes until finding widget that will be passed as generic type T or R
  /// note: generic type T and R must not be null and widget should stay in the tree
  void popUntilOneOfTwoWidgets<T, R>(BuildContext context) {
    if (T == null || R == null)
      throw Exception(
        'popUntilOneOfTwoWidgets must be provided with two widgets'
        ' in order to pop until one of them, but it is not',
      );

    Navigator.of(context).popUntil(
      (route) =>
          route.settings.name == T.toString() ||
          route.settings.name == R.toString() ||
          route.isFirst,
    );
  }

  PageRoute _defaultBuildRoute(Widget nextPage) {
    return PageRouteBuilder(
      settings: RouteSettings(
        name: nextPage.runtimeType.toString(),
      ),
      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) {
        if (this.pageBuilder != null) {
          return this.pageBuilder(
            context,
            animation,
            secondaryAnimation,
          );
        }
        return nextPage;
      },
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        if (this.transitionsBuilder != null) {
          return this.transitionsBuilder(
            context,
            animation,
            secondaryAnimation,
            child,
          );
        }

        return SlideTransition(
          position: animation.drive(
            Tween(
              begin: Offset(
                1.0,
                0.0,
              ),
              end: Offset.zero,
            ).chain(
              CurveTween(
                curve: Curves.ease,
              ),
            ),
          ),
          child: child,
        );
      },
    );
  }

  Future<bool> _isAuthenticated(Widget nextPage) async {
    if (nextPage is IAuthenticatedWidget && authGuard != null) {
      final page = nextPage as IAuthenticatedWidget;
      final isAuthenticatedGranted = await authGuard.routeCanPass(page);
      if (isAuthenticatedGranted == false) {
        if (throwExceptionOnUnAuthorizedRoutes)
          throw RouteNotAuthorizedException();
        return false;
      }
    }
    return true;
  }

  Future<PageRoute> _buildRoute(Widget nextPage) async {
    final auth = await _isAuthenticated(nextPage);
    if (auth != true) return null;
    // if (pageRouteBuilder != null) {
    //   return pageRouteBuilder(nextPage);
    // }
    return _defaultBuildRoute(nextPage);
  }

  /// Push a new route to navigator
  /// if replacement is true the top route will be removed
  Future<dynamic> pushRoute(
    BuildContext context,
    Widget nextPage, {
    bool replacement = false,
  }) async {
    final route = await _buildRoute(nextPage);
    if (route == null) return null;
    return await (replacement == true
        ? Navigator.of(context).pushReplacement(route)
        : Navigator.of(context).push(route));
  }

  /// Push a new route to navigator
  /// And remove all other routes
  Future<dynamic> pushAndRemoveAll(
      BuildContext context, Widget nextPage) async {
    final route = await _buildRoute(nextPage);
    if (route == null) return null;
    return Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
  }

  /// Push a new route to navigator
  /// And remove all other routes until finding widget that will be passed as generic type T
  /// note: T must not be null and this widget should stay in the widge tree
  Future<dynamic> pushAndRemoveUntil<T>(
      BuildContext context, Widget nextPage) async {
    if (T == null)
      throw Exception(
        'pushAndRemoveUntil must be provided with widget'
        ' in order to pop until it and push the new widget, but it is not',
      );
    final route = await _buildRoute(nextPage);
    if (route == null) return null;
    return Navigator.of(context).pushAndRemoveUntil(
      route,
      (_route) => _route.settings.name == T.toString() || _route.isFirst,
    );
  }

  /// Push a new route to navigator
  /// And remove all other routes until finding widget that will be passed as generic type T
  /// note: T must not be null and this widget will not stay in the widge tree
  Future<dynamic> pushAndRemoveUntilIncluded<T>(
      BuildContext context, Widget nextPage) async {
    if (T == null)
      throw Exception(
        'pushAndRemoveUntilIncluded must be provided with widget'
        ' in order to pop until removing it and push the new widget, but it is not',
      );
    final auth = await _isAuthenticated(nextPage);
    if (auth != true) return null;
    this.popUntilWidget<T>(context);
    return this.pushRoute(context, nextPage, replacement: true);
  }
}
