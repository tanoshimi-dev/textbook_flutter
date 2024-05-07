---
title: Flutter state management - intro
description: Flutter state management - intro
---
FlutterのFlutterの **状態管理（managementState）** について学びます

Flutterアプリ内でデータ（状態）を更新、参照する際にどのような方式で実施するかを **状態管理（managementState）** といいます。

これはFlutterに限らず、Webでよく使われるSPA（React、Angular、Vue.js）でも重要なものとなります。

従来のWebシステムは、サーバーと通信する度に画面がリフレッシュされ、画面に表示するデータ（状態）が全てリロードされため、状態管理は不要でした。FlutterやSPAのWebは画面がリフレッシュされないため、画面内で状態を保持しておく必要が出てきました。


__ここで学ぶこと__
1. Flutter状態管理の基礎
2. Flutterの代表的な状態管理ソリューション

---

## 1 Flutter状態管理の基礎
Flutterの状態管理の基礎は [公式サイト 状態管理](https://docs.flutter.dev/data-and-backend/state-mgmt/intro) で記載されています

## 2 Flutterの代表的な状態管理ソリューション
代表的な状態管理ソリューションは [公式サイト 状態管理ソリューション](https://docs.flutter.dev/data-and-backend/state-mgmt/options) にリストアップされています。


### 2.1 サマリー

状態管理ソリューションを全て知る必要がありません。実際によく使われるものをまとめます。

以下記載したパッケージはいずれも、公式が推薦 ([Flutter Favorite](https://pub.dev/packages?q=sdk%3Aflutter+is%3Aflutter-favorite) )するものです。

Flutter 状態管理ソリューションの違い
{% table %}
* ソリューション
* メリット
* デメリット
---
* Built-in State Management (setState)
* 
  - シンプル
  - 追加パッケージ不要
* 複雑な状態の管理には不向き
---
* [Provider](https://pub.dev/packages/provider)
* 
  - 比較的理解しやすい
  - 中規模アプリケーション向き 
  - BLoCパッケージより簡素に書ける 
* 
  - 大規模のアプリケーションに不向き 
  - プログラム構造に注意する必要がある

---
* [BLoC](https://bloclibrary.dev/)
* 
  - UIとビジネスロジックを分離できる
  - 大規模アプリケーション向き 
  - 部品を使いまわしできる 
* 
  - 学習コストが高い 
  - Providerと比較してテンプレート（お決まり）の書き方が多い

---
* [Riverpod](https://riverpod.dev/)
* 
  - BLoCより柔軟で機能が豊富
  - データ（状態）参照の際、contextにアクセス不要 
* 
  - 学習コストが高い 
  - BLoCと比較して資料が少ない

---
{% /table %}

### 2.2 コード例

1. **追加パッケージ無し Built-in State Management (StatefulWidget and InheritedWidget)**
    
    Widgeの中でsetStateメソッドで状態を更新します
    ```dart
    class CounterWidget extends StatefulWidget {
      @override
      _CounterWidgetState createState() => _CounterWidgetState();
    }
    
    class _CounterWidgetState extends State<CounterWidget> {
      int _counter = 0;
    
      void _incrementCounter() {
        setState(() {
          _counter++;
        });
      }
    
      @override
      Widget build(BuildContext context) {
        return RaisedButton(
          onPressed: _incrementCounter,
          child: Text('Increment $_counter'),
        );
      }
    }
    ```

2. **Providerパッケージを利用する例**

    ProviderはInheritedWidgetというFlutterの低レベルのクラスをラップして使いやすくしたものです。
    ```dart
    class Counter with ChangeNotifier {
      int _count = 0;
      int get count => _count;
    
      void increment() {
        _count++;
        notifyListeners();
      }
    }
    
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return ChangeNotifierProvider(
          create: (context) => Counter(),
          child: MaterialApp(
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
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => context.read<Counter>().increment(),
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ),
          ),
        );
      }
    }
    ```

3. **BLoC (Business Logic Component)パッケージを利用する例**

    BLoCは状態と状態更新のロジックをUIから分離することができます。
    ```dart
    class CounterBloc {
      final _counterStreamController = StreamController<int>();
      Stream<int> get counterStream => _counterStreamController.stream;
      int _counter = 0;
    
      void increment() {
        _counterStreamController.sink.add(++_counter);
      }
    
      void dispose() {
        _counterStreamController.close();
      }
    }
    
    class MyApp extends StatelessWidget {
      final _bloc = CounterBloc();
    
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: Text('BLoC Example')),
            body: Center(
              child: StreamBuilder<int>(
                stream: _bloc.counterStream,
                initialData: 0,
                builder: (context, snapshot) {
                  return Text(
                    'Counter: ${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _bloc.increment,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ),
        );
      }
    }
    ```


4. **Riverpodパッケージを利用する例**
    
    Riverpodは、Providerの改良版で、より機能が豊富で柔軟な使い方ができます。
    ```dart
    final counterProvider = StateProvider<int>((ref) => 0);
    
    class MyApp extends ConsumerWidget {
      @override
      Widget build(BuildContext context, ScopedReader watch) {
        final counter = watch(counterProvider).state;
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: Text('Riverpod Example')),
            body: Center(
              child: Text(
                'Counter: $counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => context.read(counterProvider).state++,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ),
        );
      }
    }
    ```
