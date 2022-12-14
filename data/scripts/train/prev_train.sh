#!/bin/bash
rm -r ../../results/base/
mkdir -p ../../results/base/

CUDA_VISIBLE_DEVICES=0,1,2,3 fairseq-train \
    ../../data/clean250-bin \
    --fp16 \
    --save-interval-updates 2000 \
    --validate-interval-updates 2000 \
    --validate-interval 9999 \
    --update-freq 2 \
    --max-tokens 4096 \
    --arch transformer \
    --encoder-attention-heads 8 \
    --encoder-layers 6 \
    --decoder-attention-heads 8 \
    --decoder-layers 6 \
    --dropout 0.1 \
    
    --optimizer adam \
    --lr 3e-5 --lr-scheduler inverse_sqrt --warmup-init-lr 1e-07 --warmup-updates 4000 \
    --clip-norm 1.0 --weight-decay 0.01 \
    --criterion label_smoothed_cross_entropy --label-smoothing 0.1 \
    --patience 10 \
    --no-epoch-checkpoints \
    --best-checkpoint-metric bleu --maximize-best-checkpoint-metric \
    --eval-bleu \
    --eval-bleu-args '{"beam": 5,"lenpen": 1.0}' \
    --eval-bleu-detok space \
    --eval-bleu-remove-bpe=sentencepiece \
    --save-dir ../../results/base/checkpoints/ | tee -a ../../results/base/train.log
