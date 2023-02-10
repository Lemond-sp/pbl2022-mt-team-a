# pbl2022-mt-team-a
- 愛媛大学工学部・学部共通PBL2022
- 言語処理グループ(機械翻訳A班)による成果物
- 英日機械翻訳アプリケーションの開発
- wmt20 ニュース記事における英日翻訳タスク
- JParaCrawl v3.0(big)をfine-tuningしたもので評価
- 学習データはnews-crawl(ja.2021)を逆翻訳したもの

## Dataset

| 学習データ  | 検証データ | 評価データ  |
| ------------- | ------------- | ------------- |
|news-crawl(ja.2021)を逆翻訳  | wmt20(en)  | wmt20(en)  |
| 500,000  |  1,998 |  1,000|

## Setup
仮想環境作成後、以下のコードを実行してください
```
pip install -r requirements.txt
```

*Python・notebookどちらのコードも配布
