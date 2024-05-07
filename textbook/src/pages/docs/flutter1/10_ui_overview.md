---
title: Flutter frontend - UI
description: Building user interfaces with Flutter
---
この章では、FlutterのUI構築の概要を説明します。

[公式サイト](https://docs.flutter.dev/ui) を基にしています。

---
FlutterのUIはWidgetを組み合わせる事で作っていきます。
ユーザーのUI操作により、Widgetの内容を変更する必要がある場合、更新が必要なWidgetをFlutterが自動的に再構築します。

## 1 Hello world
最小限のFlutter アプリです。Widgetの中でrunApp()を実行しています。

※コードを動かして確認したい場合は、公式サイトを使ったり、ご自身のアプリでコードを入力してください。
```
import 'package:flutter/material.dart';

void main() {
  runApp(
    const Center(
      child: Text(
        'Hello, world!',
        textDirection: TextDirection.ltr,
      ),
    ),
  );
}
```
runApp()はWidget階層構造（Widgetツリーといいます）の親となるWidgetを引数に指定します。

上記のコードは、2つのWidgetを使っていますがわかりますか？

Center widgetとText widgetです。

ルートがCenter widgetで子がText widgetになります。


## 2 Basic Widgets
Flutterにはいくつも強力なwidgetが準備されています。以下がその一例です。

- Text
  
  テキストを表示するために利用されます。

- Row, Column

  画面の中でwidgetを横並びや縦並びにするために利用されます。Webページで指定するFlexボックスモデルと同様のものです。

- Stack

  画面の中で横並びや縦並びではなく、特定のwidgetの位置を基準に他のwidgetを配置するために利用されます。
  Webページで指定するposition:absoluteでの配置と同様のものです。

- Container

  四角形のボックスを作り、ボックスの余白や背景などを指定してレイアウトするために利用します。


## 3 Material Componentsの利用
Flutterは[マテリアルデザイン](https://m3.material.io/)のルールに則ったwidgetを複数提供しています。

widgetのルートとしてMaterialApp widgetを用いる事で、マテリアルデザインの基準に沿ったUIを作る事ができます。

MaterialApp widgetはオプションですが、利用することを推奨します。

MaterialAppを使った例です。
```
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Flutter Tutorial',
      home: TutorialHome(),
    ),
  );
}

class TutorialHome extends StatelessWidget {
  const TutorialHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text('Example title'),
        actions: const [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      // body is the majority of the screen.
      body: const Center(
        child: Text('Hello, world!'),
      ),
      floatingActionButton: const FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}
```
AppBar widgetやScaffold widgetsは、material.dartに含まれるwidgetです。
内部のテキストやタイトルは、マテリアルデザインに従って配置、装飾されます。

Material Componentsの詳細は、[Material Components](https://docs.flutter.dev/ui/widgets/material)を参照ください。

{% callout type="warning" title="マテリアルデザイン以外にももう一つ、Cupertino Componentsがあります。こちらは、iOSのデザインを踏襲したものです" %}
{% /callout %}

## 4 Handling gestures
widgetに対するユーザーのアクションを検知することができます。
```
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('MyButton was tapped!');
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.lightGreen[500],
        ),
        child: const Center(
          child: Text('Engage'),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: MyButton(),
        ),
      ),
    ),
  );
}
```
GestureDetector widget は見た目を作ることはありませんが、ユーザーのアクションを検知することができます。

上のコードサンプルでは、ユーザーがContainerをタップするとonTap()が呼び出され、コンソールに文字列を表示します。

GestureDetector widgetを利用するサンプルはたくさんあります。
IconButton, ElevatedButton, and FloatingActionButton widgets などもonPressed()を持っています。

詳細は、[Grstures](https://docs.flutter.dev/ui/interactivity/gestures)を参照ください。

## 5 入力に応じてwidgetを変更する

widgetはStatelessWidgetsと StatefulWidgetsの２種類に分類されます。

StatelessWidgetsは一時的なパラメーターの値に応じて自身のwidgetの見た目を変更します。

StatefulWidgetsはより複雑な状態を基に自信の見た目を変更する場合に利用されます。

ログインユーザーの詳細情報など、アプリケーションで保持しておく状態に応じてwidgetの表示を変える場合などです。

FlutterでUI構築する場合、StatelessWidgetsとStatefulWidgetsの違いは必ず意識しておかなければならない重要な概念です。

### 5.1 TestDriveで確認
実は今まで作ったTestDriveでも両方のWidgetが使われていますので、TestDriveを基に、StatefulWidgetsを説明します。

TestDriveの動きは、+ボタンをクリックする度にカウンタが更新され、画面に数字が現在のカウンタが表示されます。

このカウンタを状態管理しています。
![Program](/flutter/10/ui_state1_testdrive.gif "")

状態（State）を管理するコードは次の箇所です。
![Program](/flutter/10/ui_state2_testdrive.png "")

1. 状態（State）を保持、操作するクラスを作成します。
     
   作成するクラスは、State<MyHomePage> クラス継承します。
     
2. 状態（counter変数）を定義します。

   TestDriveのプログラムでは、_counter です。

3. 状態を操作する関数を定義します。

   void _incrementCounter() です。

4. 現在の状態（counter変数）に応じてwidget内容を更新します。

   Text widget内の文字列がその時点の_counterで更新されます。

5. ボタンを押した際にカウンタを更新するようにします。

   FloatingActionButtonの onPressedに 3で定義した関数を指定しています。こうすることで、ユーザーがボタンを押した際、_incrementCounter()が呼び出され、内部の_counterの値がインクリメントされます。

   内部の状態（_counter）に変更があったため、Flutterが自動的にwidgetを再構築し、文字が更新されます。


StatefulWidgetの中で、状態（State）を利用します。そのコードが次の部分です。
![Program](/flutter/10/ui_state3_testdrive.png "")

1. StatefulWidgetsを継承したクラスを作成します。
   
2. 作成したクラス内で状態（State）を生成します。

   StatefulWidgetクラスで定義されたcreateState() で、１つ前のコード部分の状態（State）クラスを生成し、StatefulWidgetの状態を設定します。

### 5.2 公式サイトのサンプルコードで確認

[公式サイト](https://docs.flutter.dev/ui#changing-widgets-in-response-to-input) でStatefulWidgetを説明したコードがあります。

そのコードを理解して、更にStatefulWidgetとStatelessWidgetの理解を深めましょう！

まず、新しいFlutter Projectを作ってmain.dartを[このコード](https://docs.flutter.dev/ui#bringing-it-all-together) で上書きしてください。

※TestDriveのmain.dartを全て上書きしても問題ありません。

このコードの動きは次の通りです。
![Program](/flutter/10/ui_state4.gif "")

1. StatefulWidgetsを継承したクラスを作成します。
   
2. 作成したクラス内で状態（State）を生成します。

状態（State）を管理するコードは次の箇所です。
![Program](/flutter/10/ui_state5.png "")

1. StatefulWidgetsを継承したクラスを確認します。
   
   ShoppingListクラスが該当します。

2. 作成したクラス内で状態（State）を生成します。

   _ShoppingListStateクラスが該当します。

   **_ShoppingListStateクラス内の処理が複雑なだけで、構成はTestDriveと同じですよね！**

   ※余裕があれば、_ShoppingListStateクラス内の状態操作内容を確認・把握してみてください。

なぜ、StatefulWidgetとStateは別々のオブジェクトなのか？疑問に思われたかもしれません。

Flutterではこれら２つのオブジェクトは別々のライフサイクルを持つからです。
Widgetはその時点の一時的な状態を表示する事を目的にしたオブジェクトなのに対し、Stateは状態を記録しておくためのオブジェクトだからです。

## 6 Keys
Flutterがwidgetを再構築する際、対象widgetを特定するためにKeyを使用します。

Keyは同じ種類のwidgetを複数表示する場合に役立ちます。例えばShoppingList widgetの中にShoppingListItemが複数表示されている状況です。
複数リスト内の特定のリストのみの表示を変更する際に、Keyが使われて対象リストが特定されます。

Keyが指定されている箇所です。
![Program](/flutter/10/ui_state6.png "")


## 7 Global keys
Global Keyは widget構成全体で一意な識別子となります。Global Keyを使用してwidgetに紐づけられた状態を取得することができます。

