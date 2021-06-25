import 'package:example/pages/third_page.dart';
import 'package:example/shared/authenticated_widget.dart';
import 'package:flutter/material.dart';
import 'package:i_navigation/extension.dart';

class SecondPage extends StatefulWidget implements AuthenticatedWidget {
  final bool isAuthorized;
  const SecondPage({
    Key key,
    this.isAuthorized = false,
  }) : super(key: key);

  @override
  bool shouldLetRoutePass() {
    return isAuthorized;
  }

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RaisedButton(
                child: Text(
                  'Push third page',
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  context.pushRoute(ThirdPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
