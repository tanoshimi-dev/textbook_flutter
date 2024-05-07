---
title: Install Flutter on Mac
description: Start building Flutter iOS apps on macOS
---
MacにFlutterをインストールします。
[公式サイトのInstall方法](https://docs.flutter.dev/get-started/install/macos/mobile-ios) を基に、ポイントを記載します。


---
## 1 システム要件
macOSでFlutterを実行するために、ハードウェア、ソフトウェアの要件を満たす必要があります。

### 1.1 ハードウェア
最低限のハードウェア要件です。
{% table %}
* Requirement
* Minimum
* Recommended
---
* CPU Cores
* 4
* 8
---
* メモリ GB
* 8
* 16
---
* ディスプレイ解像度 pixels
* WXGA (1366 x 768)
* FHD (1920 x 1080)
---
* 空きDisk容量 GB
* 44.0
* 70.0
---
{% /table %}

### 1.2 ソフトウェア
FlutterでiOSアプリのプログラムを書くために、次のものが必要です。

#### **OS** 
macOS 10.15 (Catalina) 以上で、デフォルトシェルはzshを想定しています。

また、**Apple Silicon**ではいくつかのコンポーネントが **Rosetta2 translation process**を必要とします。

次のコマンドで**Rosetta2**をインストールしてください。
```
sudo softwareupdate --install-rosetta --agree-to-license
```

#### **開発者ツール** 
以下のツールをダウンロードしてください。
- [Xcode](https://developer.apple.com/xcode/) 15 SwiftやObjectiveCコードをコンパイル、デバッグするツール
- [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#installation) 1.13 Flutter プラグインを通常のiOSアプリで利用できるようにするツール

_インストール等で問題が発生した場合、各ツールのドキュメントを参照してください。_


#### **テキストエディター or IDE** 
Flutterアプリ開発ではどのようなエディターやIDE、IDE用Flutterプラグインを使えます。

人気の組み合わせ
- [Visual Studio Code](https://code.visualstudio.com/docs/setup/mac) 1.77以上、拡張機能[Flutter extension for VS Code](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)
- [Android Studio](https://developer.android.com/studio/install) 2023.1 (Hedgehog) 以上、プラグイン[Flutter plugin for IntelliJ](https://plugins.jetbrains.com/plugin/9212-flutter) 
- [IntelliJ IDEA](https://www.jetbrains.com/help/idea/installation-guide.html) 1.77以上、プラグイン[Flutter plugin for IntelliJ](https://www.jetbrains.com/help/idea/installation-guide.html)、[ Android plugin for IntelliJ](https://plugins.jetbrains.com/plugin/22989-android)

{% callout type="warning" title="FlutterチームはVisual Studio Code1.77以上、Flutter extension for VS Codeの組み合わせ" %}
{% /callout %}


## 2 Flutter SDKのインストール
VSCodeの拡張機能VS Code Flutter extensionを利用したFlutter SDKのインストール手順は以下の通りです。

_バンドル版のインストール方法は [公式サイト](https://docs.flutter.dev/get-started/install/macos/mobile-ios?tab=physical#configure-your-target-ios-device)を参照してください。_

### Prompt VS Code to install Flutter

1. VS Codeを起動
2. **コマンドパレット**を開き、[Command] + [Shift] + [P] キーを押す
3. **コマンドパレット**で、"flutter"と入力
4. **Flutter: New Project**を選択
5. VS Code のプロンプトでインストール場所を指定してください
    
    a. Flutter SDKがインストールされていれば、**SDKの場所**を指定
    
    b. Flutter SDKがインストールされていなければ、**ダウンロード**を指定
    
6. もし**Which Flutter template?** などのプロンプトが表示された場合は、[Esc]キーを押して無視してください。後で作成します。


### Download the Flutter SDK
1. フォルダ選択ダイアログで、Flutterをインストールする場所を指定してください
2. **Clone Flutter**を押す
   ダウンロード中は、VS Codeが次のようなPOPUP通知を出します。
    ```
    Downloading the Flutter SDK. This may take a few minutes.
    ```
    ダウンロードは数分かかります。ハングアップした場合は**Cancel** 再度実行してください。

3. ダウンロードが終わったら**Output** パネルに以下のような表示がされます。
    ```
    Checking Dart SDK version...
    Downloading Dart SDK from the Flutter engine ...
    Expanding downloaded archive...
    ```
    その後、VS Codeが次のようなPOPUP通知を出します。
    ```
    Initializing the Flutter SDK. This may take a few minutes.
    ```
    続けて**Output** パネルに以下のような表示がされます。
    ```
    Building flutter tool...
    Running pub upgrade...
    Resolving dependencies...
    Got dependencies.
    Downloading Material fonts...
    Downloading Gradle Wrapper...
    Downloading package sky_engine...
    Downloading flutter_patched_sdk tools...
    Downloading flutter_patched_sdk_product tools...
    Downloading windows-x64 tools...
    Downloading windows-x64/font-subset tools...
    ```
    Flutterのインストールが成功すると、VS Codeが次のようなPOPUP通知を出します。
    ```
    Do you want to add the Flutter SDK to PATH so it's accessible
    in external terminals?
    ```
4. VS Codeが Google Analytics noticeを表示します

    **OK** を押します

5. 全てのターミナルウインドウでflutterコマンドを使えるようにします
    
    a. 全てのターミナルウインドウを閉じて、再度開いてください
    
    b. VS Codeを再起動してください

## 3 iOS開発の設定

### 3.1 Xcode
iOS用のアプリを作成するために、Xcodeをインストールしてください。その後以下の手順で設定を行います。

1. ターミナルなどのコマンドラインツールでインストールされたXcodeのバージョンを確認します
    ```
    sudo sh -c 'xcode-select -s /Applications/Xcode.app/Contents/Developer && xcodebuild -runFirstLaunch'
    ```
2. Xcode ライセンスに署名します
    ```
    sudo xcodebuild -license
    ```

### 3.2 iOSシミュレーターの設定
Xcodeを使って、Flutterアプリをシミュレーターで実行します。

_実機での実行方法は [公式サイト](https://docs.flutter.dev/get-started/install/macos/mobile-ios?tab=physical#configure-your-target-ios-device)を参照してください。_

1. iOSシミュレーターをインストールします。コマンドラインで以下を実行してください。
    ```
    xcodebuild -downloadPlatform iOS
    ```
2. iOSシミュレーターを開始します。コマンドラインで以下を実行してください。
    ```
    sudo xcodebuild -license
    ```
3. シミュレーターで64bitの仮想デバイスを使うため、iPhone5s以上の設定を実施します
    
    - **Xcode** から、シミュレーター device typeを選択します

        1. **Window > Devices and Simulators** のメニューを選択
           
           [Cmd] + [Shift] + [2]キーのショートカットでも実行できます
        2. **Devices and Simulators** デバイスが表示されたら、**Simulators** を選択します
        3. 左のリストから **Simulator** を選択するか、[+]ボタンを押します

    - **Simulator** アプリから **File > Open Simulator >** から起動する仮想デバイスを指定します
    - Simulatorのバージョンを確認する場合は、**Settings app > General > About** のメニューを選択します

4. iOS仮想デバイスが画面幅を超えてオーバーフローするかもしれません。その場合は、**Simulator** appからウインドウサイズを変更します
    {% table %}
    * Display Size
    * Menu command
    * Keyboard shortcut
    ---
    * Small
    * **Window > Physical Size**
    * [Cmd] + [1]
    ---
    * Moderate
    * **Window > Point Accurate**
    * [Cmd] + [2]
    ---
    * Small
    * **Window > Pixel Accurate**
    * [Cmd] + [3]
    ---
    * Small
    * **Window > Fit Screen**
    * [Cmd] + [4]
    ---
    {% /table %}


### 3.3 CocoaPodsをインストール
iOS用のアプリでFlutterのプラグインを利用するために、**CocoaPods**をインストールします
インストールや設定はターミナルを利用します

1. **cocoapods** インストールします。 _必要に応じて、 [公式サイト](https://guides.cocoapods.org/using/getting-started.html#installation)を参照してください。_
    ```
    sudo gem install cocoapods
    ```
2. 任意のテキストエディタを起動してください
3. テキストエディタで環境設定ファイル "~/.zshenv" を開いてください
4. "~/.zshenv"の末尾に以下の行をコピー＆ペーストしてください
    ```
    export PATH=$HOME/.gem/bin:$PATH
    ```
5. 編集した"~/.zshenv" を保存してください
6. 変更内容を適用するために、ターミナルを再起動してください

## 4 セットアップ確認

### 4.1 Flutter doctorの実行
**flutter doctor** コマンドを実行し、上記のセットアップが正しく実施されたかを確認してください。

1. ターミナルを開いてください
2. 以下のコマンドを実行してください
    ```
    flutter doctor
    ```
実行結果は次のように表示されますが、全てを設定を完了させる必要はありません。
```
Running flutter doctor...
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.19.3, on macOS 14.4.0 23E214 darwin-arm64, locale en)
[!] Android toolchain - develop for Android devices
[!] Chrome - develop for the web
[✓] Xcode - develop for iOS and macOS (Xcode 15)
[!] Android Studio (not installed)
[✓] VS Code (version 1.86)
[✓] Connected device (1 available)
[✓] Network resources


! Doctor found issues in 3 categories.
```
### 4.2 トラブルシュート
**flutter doctor** コマンドでエラーになった場合、Flutter、VS Code、Xcode、等の設定が考えられます。

  **flutter doctor** コマンドを、"-v"を付けて再実行してみてください。詳細な情報が表示されます。

```
flutter doctor -v
```
エラーとならなかった場合でも、Flutter SDKやその他の設定を変更した際は、**flutter doctor** コマンドを再実行して、設定が正しいかを確認してください。


### 4.3 FlutterでiOS開発
おめでとうございます！Flutter開発環境のセットアップが完了しました。


