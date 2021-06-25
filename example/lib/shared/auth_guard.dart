import 'package:i_navigation/i_auth_guard.dart';
import 'package:i_navigation/i_authenticated_widget.dart';

import 'authenticated_widget.dart';

class AuthGuard extends IAuthGuard {
  @override
  Future<bool> routeCanPass(IAuthenticatedWidget nextPage) {
    if (nextPage is AuthenticatedWidget) {
      return Future.value(nextPage.shouldLetRoutePass());
    }
    return Future.value(true);
  }
}
