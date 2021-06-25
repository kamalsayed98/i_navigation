import 'package:example/pages/second_page.dart';
import 'package:example/shared/auth_guard.dart';
import 'package:flutter/material.dart';
import 'package:i_navigation/exceptions.dart';
import 'package:i_navigation/extension.dart';
import 'package:i_navigation/i_navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return INavigation(
      /// Provide AuthGuard that will check routes if Next Page is of type IAuthenticatedWidget
      authGuard: AuthGuard(),

      /// Set throwExceptionOnUnAuthorizedRoutes to true in order to take action if route is not authorized
      throwExceptionOnUnAuthorizedRoutes: true,

      /// override transitionsBuilder in order for the page to be appearing from bottom to top
      /// and poping from top to end
      transitionsBuilder: (c, a, s, w) {
        return SlideTransition(
          position: a.drive(
            Tween(
              begin: Offset(
                0.0,
                1.0,
              ),
              end: Offset.zero,
            ).chain(
              CurveTween(
                curve: Curves.ease,
              ),
            ),
          ),
          child: w,
        );
      },

      child: MaterialApp(
        title: 'INavigation Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'INavigation Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// To handle RouteNotAuthorizedException you should add .catchError or add await before calling
  /// because push methods is async
  /// (because you can get returned from from next page by calling pop(returnedValue)
  ///  or if you want to add asyc function to detect if route is authorized or not)
  void navigate1stMethod(bool isAuthorized) async {
    context
        .pushRoute(SecondPage(isAuthorized: isAuthorized))
        .catchError((e) => print(e));
  }

  void navigate2ndMethod(bool isAuthorized) async {
    try {
      await context.pushRoute(SecondPage(isAuthorized: isAuthorized));
    } on RouteNotAuthorizedException {
      print('route not Authorized');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                child: Text(
                  'Push second page with authorization',
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  navigate1stMethod(true);
                },
              ),
              RaisedButton(
                child: Text(
                  'Push second page without authorization',
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  navigate2ndMethod(false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
