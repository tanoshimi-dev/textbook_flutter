1.phpコンテナに入り、ライブラリなどのインストール
  docker compose exec -it backend-php sh
  composer install

2.envファイルをコピー
  .env.exampleのファイル名を.envに修正する

3.artisanコマンドの実行
  php artisan key:generate

4.画面からAPI動作確認
  http://localhost:15011/api/hello
  http://localhost:15011/api/messages




