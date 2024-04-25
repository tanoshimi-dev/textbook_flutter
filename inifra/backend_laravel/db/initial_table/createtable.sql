SET CHARSET UTF8;
CREATE DATABASE IF NOT EXISTS flutter_backend DEFAULT CHARACTER SET utf8;

USE flutter_backend;

DROP TABLE IF EXISTS menus;

CREATE TABLE menus
(
  id           INT(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name         VARCHAR(60) NOT NULL,
  price        INT(10) NULL,
  description  VARCHAR(600) NULL
);

INSERT INTO menus (id, name, price, description) VALUES (NULL, "蜂蜜アイスコーヒー",600 ,"蜂蜜の香りと甘みがコーヒーの旨味をぐっと引きたてます。※本商品には「はちみつ」を使用しているため、1歳未満の乳児には与えないで ください。");
INSERT INTO menus (id, name, price, description) VALUES (NULL, "プレミアムコーヒー Sophia",600 ,"程よい苦味とやわらかな酸味雑味がなく、コクはありながらすっきりとした後味。※ストレートでお楽しみいただくためフレッシュはお付けしておりません。※店舗により販売状況が異なります　詳しくは店舗にご確認ください");
INSERT INTO menus (id, name, price, description) VALUES (NULL, "シロノワール", 770, "あつあつひえひえの温度差が楽しい、コメダの名物デザートです。※シロノワールのシロップには「はちみつ」が含まれているため、1歳未満の乳児には与えないでください。");
INSERT INTO menus (id, name, price, description) VALUES (NULL, "シロノワール　ガーナミルク（単品）", 870, "ガーナミルクチョコレートと、シロノワールのコラボレーション。ミルク感の効いたチョコソースとデニッシュが絶妙にマッチ。※本商品にアルコールは使用しておりません。");
INSERT INTO menus (id, name, price, description) VALUES (NULL, "クロネージュ　ガーナミルク（単品）", 720, "ガーナミルクチョコレートと、クロネージュのコラボレーション。ココアバウムクーヘンがカカオ風味を引き立て、ほんのりビターな味わい。※本商品にアルコールは使用しておりません。");
INSERT INTO menus (id, name, price, description) VALUES (NULL, "カツカリーパン", 990, "スパイシーな特製カリーソースと揚げたてサクサクビッグカツがクセになる美味しさです。※やや辛めの商品です。辛い物が苦手な方やお子さまはご注意ください。");
INSERT INTO menus (id, name, price, description) VALUES (NULL, "みそカツパン", 990, "揚げたてサクサクビッグカツを名古屋名物濃厚みそダレと合わせてサンドしました。");
INSERT INTO menus (id, name, price, description) VALUES (NULL, "ヒレカツ", 1400, "柔らかヒレ肉をサクッと揚げたボリューム満点まんぷくメニューです。※店舗により販売状況が異なります　詳しくは店舗にご確認ください");
INSERT INTO menus (id, name, price, description) VALUES (NULL, "ジェリコ　ガーナミルク", 680, "ガーナチョコドリンクの味わいを特製のほろ苦いコーヒージェリーと楽しむデザートドリンク。※本商品にアルコールは使用しておりません。");
INSERT INTO menus (id, name, price, description) VALUES (NULL, "北海道あずきミルク", 120, "ミルク風味の濃厚なパウンドケーキに、かの子豆を入れたコメダオリジナルのおやつです。※販売は店舗により異なります。");
INSERT INTO menus (id, name, price, description) VALUES (NULL, "しるこサンド", 120, "※本商品には「はちみつ」を使用しているため、1歳未満の乳児には与えないでください。※販売は店舗により異なります。");
INSERT INTO menus (id, name, price, description) VALUES (NULL, "コどら", 140, "北海道産小豆を氷砂糖で炊き上げたこだわりの餡を、ふっくらと口溶けの良い生地で包みました。※本商品には「はちみつ」を使用しているため、1歳未満の乳児には与えないでください。※販売は店舗により異なります。");
INSERT INTO menus (id, name, price, description) VALUES (NULL, "あまんぶらん（単品）", NULL, NULL);
INSERT INTO menus (id, name, price, description) VALUES (NULL, "米粉しふぉん（単品）", NULL, NULL);
INSERT INTO menus (id, name, price, description) VALUES (NULL, "北の大地のフロマージュ（単品）", NULL, NULL);
INSERT INTO menus (id, name, price, description) VALUES (NULL, "鶏タツタバーガー", NULL, NULL);
INSERT INTO menus (id, name, price, description) VALUES (NULL, "カフェモカフィーユ（単品）", NULL, NULL);
