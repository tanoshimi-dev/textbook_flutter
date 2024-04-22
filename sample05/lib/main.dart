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

Future<Map<String, dynamic>?> callApiHello() async {
  // Add a return statement at the end
  try {
    // エミュレーターから（ローカルPC内の）dockerコンテナへのアドレスは10.0.2.2となる
    final response =
        await http.get(Uri.parse('http://10.0.2.2:15011/api/hello')).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        throw TimeoutException('The connection has timed out!');
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to call api');
    }
  } on TimeoutException catch (e) {
    // Handle the timeout exception
    print(e.message);
    return null;
  } catch (e) {
    // Handle any other exceptions
    print(e);
    return null;
  }
}

Future<List<Map<String, dynamic>>> callApiMessages() async {
  // Add a return statement at the end
  try {
    // エミュレーターから（ローカルPC内の）dockerコンテナへのアドレスは10.0.2.2となる
    final response =
        await http.get(Uri.parse('http://10.0.2.2:15011/api/messages')).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        throw TimeoutException('The connection has timed out!');
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      var data = jsonResponse['data'];
      // print(data);
      // print(data.length);
      List<Map<String, dynamic>> dataList =
          List<Map<String, dynamic>>.from(data);

      // Now you can iterate over dataList
      for (var item in dataList) {
        //print(item);
        // item.forEach((key, value) {
        //   print('Key: $key, Value: $value');
        // });
        print('item message=${item['message']} number=${item['number']}');
      }
      return dataList;
    } else {
      // If the server returns an unexpected response, throw an error.
      throw Exception('Unexpected response from the server!');
    }
  } on TimeoutException catch (e) {
    // Handle the timeout exception
    print(e.message);
    return [];
  } catch (e) {
    // Handle any other exceptions
    print(e);
    return [];
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
  late Future<Map<String, dynamic>?> apiHello;
  late Future<List<Map<String, dynamic>>>? apiMessages;

  // ローディング中かどうかを示すフラグ
  bool isApiHelloLoading = false;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(_counter);
    apiHello = callApiHello() as Future<Map<String, dynamic>?>;
    apiMessages = callApiMessages();
  }

  void _reFetch() {
    setState(() {
      _counter++;
      futureAlbum = fetchAlbum(_counter);
    });
  }

  // APIを呼び出す関数
  void _callApiHello() {
    setState(() {
      isApiHelloLoading = true;
    });

    apiHello = callApiHello() as Future<Map<String, dynamic>?>;

    apiHello!.then((_) {
      setState(() {
        isApiHelloLoading = false;
      });
    });
  }

  // APIを呼び出す関数
  void _callApiMessages() {
    setState(() {
      apiMessages = callApiMessages();
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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // jsonplaceholderへの通信
              Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('You have pushed the button this many times:'),
                      ElevatedButton(
                          onPressed: _reFetch, child: const Text('Press Me')),
                      Center(
                          child: FutureBuilder<Album>(
                        future: futureAlbum,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasData) {
                            return Text(snapshot.data!.title);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                          // return const CircularProgressIndicator();
                        },
                      )),
                    ]),
              ),
              const SizedBox(height: 16.0),
              Center(
                // dockerコンテナへの送信
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('You have pushed the button this many times:'),
                      ElevatedButton(
                          onPressed: _callApiHello,
                          child: const Text('Press Me')),
                      if (isApiHelloLoading)
                        CircularProgressIndicator()
                      else
                        FutureBuilder<Map<String, dynamic>?>(
                          future: apiHello,
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
                    ]),
              ),

              const SizedBox(height: 16.0),
              // dockerコンテナへの送信
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('You have pushed the button this many times:'),
                ElevatedButton(
                    onPressed: _callApiMessages, child: const Text('Press Me')),
                const SizedBox(height: 8.0),
                SingleChildScrollView(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: apiMessages,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Show a loading spinner while waiting
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error: ${snapshot.error}'); // Show error message if something went wrong
                      } else {
                        // Build a ListView to display the data
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(snapshot.data![index]['message']),
                              subtitle: Text(
                                  'Number: ${snapshot.data![index]['number']}'),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ]),
              //)
            ],
          ),
        ),
      ),
    );
  }
}
