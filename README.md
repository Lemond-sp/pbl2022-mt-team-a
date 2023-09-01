# pbl2022-mt-team-a
- 愛媛大学工学部・学部共通PBL2022
- 言語処理グループ(機械翻訳A班)による成果物
- 英日翻訳アプリケーションの開発
- wmt20 ニュース記事における英日翻訳タスク
- JParaCrawl v3.0(big)をfine-tuningしたもので評価
- 学習データはnews-crawl(ja.2021)を逆翻訳したもの
# 翻訳アプリ(Linked-Ling)
## Linked-Ling
- 英日翻訳アプリケーションを開発
- 言語的につながる(Linguistically Linked)で命名

![](data/image/app_exp%20_news.png)<br>
## 開発
1.フロント部分
- HTML+CSS+JSによる翻訳サイトの作成
- シンプル・分かりやすいデザイン

2.バック部分
- Python(Flask)による翻訳器と翻訳サイトの接続
- 入力した英語の１文字目を大文字変換、表記ゆれの抑制
- 入力文に対するNFKC正規化
# 翻訳モデルの学習
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
## データの準備
検証・学習データのwmt20のデータセットをダウンロード
```
sacrebleu -t wmt20 -l en-ja --echo src > wmt.test.en
sacrebleu -t wmt20 -l en-ja --echo ref > wmt.test.ja
sacrebleu -t wmt20/dev -l en-ja --echo src > wmt.valid.en
sacrebleu -t wmt20/dev -l en-ja --echo ref > wmt.valid.ja
```
### 逆翻訳
学習データとして、news-crawl(ja.2021)のデータをJParaCrawl v3.0(big)で日英翻訳したものを利用
- NFKC正規化
- 入出力より、文長の長いものを削除
- 文長比率が極端に高い(低い)ものを削除
- データ数を50万に制限

## データの訓練
[pbl_fairseq_en2ja_big-3.0.ipynb](https://github.com/Lemond-sp/pbl2022-mt-team-a/blob/main/data/scripts/colab/pbl_fairseq_en2ja_big-3.0.ipynb)を参照
## データの評価
```
sacrebleu $TARGET_PATH -i output.txt --tokenize ja-mecab
```
# アプリケーションの実行・確認
### アプリの起動
- app.py の model の path を適切なものに書き換えてください
```
cd application
python app.py
```

# ngrok を利用して Flask で立ち上げたアプリケーションを外部に公開
1.ngrok の公式サイトから linux version のものを install して 解凍

2.nginx が入ってなかったら install

3.以下のコマンドを入力し, localhost:5000 を外部に公開する

```
cd [ngrokをインストールして解凍したディレクトリ]
./ngrok http 5000
python app.py
```
