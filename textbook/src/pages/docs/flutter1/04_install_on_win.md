---
title: Install Flutter on Windows
description: Start building Flutter Android apps on Windows
---
WindowsにFlutterをインストールします。
[公式サイトのInstall方法](https://docs.flutter.dev/get-started/install/windows/mobile?tab=vscode) を基に、ポイントを記載します。


---
## 1 システム要件
AndroidでFlutterを実行するために、ハードウェア、ソフトウェアの要件を満たす必要があります。

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
* 11.0
* 60.0
---
{% /table %}

### 1.2 ソフトウェア
FlutterでAndroidアプリのプログラムを書くために、次のものが必要です。

#### **OS** 
Windows10以上、**Windows PowerShell** 5.0以上が必要です。

#### **開発者ツール** 
以下のツールをダウンロードしてください。
- [Git for Windows](https://gitforwindows.org/) 2.27以上
- [Visual Studio 2022](https://learn.microsoft.com/ja-jp/visualstudio/install/install-visual-studio?view=vs-2022) Desktop development with C++か [Build Tools for Visual Studio 2022](https://visualstudio.microsoft.com/ja/downloads/)  

  Windowsアプリを作成するために必要です。
  (Visual Studio Code には上記が含まれていないので注意してください。)

- [Android Studio](https://developer.android.com/studio/install) 023.1 (Hedgehog)以上

  Androidアプリを作成するために必要です。
- 最新の[Google Chrome](https://www.google.com/chrome/dr/download/) 

  Webアプリを作成するために必要です。

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

_バンドル版のインストール方法は [公式サイト](https://docs.flutter.dev/get-started/install/windows/mobile?tab=download#install-the-flutter-sdk)を参照してください。_

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
   {% callout type="warning" title="半角スペースが含まれるフォルダ名C:Program Filesなどを指定しないでください" %}
   {% /callout %}
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
4. **Add SDK to PATH** を押してください
    成功すると、VS Codeが次のようなPOPUP通知を出します。
    ```
    The Flutter SDK was added to your PATH
    ```
5. VS Codeが Google Analytics noticeを表示します

    **OK** を押します

6. 全てのPowerShellウインドウでflutterコマンドを使えるようにします
    
    a. 全てのPowerShellウィンドウを閉じて、再度開いてください
    
    b. VS Codeを再起動してください

## 3 Android開発の設定

### 3.1 Android Studioで Androidコンポーネントインストールします
Android用のアプリを作成するため、次のAndroidコンポーネントがインストールされている必要があります

初めてAndroid Studioを起動する方は以下の手順でインストールします。

_Android Studioを既に使っている方は [公式サイト](https://docs.flutter.dev/get-started/install/windows/mobile?tab=later-start)を参照してください。_

1. **Android Studio** を起動してください
2. **Android Studio Setup Wizard** に進みます
3. 次のコンポーネントをインストールしてください
- **Android SDK Platform, API 34.0.0**
- **Android SDK Command-line Tools**
- **Android SDK Build-Tools**
- **Android SDK Platform-Tools**
- **Android Emulator**

### 3.2 Androidエミュレーターの設定
Flutterアプリをエミュレーターで実行します。次の手順でエミュレーターを設定してください。

_実機での実行方法は [公式サイト](https://docs.flutter.dev/get-started/install/windows/mobile?tab=physical)を参照してください。_

1. PCで[VM acceleration](https://docs.flutter.dev/get-started/install/windows/mobile?tab=physical)を有効化してください
2. **Android Studio** を起動します
3. **Settings** ダイアログで **SDK Manager** を確認します
    
    1. 既にプロジェクトが開かれていたら、**Tools > Device Manager** 
    2. **Welcome to Android Studio** ダイアログが表示されていたら、**More Options** をクリックして更に表示させ、ドロップダウンメニューの**Device Manager**を押します

4. **Virtual** をクリックします
5. **Create Device** をクリックします

     **Virtual Device Configuration** ダイアログが表示されます
6. **Category** メニューの下の **Phone** か **Tablet** を選択します
7. デバイス定義を選択してください
8. **Next** をクリックします
9. **x86 Images** をクリックします
10. エミューレーターで起動したいシステムイメージを１つクリックしてください
    
    a. ダウンロードアイコンが表示されたらクリックしてください
    b. ダウンロードが完了したら **Finish** をクリックしてださい
11. **Next** をクリックします

     **Virtual Device Configuration** ダイアログが表示されます
12. 仮想デバイス Android Virtual Device(AVD)の名前を変更する際は、**AVD Name** ボックスの中に入力します
13. **Show Advanced Settings** をクリックして **Emulated Performance** までスクロールします
14. **Graphics** のドロップダウンメニューから **Hardware - GLES 2.0** を選択してください

    これで[hardware acceleration](https://developer.android.com/studio/run/emulator-acceleration)を有効化して画面描画のパフォーマンスを向上させる事ができました
15. AVD設定が問題なければ、**Finish** をクリックしてください

    AVDについて更に知りたい場合は[Managing AVDs](https://developer.android.com/studio/run/managing-avds?hl=ja)を参照ください
16. Device Managerダイアログで RunアイコンをクリックするとAVDが起動します

### 3.3 Android licensesに同意する
上記で必要なものをインストールした後は、Android licensesに同意する必要があります

1. コマンドプロンプトやVS Codeのターミナルを開いてください
2. 次のコマンドを実行して、ライセンスに同意してください
    ```
    flutter doctor --android-licenses
    ```
    もし、既に同意されていたら、次のように表示されます
    ```
    [========================================] 100% Computing updates...
     All SDK package licenses accepted.
    ```
    次のステップをスキップできます
3. ライセンスに同意します


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
