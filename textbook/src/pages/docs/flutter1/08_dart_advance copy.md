---
title: Dart overview
description: Dart overview
---
Dart 言語の概要をつかみましょう！
[公式サイトのDartページ](https://dart.dev/overview) を基に、ポイントを記載します。


---
Dartは比較的新しいプログラミング言語なだけあって、既存のプログラミング言語のいいとこどりをしているうように見えます。

JavaScriptのような文法で記載できますが、型に厳密で、TypeScriptのように型定義します。

また、Javaのようなクラス定義ができ、PythonのようなMixin機能を持ちます。

## 1 重要
[公式サイトのDartページ](https://dart.dev/language) 公式サイトを基にDart言語の書き方をつかんでください

### 1.1 Hello World
### 1.2 Variables（変数）
### 1.3 Variables（変数）
### 1.4 Variables（変数）
### 1.5 Variables（変数）
### 1.6 Variables（変数）
### 1.7 Variables（変数）
### 1.8 Variables（変数）
### 1.9 Variables（変数）
### 1.10 Variables（変数）
### 1.11 Variables（変数）
### 1.12 Variables（変数）
### 1.13 Variables（変数）
### 1.14 まとめ

## よく使う表現
3項演算子

## 3 プラットフォーム

Null Safety
https://zenn.dev/kazutxt/books/flutter_practice_introduction/viewer/48_chapter6_nullsafety

Async

## 2 ライブラリ

## 4 その他リソース


https://dart.dev/language/class-modifiers#abstract

### 1.14 その他、重要なポイント
Dart言語を学ぶ上で、次のDart言語の概念を把握してください。

  - 全ての変数はそれぞれがobjectです。numbers, functions, and null など、全てです。また、null以外はfrom the Object クラスを継承しています。
  
  Version note
  Null safety was introduced in Dart 2.12. Using null safety requires a language version of at   least 2.12.
  
  - Although Dart is strongly typed, type annotations are optional because Dart can infer types.   In var number = 101, number is inferred to be of type int.
  
  - If you enable null safety, variables can't contain null unless you say they can. You can make   a variable nullable by putting a question mark (?) at the end of its type. For example, a   variable of type int? might be an integer, or it might be null. If you know that an expression   never evaluates to null but Dart disagrees, you can add ! to assert that it isn't null (and to   throw an exception if it is). An example: int x = nullableButNotNullInt!
  
  - When you want to explicitly say that any type is allowed, use the type Object? (if you've   enabled null safety), Object, or—if you must defer type checking until runtime—the special   type dynamic.
  
  - Dart supports generic types, like List<int> (a list of integers) or List<Object> (a list of   objects of any type).
  
  - Dart supports top-level functions (such as main()), as well as functions tied to a class or   object (static and instance methods, respectively). You can also create functions within   functions (nested or local functions).
  
  - Similarly, Dart supports top-level variables, as well as variables tied to a class or object   (static and instance variables). Instance variables are sometimes known as fields or   properties.
  
  Unlike Java, Dart doesn't have the keywords public, protected, and private. If an identifier   starts with an underscore (_), it's private to its library. For details, see Libraries and   imports.
  
  - Identifiers can start with a letter or underscore (_), followed by any combination of those   characters plus digits.
  
  - Dart has both expressions (which have runtime values) and statements (which don't). For   example, the conditional expression condition ? expr1 : expr2 has a value of expr1 or expr2.   Compare that to an if-else statement, which has no value. A statement often contains one or   more expressions, but an expression can't directly contain a statement.
  
  - Dart tools can report two kinds of problems: warnings and errors. Warnings are just   indications that your code might not work, but they don't prevent your program from executing.   Errors can be either compile-time or run-time. A compile-time error prevents the code from   executing at all; a run-time error results in an exception being raised while the code   executes.