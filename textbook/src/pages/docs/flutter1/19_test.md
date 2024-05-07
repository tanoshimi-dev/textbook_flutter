---
title: Flutter test & debug
description: Flutter test & debug
---
開発時に使うツールやテストについて説明します。

---

## 1 開発時に使うツール
開発、デバッグ時に使うツールを整理します

### 1.1 Flutter プラグイン

Flutter プラグインを開くと、現在選択しているdartファイルのクラス構成がツリー表示されます。
![Program](/flutter/19/flutter_plugin.png "")


### 1.2 Flutter Dev Tool

DevToolsに様々な情報が表示されます。

Flutter DevToolsの起動方法
 - 1 デバッグモードで起動
 - 2 View -> Command Palette を選択
 - 3 Flutter: Open DevTools を選択
 - 4 Open DevTools in Web Browser を選択

2～4の操作例）
![Program](/flutter/19/flutter_devtools_1.gif "")


Flutter DevToolsをWebブラウザで表示した例）
![Program](/flutter/19/flutter_devtools_2.png "")


## 2 公式推奨テスト手順の説明

Flutter 公式サイトには、単体テスト、結合テストの他、ウイジェットテストが記載されています。

[公式サイト テスト](https://docs.flutter.dev/testing/overview)

ここでは、手っ取り早く、以下のチュートリアルを実施して、テストプロセスを体験しましょう！

[Codelabs](https://codelabs.developers.google.com/codelabs/flutter-app-testing?hl=ja#0)
