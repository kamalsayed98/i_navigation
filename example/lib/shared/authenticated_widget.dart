import 'package:i_navigation/i_authenticated_widget.dart';

abstract class AuthenticatedWidget extends IAuthenticatedWidget {
  bool shouldLetRoutePass();
}
