---
title: Launch new flutter app
description: After install, launch and run brand new Flutter app
---
Flutter開発環境の構築が終わったら、アプリ開発の準備をしましょう！

ここでは、サンプルプロジェクトを作成して実行するまでを行います。

---
## 1 Test Drive
環境構築が完了したかを確認するめ、簡単なFlutterアプリを作って実行します。
[公式サイト](https://docs.flutter.dev/get-started/test-drive?tab=vscode) を基に、ポイントを記載します。


__ここで学ぶこと__
1. Flutterアプリの新規作成
2. Flutterアプリの実行
3. プログラムを変更した後の"hot reload" 

_利用するIDEによって、実行方法が異なります。ここではVS Codeを使った例を記載します_

### 1.1 Flutterアプリの新規作成
1. **コマンドパレット**を開き、[Command] + [Shift] + [P] キーを押す
2. **コマンドパレット**で、"flutter"と入力
3. **Flutter: New Project**を選択
4. プロジェクトの保存場所を指定します。プロンプトが表示されたら、"Application"を選択してください
5. 作成するプロジェクトを保存するフォルダを作り、そのフォルダを選択してください
6. プロジェクトの名称を指定します。プロンプトが表示されたら、"test_drive"と入力してください
7. [Enter]キーを押してください
8. 自動でFlutterのプロジェクトが作成されます。
9. プロジェクトが作成されたら、"lib"ディレクトリの中に"main.dart"が作成されています。

上記の操作で"test_drive"というディレクトリに新しいFlutterプロジェクトを作成したことになります。

### 1.2 Flutterアプリの実行
デスクトップ、Chromeウェブブラウザ、iOSシミュレーターまたはAndroidエミュレーターで実行できます。
{% callout type="warning" %}
Webブラウザで実行した場合、現時点ではhot reload機能は使えません。
{% /callout %}
1. **コマンドパレット**を開き、[Command] + [Shift] + [P] キーを押す
3. **コマンドパレット**で、"flutter"と入力
4. **Flutter: Select Device**を選択

    実行するデバイスが無い場合は、先に有効にしてください
5. **Select Device** でアプリを実行するターゲットデバイスを選択
6. ターゲットデバイスを選択後、 Run > Start Debugging メニューを選択するか [F5]キーを押してください.
7. アプリが起動されます
    **Debug Console** viewに起動状況が表示されます。
   
   選択したデバイスでアプリが起動します。
![App](/flutter/5/official_starter-app.png "")


### 1.3 "hot reload" の実行
Flutterは、開発効率を上げるため、アプリ起動中にプログラムを修正すると、修正内容がアプリに即時反映される "hot reload" 機能を持っています。

1. lib/main.dart フォルダを開く
2. "push"という単語を"clicked"に変更してください。
    
    main.dartファイルの109行目です。

    **変更前**
    'You have pushed the button this many times:'
    
    ↓
    
    **変更後**
    'You have clicked the button this many times:'

    {% callout type="warning" %}
     重要: アプリを停止せず、起動したままでファイルを変更してください。
    {% /callout %}

3. ファイルを保存するか、[⚡]マークを押します

   アプリに変更内容が反映されます。
![App](/flutter/5/official_starter-app-hot-reload.png "")

   なお、VS Codeの拡張機能の設定で、hot reload 機能をoffにすることもできます
![Hot Reload Off](/flutter/5/hotreload_off.png "")


## 2 Template App
次章以降のDartやWidgetの確認用に、新しいアプリを作成します。

__ここで実施すること__
1. Flutterアプリの新規作成
2. 以降の教材でプログラムを動かすため、プログラムの一部を修正します

### 2.1 Flutterアプリの新規作成
1. 1の手順と同じように、プロジェクトを新規作成してください

   プロジェクト名は任意ですが、ここでは"dart_learning"とします。

### 2.2 プログラムの修正
1. プログラムの一部を追加、修正します。
    ![Program](/flutter/5/dart_learning.png "")

2. 動作確認
 
    "Enabled"のボタンを押すと、中央のテキスト文言が変わればOKです。
    "+"ボタンを押したときの動きは元のままです。
    
    ![Program](/flutter/5/dart_leaning_movie.gif "")
