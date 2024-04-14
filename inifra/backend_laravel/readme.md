#LMS
https://terakoya.sejuku.net/programs/92/chapters

#SAMURAI教材
#https://terakoya.sejuku.net/programs/92/chapters

#環境構築手順
１．docker環境確認
dockerでコンテナ起動後、画面確認
１－１．
http://localhost:4001
info.php
http://localhost:4002
phpmyadmin

２．laravel9 のインストール
srcフォルダ内を空削除

dockerコンテナに入る
docker-compose run -it samurai-php-amazon1-php sh


２－１．
Laravelのインストール
composer create-project "laravel/laravel=9.*" .
composer install

php artisan key:generate

２－２．動作確認
http://localhost:4001



