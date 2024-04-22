import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter with ChangeNotifier {
  Counter({required this.context});

  final BuildContext context;

  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class Counter2 with ChangeNotifier {
  Counter2({required this.context});

  final BuildContext context;

  int _count = 1;
  int get count => _count;

  void multiply() {
    _count = _count * 2;
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Counter(context: context),
        ),
        ChangeNotifierProvider(
          create: (context) => Counter2(context: context),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Provider Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You have pushed the button this many times:'),
              Consumer<Counter>(
                builder: (context, counter, child) => Text(
                  '${counter.count}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Text('You have pushed the button this many times:'),
              Consumer<Counter2>(
                builder: (context, counter2, child) => Text(
                  '${counter2.count}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<Counter>().increment();
            context.read<Counter2>().multiply();
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
