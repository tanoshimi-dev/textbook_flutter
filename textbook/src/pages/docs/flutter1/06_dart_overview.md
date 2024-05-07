---
title: Dart overview
description: Dart overview
---
Dart 言語の概要をつかみましょう！

_最低限の内容を記載しますが、詳細は必要に応じて[公式サイトのDartページ](https://dart.dev/) を参照ください_


---
## 1 Dartとは
Dartはプログラミング言語の１つです。PHPや、Javaなど様々なプログラミング言語がありますが、その中の１つがDartです。

Flutterは、Dartやツール類一式をひとまとめにしたものになります。

Dartは比較的新しいプログラミング言語なだけあって、既存のプログラミング言語のいいとこどりをしているうように見えます。

JavaScriptのような文法で記載できますが、型に厳密で、TypeScriptのように型定義します。

また、Javaのようなクラス定義ができ、PythonのようなMixin機能を持ちます。

## 2 実行準備
次の章から、Dartプログラムを動かします。

動作環境として、Template Appアプリで動かすか、Webブラウザで動かしてください。

## 2.1 Template App の実行
Template Appを利用します。
前の章では、VS Codeのコマンドパレットからアプリを起動していましたが、ここでは"flutter run"コマンドを使ったアプリの起動例を記載します。

1. 仮想デバイスを起動

   WindowsPCでAndroid Studioのエミュレーターを使った例です
   ![Program](/flutter/6/template_app_1.png "")

   ![Program](/flutter/6/template_app_2.png "")

2. Template Appの修正
   
   VS Codeのターミナルで該当プロジェクト配下で"flutter run"を実行します
   ![Program](/flutter/6/template_app_3.png "")

3. Template Appの実行
   
   エミュレーター内でアプリが起動します
   ![Program](/flutter/6/template_app_4.png "")


4. Template Appの修正して、反映します。

   プログラムを修正します。
   例として、45行目付近の "_exec()" メソッド内を次の通りに変更します。
  
    変更前
    ```
    _output = 'do something else';
    ```

    変更後
    ```
    _output = 'Hello, World!';
    ```

   VS Codeのターミナルで該当プロジェクト配下で[r]キーを押すと、上記の修正内容が hot reloadされます
     ![Program](/flutter/6/template_app_5.png "")

   "Enabled"ボタンを押すと、テキストに"Hello World!"が表示されたら成功です！
    ![Program](/flutter/6/template_app_6.png "")

## 2.2 Webブラウザ (DartPad)

Webブラウザがあれば、PCで環境構築しなくても、簡単にDart言語を試すことができます。

DartPadという、公式サイトがあります。
必要に応じてこちらでDartプログラムを動かす事もできます。

[公式サイトのDartページ](https://dartpad.dev/) 

![Program](/flutter/6/dartpad.png "")



