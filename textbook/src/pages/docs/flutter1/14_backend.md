---
title: Flutter backend - networking & http
description: Flutter backend - networking & http
---
バックエンドシステムとの連携を学習します。

アプリのデータは全てデータベースに保存されるのが一般的です。
FlutterからバックエンドシステムへHttpでリクエストを送信し、バックエンドシステム側でデータベースのデータ取得・更新を行います。

Flutterから直接データベースにアクセスして操作することも可能です。
![Program](/flutter/14/db_connection1.png "")


但し、これは良い設計ではありません。なぜかわかりますか。
通常は次の構成にします。
![Program](/flutter/14/db_connection2.png "")


ここでは、Flutterからバックエンドシステムと通信する方法を学びます。


---

## 1 Httpパッケージ関連
Flutter[公式サイト](https://docs.flutter.dev/data-and-backend/networking)

## 2 オリジナル
ご自身のPCでバックエンドのサンプルを動かして、Flutterバックエンドとの連携を作ってみてください。
[Githubリポジトリ](https://github.com/tanoshimi-dev/textbook_flutter/tree/main/inifra/backend_laravel)

