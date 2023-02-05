#!/bin/bash

rm -r ../../../results/base/
mkdir -p ../../../results/base/

CUDA_VISIBLE_DEVICES=0,1,2,3 fairseq-train \
    ../../../data/clean250-bin \
    --fp16 \
    --save-interval-updates 100 \
    --update-freq 125 \
    --max-tokens 4096 \
    --arch transformer \
    --encoder-attention-heads 8 \
    --encoder-embed-dim 512 \
    --encoder-layers 6 \
    --encoder-ffn-embed-dim 2048 \
    --decoder-attention-heads 8 \
    --decoder-embed-dim 512 \
    --decoder-layers 6 \
    --decoder-ffn-embed-dim 2048 \
    --dropout 0.3 \
    --optimizer adam --adam-betas '(0.9,0.98)' --adam-eps 1e-8\
    --lr 1e-3 --lr-scheduler inverse_sqrt --warmup-init-lr 1e-07 --warmup-updates 4000 \
    --clip-norm 1.0 --weight-decay 0.01 \
    --criterion label_smoothed_cross_entropy --label-smoothing 0.1 \
    --patience 10 \
    --no-epoch-checkpoints \
    --save-dir ../../../results/base/checkpoints/ | tee -a ../../../results/base/train.log
