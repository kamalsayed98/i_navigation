class RouteNotAuthorizedException implements Exception {
  String toString() => "Can't navigate because route is not authorized.\n"
      "Make sure to add try catch to handle RouteNotAuthorizedException.\n"
      "And add await before method that will push or add .catchError to be able to handle the exception.";
}
