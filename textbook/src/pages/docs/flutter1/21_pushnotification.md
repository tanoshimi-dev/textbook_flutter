---
title: Flutter push notification
description: Flutter push notification
---
今回はPush通知を紹介します。

Firebase Cloud Messaging（FCM）がよく利用されますので、FCMの導入方法を説明します。

---

## 1 Push通知の種類と仕組み

プッシュ通知というと、AppleやGoogleのサーバーへリクエストを出して、端末（iOSやAndroid）でバナーの通知を出すというのが一般的です。しかし、他にも幾つかの種類があります。


[記事1 引用元](https://press.monaca.io/atsushi/16035)
{% table %}
* 通知タイプ
* 特徴
* 配信サービス
---
* リモートプッシュ
* よく知られているプッシュ通知。デバイストークンを使用。
* APNs/FCM
---
* ローカルプッシュ
* アプリ内で通知を作成。サーバー不要。デバイストークンも不要。
* アプリ自体
---
* サイレントプッシュ
* 画面上に表示しない通知。バックグラウンドでデータ更新等に利用。
* APNs/FCM
---
* リッチプッシュ
* URLや画像を表示する。情報量が多い。
* APNs/FCM
---
* Web Push
* Webアプリケーション向け。iPhoneでは、iOS 16.4から対応。
* 各ブラウザのサービス
---
{% /table %}




リモート通知を送りたい場合、端末と直接コネクションを貼るのではなく、Apple や Google が提供するプッシュ通知サーバーに対してプッシュ通知を送信することを依頼します。

Apple は APNs (Apple Push Notification service)、Google は GCM/FCM というサービス名でプッシュ通知サービスを提供しています。

APNs や GCM/FCM は端末との TCP コネクションを貼っており、プッシュ通知の配信を一括して代行しています。


また、プッシュ通知で送信されたデータについては、アプリ側でハンドリングできる場合とできない場合があります。

[記事2 引用元](https://zenn.dev/chocoyama/articles/5b07eead5ae0aa)
{% table %}
* アプリの状態
* ハンドリングできるか
---
* フォアグラウンド
* できる
---
* バックグラウンド
* できない
---
* kill
* できない
---
{% /table %}

- バックグラウンドorKillされた状態では通知をハンドリングすることがそもそもできない
- 「通知をタップしてアプリを起動」してもらえた場合のみ、対象の通知に紐づくデータを取得することができる

## 2 FCMの利用
FMCは次のような特徴があります
- デバイストークンと紐づいたFCMトークンと呼ばれるものをベースに通知対象を制御する。
  そのため、サービスのバックエンドではこのFCMトークンをユーザーに紐づかせた状態で保持することとなる
-  Androidでプッシュ通知を行うにはこれを使う
- 通知送信の細かな実装をFCMが実施してくれるので、導入コストが低い
- 無料で利用可能

[FirebaseのFCM資料公式](https://zenn.dev/chocoyama/articles/5b07eead5ae0aa)
![Program](/flutter/21/diagram-FCM.png "")

導入の手順としては以下の流れです。
1. FCM SDK を設定する
2. クライアント アプリを開発する
3. アプリサーバーを開発する


### 2.1 FCM SDK を設定する

Flutter で Firebase Cloud Messaging クライアント アプリを設定する方法

[FirebaseのFCM資料公式](https://firebase.google.com/docs/cloud-messaging/flutter/client?hl=ja)


### 2.2 クライアント アプリを開発する

Flutter アプリでメッセージを受信する

[FirebaseのFCM資料公式](https://firebase.google.com/docs/cloud-messaging/flutter/receive?hl=ja)

その他参考

[記事3 参考](https://note.shiftinc.jp/n/n97fc26eafc93#74eff2fb-af12-4b42-8e93-f97e8e950a24)

### 2.3 アプリサーバーを開発する

通知メッセージの作成機能をサーバー側で作成します。

Node.jsで記述したサンプルです

Firebase Admin SDKのインストールが必要です
```
var admin = require("firebase-admin");

var serviceAccount = require("path/to/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});
```
上記コードのserviceAccountKey.jsonは、Firebase consoleからダウンロードできるものです。認証情報などが含まれています。

メッセージ送信は以下のように実施します
```
var message = {
  data: {
    score: '850',
    time: '2:45'
  },
  token: registrationToken
};

admin.messaging().send(message)
  .then((response) => {
    console.log('Successfully sent message:', response);
  })
  .catch((error) => {
    console.log('Error sending message:', error);
  });
```

### 2.4 その他の注意点

配信単位について、次の単位が考えられます
- トークンを利用して特定端末に送信
- （Topicをsubscribeした）アプリに一斉送信

前者の場合、ユーザーとトークンとをデータベースで保存して送信時に紐づける必要があります。また、不要なトークンの削除も検討したほうがいいでしょう。

トークンの扱い

[FirebaseのFCM資料公式](https://firebase.google.com/docs/cloud-messaging/manage-tokens?hl=ja)


Cloud Functions
チャットアプリなど、メッセージ配信はバックエンドで個別処理することが多いです。その場合、FirebaseであればCloud Functionsを利用することになります。
![Program](/flutter/21/notify.png "")

※Cloud Functionsの利用は有料です。

[FirebaseのCloud Functions資料公式](https://firebase.google.com/docs/functions/use-cases?hl=ja&authuser=0)

その他、FCM以外にもPush通知がありますので、導入の際は比較検討をおススメします

[サービス比較](https://zenn.dev/sugawara/articles/764e2c25499620)