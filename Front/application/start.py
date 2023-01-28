# Fairseq v0.10.2
# translate/resultsディレクトリの中に学習済みモデルと辞書を入れることで動きます.

import os
from flask import Flask
from flask import render_template, request

import shutil
import unicodedata
from fairseq.models.transformer import TransformerModel
import sentencepiece as spm

app = Flask(__name__)

# --- PATH settings ---
preprocess_dir = "../translate/datasets/small_parallel_enja/sentencepiece/fairseq-preprocess"
model_dir = "../translate/results"
model_name = "checkpoint_best.pt"
spm_en = "../translate/pre-trained/enja_spm_models/spm.en.nopretok.model"

if os.path.isfile(f'{model_dir}/dict.en.txt') == False:
    shutil.copy(f'{preprocess_dir}/dict.en.txt', f'{model_dir}')

if os.path.isfile(f'{model_dir}/dict.ja.txt') == False:
    shutil.copy(f'{preprocess_dir}/dict.ja.txt', f'{model_dir}')

model = TransformerModel.from_pretrained(model_dir, checkpoint_file=model_name, data_name_or_path=model_dir)
spm_model = spm.SentencePieceProcessor(model_file=spm_en)

# アクセス時の処理.
@app.route("/")
def index():
        return render_template('index.html')	# htmlを表示.

# postされた時の処理.
@app.route('/', methods=['post'])
def translate():

        src = request.form['source-text']       # 上書きx.
        tgt = ''

        # ソース文が存在するかを確認.
        if src is None:
            tgt = ''
            return render_template('index.html', src=src, tgt=tgt)

        # 原文の1文字目を大文字にする.
        src = src.capitalize()

        # NFKC正規化
        src = unicodedata.normalize("NFKC", src)

        # spmの前処理
        spm_en = spm_model.encode(src, out_type=str)
        spm_en = ' '.join(spm_en)

        # 翻訳
        spm_ja = model.translate(spm_en)
        tgt = spm_ja.replace('▁', '').replace(' ', '')

        return render_template('index.html', src=src, tgt=tgt)

if __name__ == "__main__":
        app.run()
