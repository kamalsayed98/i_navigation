import 'package:example/pages/forth_page.dart';
import 'package:example/pages/second_page.dart';
import 'package:flutter/material.dart';
import 'package:i_navigation/extension.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key key}) : super(key: key);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RaisedButton(
                child: Text(
                  'Push forth page',
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  context.pushRoute(ForthPage()).catchError((e) => print(e));
                },
              ),
              RaisedButton(
                child: Text(
                  'Push forth page pushAndRemoveAll',
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  context
                      .pushAndRemoveAll(ForthPage())
                      .catchError((e) => print(e));
                },
              ),
              RaisedButton(
                child: Text(
                  'Push forth page pushAndRemoveAll and remove until SecondPage',
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  context
                      .pushAndRemoveUntil<SecondPage>(ForthPage())
                      .catchError((e) => print(e));
                },
              ),
              RaisedButton(
                child: Text(
                  'Push forth page pushAndRemoveAll and remove until SecondPage(included)',
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  context
                      .pushAndRemoveUntilIncluded<SecondPage>(ForthPage())
                      .catchError((e) => print(e));
                },
              ),
              RaisedButton(
                child: Text(
                  'UnAuthorized Push forth page',
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  context
                      .pushRoute(ForthPage(
                        isAuthenticated: false,
                      ))
                      .catchError((e) => print(e));
                },
              ),
              RaisedButton(
                child: Text(
                  'UnAuthorized Push forth page pushAndRemoveAll',
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  context
                      .pushAndRemoveAll(ForthPage(
                        isAuthenticated: false,
                      ))
                      .catchError((e) => print(e));
                },
              ),
              RaisedButton(
                child: Text(
                  'UnAuthorized Push forth page pushAndRemoveAll and remove until SecondPage',
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  context
                      .pushAndRemoveUntil<SecondPage>(ForthPage(
                        isAuthenticated: false,
                      ))
                      .catchError((e) => print(e));
                },
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                child: Text(
                  'UnAuthorized Push forth page pushAndRemoveAll and remove until SecondPage(included)',
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  context
                      .pushAndRemoveUntilIncluded<SecondPage>(ForthPage(
                        isAuthenticated: false,
                      ))
                      .catchError((e) => print(e));
                },
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
