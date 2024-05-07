---
title: Flutter frontend - sample app 01
description: Flutter frontend 
---
いよいよ画面作りを始めます！
ここでは簡単な画面作りを実施します

__ここで学ぶこと__
1. Flutterの画面作りで重要なWidgetの使い方を把握する
2. アプリの作成と実行方法を把握する

---

## 1 準備
はじめに、Widgetとは何かを確認します

1. Flutter createコマンドでプロジェクト作成

   VSCodeのターミナルで以下を実行してください
    ```
    flutter create sample01
    ```
    コマンド実行後、sample01フォルダが自動生成され、その中にデフォルトのアプリが作成されます

2. アプリ実行
  ターミナルでsample01ディレクトリに移動し、flutter runコマンドを実行してください
  
    1. 仮想デバイスでエミュレーターを起動してください
    2. VS Codeのターミナルでsample01ディレクトリに移動してください
       ```
       cd sample01
       ```
    3. VS Codeのターミナルでsample01アプリを実行してください
        ```
        flutter run
        ```
        ![Program](/flutter/9/sampleapp01_1.png "")

3. ソースコードと画面の構成確認

   buildメソッド内のScaffoldにAppBar/Center/FloatingActionButtonの3つのWidgetがあり、さらにその下に別のWidgetが入っていることがわかります。
   
   Widgetの関係はツリー構造となっており、親Widgetの配下に子Widgetを配置することで画面を構築していきます。
   
   ソースコードと画面とデータ構造に色付けをして対応づけると、下図のようになっています。

   ソースコード
    ![Program](/flutter/9/sampleapp01_2.png "")

   画面
    ![Program](/flutter/9/sampleapp01_3.png "")
  
   データ構造
    ![Program](/flutter/9/sampleapp01_4.png "")


   Widgetは、画面を構成するパーツですが、単純に画面に表示されるテキストやボタンだけではなく、CenterやColumnのように子Widgetにレイアウト情報などの属性を与えるWidgetもあります。カウンタアプリは、Centerを親に持つTextのWidgetがあるため、画面の中央に文字列が表示されています。

   Flutterでは、このようにWidgetを組み合わせて画面を構築します。

## 2 開発
Widgetが何かをつかめたところで、画面部品を増やしていきましょう！

まず、一番よく使うbodyの部分をカスタマイズしながら画面の変化を見ていきます。

### 2.1 bodyにWidgetを追加する
まず、一番よく使うbodyの部分をカスタマイズしながら画面の変化を見ていきます。
   1. 文字列を表示する
      
       最初に、bodyの部分を一番シンプルなTextのみに変えてみます。
      ![Program](/flutter/9/sampleapp01_5.png "")
      ![Program](/flutter/9/sampleapp01_6.png "")   
   2. 2行目に文字列を表示する

      次に、もう1つTextをたしてみます。
      ![Program](/flutter/9/sampleapp01_7.png "")
      ![Program](/flutter/9/sampleapp01_8.png "")
      bodyに、直接Textを2つ配置することはできないので、「Widgetを縦に並べる」ColumnというWidgetをbodyに設定し、Columnの下に2つのTextを配置します。
      
      Columnは縦にWidgetを配置する「行を実現するWidget」です。childrenにどのWidgetを並べるかを配列で指定します。今回は2つのTextがColumnの子要素となります。
      
      なお、childrenは配列を指定しますが、要素が1つだけでも利用できます

   3. 3行目にボタンをたす

       次に、3行目にTextButtonというボタンをたしてみます。
      ![Program](/flutter/9/sampleapp01_9.png "")
      ![Program](/flutter/9/sampleapp01_10.gif "")
      3行目にボタンが配置されました。
      TextButtonでは、onPressedとchildの2つの要素を指定しています。
       onPressed は、ボタンが押された時のイベントを設定するものです。今回はシンプルにターミナルに文字列を表示するようにしています。childには、画面上に表示する文字列(TextのWidget)を指定しています。
      画面上のボタンをタップするたびに、ターミナルに「ボタンが押されました」の文字が表示されます。

   4. 4行目に3個のアイコンを配置する
       
       最後に、4行目にアイコンを3個配置します。
      ![Program](/flutter/9/sampleapp01_11.png "")
      ![Program](/flutter/9/sampleapp01_12.png "")
       4行目に3個のアイコンが増えました。
       
       Rowは横にWidgetを配置する「列を実現するWidget」です。childrenに配列で3つのIconを与えています。
       
       なお、Rowのプロパティで指定しているmainAxisAlignment: MainAxisAlignment.spaceAroundは列の要素を等間隔で表示するというプロパティ値です。3つのアイコンが横幅に対して均等に配置されていることがわかるかと思います。
       
       IconのWidgetはchildやchildrenは持たず、アイコン、色、サイズを設定するものになっています。

       ちなみに、アイコンのこちらに定義されています。
       [Dart API Icon class](https://api.flutter.dev/flutter/material/Icons-class.html)

### 2.2 body以外にWidgetを追加する
今度は、body以外に目を向けてみます。

カウンタアプリのScaffoldには、bodyの他にもappBarやfloatingActionButtonもあります。

名前が似ており紛らわしいのですが、appBarやfloatingActionButtonがScaffoldのプロパティ名で、AppBarやFloatingActionButtonが実際に設定するWidget名になります。

   1. AppBarにWidgetを追加する
      
      AppBarは画面上部のアプリバーを設定できます。アイコンをつけてタイトルも変更してみます。
      ![Program](/flutter/9/sampleapp01_13.png "")
      ![Program](/flutter/9/sampleapp01_14.png "")
       
       タイトル部分が変わりました。

       titleに設定されているRowは、先程アイコンを横に並べたところで使ったものと同じで、1行に複数のWidgetを表示するために用いています。
       
       今回は、鉛筆のアイコンと「初めてのタイトル」のテキストを並べるために用いています。

   2. FloatingActionButtonにWidgetを追加する

      FloatingActionButtonは、画面の右下最前面に表示されるボタンを作成できます。
      ![Program](/flutter/9/sampleapp01_15.png "")
      ![Program](/flutter/9/sampleapp01_16.png "")
       右下に、タップするとターミナルに文字列が出力されるボタンを作れました。
       
       onPressedはTextButtonのところでも出てきましたが、ボタンが押された時に呼ばれるイベントです。
       
       childには、ボタンに表示するアイコンを設定しています。
   
   3. DrawerにWidgetを追加する

      最後に、カウンタアプリにはでてこなかったdrawerとendDrawerを設定してみます。
      
      drawerとendDrawerは、画面の左右半分程度に表示されるサイドメニューのことです。
      drawerは左側、endDrawerは右側に表示させたい場合に使います。
     
      ![Program](/flutter/9/sampleapp01_17.png "")
      ![Program](/flutter/9/sampleapp01_18.gif "")
      
      drawerとendDrawerに、それぞれTextをCenterで表示するDrawerを与えています。Centerはカウンタアプリでも使っていますが、上下左右の中央にWidgetを表示する機能を子Wigetに提供します。


