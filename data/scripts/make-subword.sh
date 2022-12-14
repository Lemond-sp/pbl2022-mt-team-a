# make-subword.sh

#!/bin/bash

mkdir -p ../unigram-corpus
mkdir -p ../../spm-model

# sentencepiece model の学習
#spm_train --input=../raw-corpus/train_clear.ja --model_prefix=../../spm-model/spm.ja --vocab_size=32000 --character_coverage=0.9995 --model_type=unigram
#spm_train --input=../raw-corpus/train_clear.en --model_prefix=../../spm-model/spm.en --vocab_size=32000 --character_coverage=1.0 --model_type=unigram --input_sentence_size=22000000 --shuffle_input_sentence=true --train_extremely_large_corpus=true

# enja同時に学習する方法
# train時にembeddingを共有する
spm_train --input=../raw-corpus/train_clear.enja --model_prefix=../../spm-model/spm.enja --vocab_size=32000 --character_coverage=0.9995 --model_type=unigram

for lang in enja
do
    for type in train_clear valid test
    do
    spm_encode --model=../../spm-model/spm.$lang.model --output_format=piece < ../raw-corpus/$type.$lang > ../unigram-corpus/$type.$lang
    done
done
