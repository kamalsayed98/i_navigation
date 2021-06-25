import 'package:i_navigation/i_authenticated_widget.dart';

abstract class IAuthGuard {
  Future<bool> routeCanPass(IAuthenticatedWidget nextPage);
}
