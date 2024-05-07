---
title: Flutter backend - mobile backend features 
description: Flutter backend - mobile backend features
---
前回はバックエンドとの通信方法を学びました。

Webシステムと同様、モバイルアプリのデータ管理や機能は、バックエンド側のシステムが担うの理想的である事を説明しました。

モバイルアプリのバックエンドは、よく使われる機能がある程度限定されているため、モバイル専用のバックエンドサービス（MBaaS）などが利用される事も多いです。

今回は、モバイルバックエンドサービスや、その中でよく使われるデータベースの形式等を学んだ後、Flutter[公式サイト codelabs](https://firebase.google.com/codelabs/firebase-get-to-know-flutter?hl=ja#0)のアプリをハンズオン形式で作成します。


__ここで学ぶこと__
1. Baas（MBaaS）
2. データベースの種類
3. API方式
4. Firebaseを使ったサンプルアプリのハンズオン

---

## 1 Baas（MBaaS）
Baas（MBaaS）どういったメリットがあるかつかめる記事をまとめました。

- [記事1 MBaaSメリット](https://gloriumtech.com/mobile-app-backend-development/)
- [記事2 ニフクラの資料](https://mbaas.nifcloud.com/about.htm)
- [記事3 MBaaS比較](https://press.monaca.io/atsushi/13891)
- [Firebase](https://firebase.google.com/?hl=ja)
- [Supabase](https://supabase.com/)



## 2 データベースの種類
データベースの種類は大きくRDBとNoSQLに分かれます。

NoSQLはモバイルアプリのデータベースとして使われるケースも多いです。

- [RDBとNoSQLの違い](https://business.ntt-east.co.jp/content/cloudsolution/column-338.html)


## 3 API方式
前回ご紹介したバックエンドとの通信では、一般的なREST APIという方式を前提としていました。

最近はGraphQLという方式で通信するケースも増えています。

- [GraphQLの概要](https://hasura.io/learn/ja/graphql/intro-graphql/graphql-vs-rest/)

- [FlutterでGraphQLを使うためのパッケージ](https://pub.dev/packages/graphql_flutter)


## 4 Firebaseを使ったサンプルアプリのハンズオン

ここでは、モバイルバックエンドのアーキテクチャー、モバイルバックエンドで一番手軽に試せるFirebaseを試します。
- [codelabs](https://firebase.google.com/codelabs/firebase-get-to-know-flutter?hl=ja#0)
