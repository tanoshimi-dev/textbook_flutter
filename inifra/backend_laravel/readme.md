1.phpコンテナに入り、ライブラリなどのインストール
  docker compose exec -it backend-php sh
  composer install

2.envファイルをコピー
  .env.exampleのファイル名を.envに修正する

3.artisanコマンドの実行
  php artisan key:generate

4.画面からAPI動作確認
  # JSONを返す
  http://localhost:15011/api/hello
  http://localhost:15011/api/messages

  # DBデータを返す
  http://localhost:15011/api/menus

5.画面からDBデータの確認や、テーブル追加など
  http://localhost:15021/

  DB接続ユーザーなどはdocker-compose.yamlを参照してください
  

## その他
1. DBを初期化する場合
   dbフォルダ内のdataフォルダ毎削除したうえで、"docker compose up" してください。初回のみdataフォルダが作成されます。 

2. バックエンドのAPIを追加する場合
   以下を実施してください（Laravelのお作法）
   2.1 ルーティングの追記
       src/routes/api.php に追記
   2.2 コントローラークラスの追記
       src/Http/Controllers/Api/HelloController.phpなどにメソッド追加
       ※2.1で任意のControllerクラスを呼び出す事ができます。現状は全てHelloControllerクラスを呼び出すような定義です
