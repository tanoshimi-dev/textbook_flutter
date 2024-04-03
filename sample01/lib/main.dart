import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        //title: Text(widget.title),
        title: Row(children: const [
          Icon(Icons.create),
          Text("初めてのタイトル"),
        ]),
      ),
      body: Column(children: [
        Text('1行目'),
        Text('2行目'),
        TextButton(
          child: Text("ボタン"),
          onPressed: () => {print('ボタンが押されました')},
        ),
        const Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Icon(
            Icons.favorite,
            color: Colors.pink,
            size: 24.0,
          ),
          Icon(
            Icons.audiotrack,
            color: Colors.green,
            size: 30.0,
          ),
          Icon(
            Icons.beach_access,
            color: Colors.blue,
            size: 36.0,
          ),
        ]),
      ]),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () => {print("押したね？")}, child: const Icon(Icons.timer)),
      // drawer: const Drawer(child: Center(child: Text("Drawer"))),
      // endDrawer: const Drawer(child: Center(child: Text("EndDrawer"))),
    );
  }
}
