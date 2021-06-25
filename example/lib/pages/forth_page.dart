import 'package:example/pages/second_page.dart';
import 'package:example/pages/third_page.dart';
import 'package:example/shared/authenticated_widget.dart';
import 'package:flutter/material.dart';
import 'package:i_navigation/extension.dart';

class ForthPage extends StatefulWidget implements AuthenticatedWidget {
  final bool isAuthenticated;
  const ForthPage({Key key, this.isAuthenticated = true}) : super(key: key);

  @override
  _ForthPageState createState() => _ForthPageState();

  @override
  bool shouldLetRoutePass() {
    return isAuthenticated;
  }
}

class _ForthPageState extends State<ForthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forth Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              child: Text(
                'pop',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                context.pop();
              },
            ),
            RaisedButton(
              child: Text(
                'popUntilFirst',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                context.popUntilFirst();
              },
            ),
            RaisedButton(
              child: Text(
                'popUntilWidget secondPage',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                context.popUntilWidget<SecondPage>();
              },
            ),
            RaisedButton(
              child: Text(
                'popUntilWidgetIncluded secondPage(included)',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                context.popUntilWidgetIncluded<SecondPage>();
              },
            ),
            RaisedButton(
              child: Text(
                'popUntilOneOfTwoWidgets secondPage or ThirdPage',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                context.popUntilOneOfTwoWidgets<SecondPage, ThirdPage>();
              },
            ),
          ],
        ),
      ),
    );
  }
}
