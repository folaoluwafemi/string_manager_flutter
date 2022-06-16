## hello world

```dart
import 'package:flutter/material.dart';
import 'package:string_manager_flutter/string_manager_flutter.dart';
import 'package:intl/intl.dart';

final StringManager str = StringManager.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///factory constructor for the singleton instance
  StringManager(language: Intl.defaultLocale);

  await str.initialize();

  ///you must initialize the stringManager first
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      const MaterialApp(
        home: MyHomePage(),
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
    l
  }

  @override
  void dispose() {
    ///do not forget to close or save your strings
    str.save();
    str.close();
    super.dispose();
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

              ///str.reg(String text) registers the string in stringManger and returns it to be used
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
          await str.translate(to: 'yo');
          await str.save();

          ///you have the freedom to use whatever stateManagement you wish
          setState(() {});
        },
        text2: str.reg('change language'),
      ),
    );
  }
}

class CounterFab extends StatelessWidget {
  final String? text1;
  final String text2;
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;

  const CounterFab({
    required this.onPressed1,
    required this.onPressed2,
    required this.text2,
    this.text1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: onPressed1,
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 5),
        FloatingActionButton(
          onPressed: onPressed2,
          child: Text(
            text2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
}
```