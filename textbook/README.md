# 使い方

## 初期設定

初回のみ、「npm install」を実行してください。「node_modules」フォルダが作成されます。
```bash
npm install
```

## ローカル環境で起動する
以下を実行するとブラウザが起動します。
[http://localhost:3000](http://localhost:3000) にアクセスすることで画面表示されます。

```bash
npm run dev
```

## ビルドして静的htmlを出力する
以下を実行すると、「out」ディレクトリにビルド済みのファイルが出力されます。

「out」ディレクトリ配下の全ての資材を、webの公開ディレクトリに格納するとwebサーバーで表示されます。
```bash
npm run export
```

## コンテンツを編集する

**※編集はWindowsPCで実施することをおススメします。MacPCだとサイドメニューが表示されません（原因特定できていません）**

Topページを編集する場合は、src/index.mdを編集してください。

カテゴリ（Flutter1や、Dockerなどのカテゴリ）を追加する場合は、pages/_app.jsx を編集してください。

カテゴリ内のページを追加・編集する場合は、pages/docs/コンテンツフォルダ/xxx.md を編集してください。

---------


## License

TailwindUIを使用しています。
This site template is a commercial product and is licensed under the [Tailwind UI license](https://tailwindui.com/license).

## Learn more

その他、以下の資材を使用しています。
- [Tailwind CSS](https://tailwindcss.com/docs) - the official Tailwind CSS documentation
- [Next.js](https://nextjs.org/docs) - the official Next.js documentation
- [Headless UI](https://headlessui.dev) - the official Headless UI documentation
- [Markdoc](https://markdoc.io) - the official Markdoc documentation
- [DocSearch](https://docsearch.algolia.com) - the official DocSearch documentation
