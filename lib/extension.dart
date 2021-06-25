import 'package:flutter/material.dart';
import 'package:i_navigation/i_navigation.dart';

final importINavigationExtension = 0;

extension INavigationExtension on BuildContext {
  /// can pop will return true if there are more then one page in the widget tree
  bool canPop() => INavigation.of(this).canPop(this);

  /// Pop the top-most route off the navigator
  void pop([dynamic returnedValue]) =>
      INavigation.of(this).pop(this, returnedValue);

  /// Pop all routes from navigator except first route
  void popUntilFirst() => INavigation.of(this).popUntilFirst(this);

  /// Pop all routes until finding widget that will be passed as generic type T
  /// note: generic type T must not be null and widget should stay in the tree
  void popUntilWidget<T>() => INavigation.of(this).popUntilWidget<T>(this);

  /// Pop all routes until finding widget that will be passed as generic type T
  /// note: generic type T must not be null and widget will be popped from tree in possible(if it is not the first route)
  void popUntilWidgetIncluded<T>() =>
      INavigation.of(this).popUntilWidgetIncluded<T>(this);

  /// Pop all routes until finding widget that will be passed as generic type T or R
  /// note: generic type T and R must not be null and widget should stay in the tree
  void popUntilOneOfTwoWidgets<T, R>() =>
      INavigation.of(this).popUntilOneOfTwoWidgets<T, R>(this);

  /// Push a new route to navigator
  /// if replacement is true the top route will be removed
  Future<dynamic> pushRoute(Widget nextPage, {bool replacement = false}) =>
      INavigation.of(this).pushRoute(this, nextPage, replacement: replacement);

  /// Push a new route to navigator
  /// And remove all other routes
  Future<dynamic> pushAndRemoveAll(Widget nextPage) =>
      INavigation.of(this).pushAndRemoveAll(this, nextPage);

  /// Push a new route to navigator
  /// And remove all other routes until finding widget that will be passed as generic type T
  /// note: T must not be null and this widget should stay in the widge tree
  Future<dynamic> pushAndRemoveUntil<T>(Widget nextPage) =>
      INavigation.of(this).pushAndRemoveUntil<T>(this, nextPage);

  /// Push a new route to navigator
  /// And remove all other routes until finding widget that will be passed as generic type T
  /// note: T must not be null and this widget will not stay in the widge tree
  Future<dynamic> pushAndRemoveUntilIncluded<T>(Widget nextPage) =>
      INavigation.of(this).pushAndRemoveUntilIncluded<T>(this, nextPage);
}
