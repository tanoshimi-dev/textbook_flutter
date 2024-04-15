import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum(id) async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
      } =>
        Album(
          userId: userId,
          id: id,
          title: title,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

Future<Map<String, dynamic>> callApi() async {
  final response =
      // エミュレーターから（ローカルPC内の）dockerコンテナへのアドレスは10.0.2.2となる
      await http.get(Uri.parse('http://10.0.2.2:15011/api/hello'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to call api');
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 1;
  late Future<Album> futureAlbum;
  late Future<Map<String, dynamic>>? apiMessage;

  // ローディング中かどうかを示すフラグ
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(_counter);
    apiMessage = callApi();
  }

  void _reFetch() {
    setState(() {
      _counter++;
      futureAlbum = fetchAlbum(_counter);
    });
  }

  // APIを呼び出す関数
  void _callApi() {
    setState(() {
      isLoading = true;
    });

    apiMessage = Future.delayed(Duration(seconds: 0), () => callApi());

    apiMessage!.then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // jsonplaceholderへの通信
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('You have pushed the button this many times:'),
                        FutureBuilder<Album>(
                          future: futureAlbum,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data!.title);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }

                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          },
                        ),
                      ]),
                ),
                ElevatedButton(
                    onPressed: _reFetch, child: const Text('Press Me')),
                Padding(
                  // dockerコンテナへの送信
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('You have pushed the button this many times:'),
                        if (isLoading)
                          CircularProgressIndicator()
                        else
                          FutureBuilder<Map<String, dynamic>>(
                            future: apiMessage,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data!.toString());
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              } else {
                                return SizedBox.shrink(); // Empty widget
                              }
                            },
                          ),
                        ElevatedButton(
                            onPressed: _callApi, child: const Text('Press Me')),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
