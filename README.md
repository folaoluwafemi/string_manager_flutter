<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for

[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A Flutter Package for Managing App Strings in flutter applications on all platforms particularly
internationalization

## Features

- keep your app strings DRY
- easy internationalization
- supports all platforms

![example video](https://user-images.githubusercontent.com/89414401/173678119-8bd4f10b-7dc2-46c8-a1bd-e412925720ec.mp4)

## Getting started

```yaml
dependencies:
  flutter:
    sdk: flutter
  string_manager_flutter:
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:string_manager_flutter/string_manager_flutter.dart';

final StringManager str = StringManager.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  StringManager(language: 'en'); //factory for the singleton instance
  await str.initialize(); //you must initialize the stringManager first
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      MaterialApp(
        home: const MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              str.reg('You have pushed the button this many times'),
              //str.reg registers the string in stringManger and returns it to be used
            ),
            Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: CounterFab(
        onPressed1: _incrementCounter,
        onPressed2: () async {
          await str.translate('yo');
          await str.save();
          setState(() {});
        },
        text2: str.reg('change language'),
        //register "change language" in stringManager
      ),
    );
  }
}
```

## Additional information

If you face any errors kindly create an issue, and if you wish to add a feature I will be more than
happy to merge your PR

# Enjoy your internationalization redefined. 😃